#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE C_GRUPO     "99"
#DEFINE C_FILIAL    "01"

User Function EX1_L3()

    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ""
    Local cMsg   := ""
    Local cCod   := ""
    Local nCont  := 1
  
    RpcSetEnv(C_GRUPO, C_FILIAL)

    cQuery := "SELECT *" + CRLF
    cQuery += "FROM " + RetSqlName("SC7") + CRLF
    cQuery += "WHERE C7_FORNECE = '000001'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())
  
    while &(cAlias)->(!EOF())

        cCod  := &(cAlias)->(C7_NUM)

        cMsg += "Pedido " + cValToChar(nCont) + ": " + cCod + CRLF

        &(cAlias)->(DbSkip())
        nCont++
    
    enddo
  
    FwAlertInfo(cMsg, "Pedidos Super Cabos")
    
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
    
Return
