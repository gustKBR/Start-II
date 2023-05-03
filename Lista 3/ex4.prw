#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE C_GRUPO     "99"
#DEFINE C_FILIAL    "01"

User Function EX4_L3()

    Local aArea   := GetArea()
    Local cAlias  := GetNextAlias()
    Local cQuery  := ""
    Local cMsg    := ""
    Local cGrupo  := "0008"
    Local cDescri := ""

    RpcSetEnv(C_GRUPO, C_FILIAL)

    cQuery := "SELECT B1_DESC" + CRLF
    cQuery += "FROM " + RetSqlName("SB1") + CRLF
    cQuery += "WHERE B1_GRUPO = '" + cGrupo + "'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())

        cDescri := &(cAlias)->(B1_DESC)

        cMsg += "Descrição: " + cDescri + CRLF
        cMsg += "------------------------------" + CRLF

        &(cAlias)->(DbSkip())
    
    enddo

    FwAlertInfo(cMsg, "Produtos do grupo de películas")

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return
