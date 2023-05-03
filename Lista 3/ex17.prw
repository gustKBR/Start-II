#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

User Function EX17_L3()

    Local cNome    := ""
    Local cMsg     := ""
    Local nCont    := 0

    cNome := FwInputBox("Digite um nome")

    for nCont := 1 to len(cNome)
        cMsg += UPPER(SUBSTR(cNome, nCont, 1)) + CRLF
    next nCont

    FwAlertInfo("Nome: " + cNome + CRLF + ;
    "Nome na vertical: " + CRLF + cMsg, "Nome na vertical")

Return
