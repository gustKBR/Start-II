#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE C_GRUPO     "99"
#DEFINE C_FILIAL    "01"

User Function EX5_L3()

    Local aArea   := GetArea()
    Local cAlias  := GetNextAlias()
    Local cQuery  := ""
    Local cMsg    := ""
    Local cCodigo := ""
    Local cDesc := ""

    RpcSetEnv(C_GRUPO, C_FILIAL)

    cQuery := "SELECT B1_COD, B1_DESC" + CRLF
    cQuery += "FROM " + RetSqlName("SB1") + CRLF
    cQuery += "ORDER BY B1_DESC DESC"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())

        cCodigo := &(cAlias)->(B1_COD)
        cDesc := &(cAlias)->(B1_DESC)

        cMsg += "Código: " + cCodigo + CRLF
        cMsg += "Descrição: " + cDesc + CRLF
        cMsg += "------------------------------" + CRLF

        &(cAlias)->(DbSkip())

    enddo

    FwAlertInfo(cMsg, "Produtos em ordem decrescente")

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return
