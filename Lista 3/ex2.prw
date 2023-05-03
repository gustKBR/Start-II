#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE C_GRUPO     "99"
#DEFINE C_FILIAL    "01"

User Function EX2_L3()

    Local aArea     := GetArea()
    Local cAlias    := GetNextAlias()
    Local cQuery    := ""
    Local cMsg      := ""
    Local cNomeCli  := ""
    Local cNumPed   := ""
  
    RpcSetEnv(C_GRUPO, C_FILIAL)

    cQuery := "SELECT C5_NUM, A1_NOME" + CRLF
    cQuery += "FROM " + RetSqlName("SC5") + CRLF
    cQuery += "INNER JOIN " + RetSqlName("SA1") + CRLF
    cQuery += "ON C5_CLIENTE = A1_COD" + CRLF
    cQuery += "WHERE C5_NOTA = ''"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())
  
        cNumPed   := &(cAlias)->(C5_NUM)
        cNomeCli  := &(cAlias)->(A1_NOME)

        cMsg += "Pedido: " + cNumPed + CRLF
        cMsg += "Cliente: " + cNomeCli + CRLF
        cMsg += "------------------------------" + CRLF

        &(cAlias)->(DbSkip())
    
    enddo
    
    if cMsg == ''
        FwAlertInfo("Não há pedidos de venda sem nota", "Pedidos de venda sem nota")
    else
        FwAlertInfo(cMsg, "Pedidos de venda sem nota")
    endif
    
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
    
Return
