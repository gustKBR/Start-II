#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE C_GRUPO     "99"
#DEFINE C_FILIAL    "01"

User Function EX12_L3()

    Local aArea         := GetArea()
    Local cAlias        := GetNextAlias()
    Local cQuery        := ""
    Local cMsg          := ""
    Local aDesc         := {}
    Local aPrecoVen     := {}

    RpcSetEnv(C_GRUPO, C_FILIAL)

    cQuery := "SELECT B1_DESC, B1_PRV1" + CRLF
    cQuery += "FROM " + RetSqlName("SB1") + CRLF
    cQuery += "ORDER BY B1_PRV1 ASC"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())
    
    while &(cAlias)->(!EOF())

        AADD(aDesc, &(cAlias)->(B1_DESC))
        AADD(aPrecoVen, &(cAlias)->(B1_PRV1))

        &(cAlias)->(DbSkip())
        
    enddo

    cMsg += "O produto com menor preço de venda é " + aDesc[1] + " no valor de R$" + cValToChar(aPrecoVen[1]) + CRLF
    cMsg += "O produto com maior preço de venda é " + aDesc[len(aDesc)] + " no valor de R$" + cValToChar(aPrecoVen[len(aPrecoVen)]) + CRLF

    FwAlertInfo(cMsg, "Maior e menor preço de venda")
    
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return
