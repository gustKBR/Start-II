#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"


User Function CadMuni()

    Local aArea     := GetArea()
    Local cAlias    := GetNextAlias()
    Local cQuery    := ""
    Local lRet      := .T.
    Local cMuni     := 0

    cQuery += "SELECT CC2_MUN, COUNT(*) AS MUNI FROM " + RetSqlName("CC2") + CRLF 
    cQuery += "WHERE CC2_EST = '" + M->CC2_EST + "' AND CC2_MUN = '" + AllTrim(M->CC2_MUN) + "' GROUP BY CC2_MUN"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    While &(cAlias)->(!EOF())
        cMuni := &(cAlias)->(MUNI)

        &(cAlias)->(DbSkip())
    enddo 

    if cMuni >= 1 
        FwAlertError("O município já existe para a UF selecionada!")
        lRet := .F.
    endif 

    &(cAlias)->(DbCloseArea())
	RestArea(aArea)

Return lRet 
