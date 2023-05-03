#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

User Function EX16_L3()

    Local cNome    := ""
    Local cMsg     := ""
    Local nCont    := 0

    cNome := FwInputBox("Digite um nome")

    for nCont := len(cNome) to 1 step -1
        cMsg += UPPER(SUBSTR(cNome, nCont, 1))
    next nCont

    FwAlertInfo("Nome: " + cNome + CRLF + ;
    "Nome ao contrário e maiúsculo: " + cMsg)

Return
