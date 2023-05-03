#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

User Function EX18_L3()

    Local cNome    := ""
    Local cMsg     := ""
    Local nCont    := 0

    cNome := FwInputBox("Digite um nome")

    for nCont := 1 to len(cNome)
        cMsg += UPPER(SUBSTR(cNome, 1, nCont)) + CRLF
    next nCont

    FwAlertInfo(cMsg, "Nome na vertical em escada")

    cMsg := ""

Return
