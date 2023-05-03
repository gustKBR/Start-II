#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE C_GRUPO     "99"
#DEFINE C_FILIAL    "01"

User Function EX8_L3()

    Local aArea     := GetArea()
    Local cAlias    := GetNextAlias()
    Local cQuery     := ""
    Local cMsg      := ""
    Local cCodigo   := ""
    Local cDesc     := ""
    Local cVlUnit   := ""
    Local cVlTot    := ""

    RpcSetEnv(C_GRUPO, C_FILIAL)

    cQuery := "SELECT TOP 1 C6_PRODUTO, C6_DESCRI, C6_PRCVEN, C6_VALOR" + CRLF
    cQuery += "FROM " + RetSqlName("SC6") + CRLF
    cQuery += "ORDER BY C6_VALOR DESC"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())
    
    while &(cAlias)->(!EOF())

        cCodigo := &(cAlias)->(C6_PRODUTO)
        cDesc := &(cAlias)->(C6_DESCRI)
        cVlUnit := &(cAlias)->(C6_PRCVEN)
        cVlTot := &(cAlias)->(C6_VALOR)

        cMsg += "Código: " + cCodigo + CRLF
        cMsg += "Descrição: " + cDesc + CRLF
        cMsg += "Valor Unitário: " + cValToChar(cVlUnit) + CRLF
        cMsg += "Valor Total: " + cValToChar(cVlTot) 

        &(cAlias)->(DbSkip())
        
    enddo

    FwAlertInfo(cMsg, "Pedido com produto de maior valor")
    
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return
