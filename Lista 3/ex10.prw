#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE C_GRUPO     "99"
#DEFINE C_FILIAL    "01"

User Function EX10_L3()

    Local aArea     := GetArea()
    Local cAlias    := GetNextAlias()
    Local cQuery    := ""
    Local cCodigo   := ""
    Local cProd     := ""
    Local nQtdVen   := 0
    Local nCont     := 0
    Local nMedia    := 0

    RpcSetEnv(C_GRUPO, C_FILIAL)

    cCodigo := FwInputBox("Consulta de Produto", "Informe o código do produto")

    cQuery := "SELECT C6_PRODUTO, C6_DESCRI, C6_QTDVEN" + CRLF
    cQuery += "FROM " + RetSqlName("SC6")

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())
    
    while &(cAlias)->(!EOF())

        cProd := &(cAlias)->(C6_PRODUTO)
        nQtdVen := &(cAlias)->(C6_QTDVEN)

        if cCodigo == AllTrim(cProd)
            nMedia += nQtdVen
            nCont++
        endif

        &(cAlias)->(DbSkip())
        
    enddo

    nMedia := nMedia / nCont

    FwAlertInfo("A média de quantidade desse item em pedidos de venda é " + cValToChar(nMedia), "Média de quantidade")
    
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return
