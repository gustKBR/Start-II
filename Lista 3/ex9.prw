#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE C_GRUPO     "99"
#DEFINE C_FILIAL    "01"

User Function EX9_L3()

    Local aArea     := GetArea()
    Local cAlias    := GetNextAlias()
    Local cQuery    := ""
    Local cMsg      := ""
    Local cCodigo   := ""
    Local cNumPed   := ""

    RpcSetEnv(C_GRUPO, C_FILIAL)

    cCodigo := FwInputBox("Consulta de Produto", "Informe o código do produto")

    cQuery := "SELECT C6_PRODUTO, C6_NUM" + CRLF
    cQuery += "FROM " + RetSqlName("SC6") + CRLF
    cQuery += "WHERE C6_PRODUTO = '" + cCodigo + "'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())
    
    while &(cAlias)->(!EOF())

        cNumPed := &(cAlias)->(C6_NUM)

        cMsg += AllTrim(cNumPed) + ", "

        &(cAlias)->(DbSkip())
        
    enddo

    FwAlertInfo(cMsg, "Pedidos de venda com o código digitado")
    
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return
