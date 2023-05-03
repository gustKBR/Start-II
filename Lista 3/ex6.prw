#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE C_GRUPO     "99"
#DEFINE C_FILIAL    "01"

User Function EX6_L3()

    Local aArea     := GetArea()
    Local cAlias    := GetNextAlias()
    Local cQuery    := ""
    Local cMsg      := ""
    Local cCodigo   := ""
    Local cDesc     := ""
    Local cPrecoVen := ""

    RpcSetEnv(C_GRUPO, C_FILIAL)

    cCodigo := FwInputBox("Consulta de Produto", "Informe o código do produto")

    cQuery := "SELECT B1_COD, B1_DESC, B1_PRV1" + CRLF
    cQuery += "FROM " + RetSqlName("SB1") + CRLF
    cQuery += "WHERE B1_COD = '" + cCodigo + "'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())

        cDesc := &(cAlias)->(B1_DESC)
        cPrecoVen := &(cAlias)->(B1_PRV1)

        if cCodigo == AllTrim(&(cAlias)->(B1_COD))
            cMsg += "Código: " + cCodigo + CRLF
            cMsg += "Descrição: " + cDesc + CRLF
            cMsg += "Preço de Venda: " + cValToChar(cPrecoVen) + CRLF

            &(cAlias)->(DbSkip())
        endif

    enddo

    if EMPTY(cDesc)
        FwAlertError("Não há produtos com o código digitado", "Atenção")
    else
        FwAlertInfo(cMsg, "Produto com o código digitado")
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return
