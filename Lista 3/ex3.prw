#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE C_GRUPO     "99"
#DEFINE C_FILIAL    "01"

User Function EX3_L3()

    Local aArea     := GetArea()
    Local cAlias    := GetNextAlias()
    Local cQuery    := ""
    Local cMsg      := ""
    Local cProd     := ""
    Local cDesc     := ""
    Local cQtd      := ""
    Local cVlUnit   := ""
    Local cVlTotal  := ""
  
    RpcSetEnv(C_GRUPO, C_FILIAL)

    cQuery := "SELECT C6_PRODUTO, C6_DESCRI, C6_QTDVEN, C6_PRCVEN, C6_VALOR" + CRLF
    cQuery += "FROM " + RetSqlName("SC6") + CRLF
    cQuery += "INNER JOIN " + RetSqlName("SC5") + CRLF
    cQuery += "ON C5_NUM = C6_NUM" + CRLF
    cQuery += "WHERE C5_NUM = 'PV0008'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())

        cProd     := &(cAlias)->(C6_PRODUTO)
        cDesc     := &(cAlias)->(C6_DESCRI)
        cQtd      := &(cAlias)->(C6_QTDVEN)
        cVlUnit   := &(cAlias)->(C6_PRCVEN)
        cVlTotal  := &(cAlias)->(C6_VALOR)

        cMsg += "Código - Descrição - Qtd - Vl. Unit - Vl Total: " + CRLF
        cMsg += cProd + " - " + cDesc + " - " + cValToChar(cQtd) + " - " + cValToChar(cVlUnit) + " - " + cValToChar(cVlTotal) + CRLF
        cMsg += "------------------------------" + CRLF
            
        &(cAlias)->(DbSkip())

    enddo
  
    FwAlertInfo(cMsg, "Produtos do pedido PV0008")
    
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
    
Return
