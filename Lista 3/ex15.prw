#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

User Function EX15_L3()

    Local aMeses    := {"Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"}
    Local aTemp     := {}
    Local nTemp     := 0
    Local cMsg      := ""
    Local nMedia    := 0
    Local nSoma     := 0
    Local nCont     := 0

    for nCont := 1 to 12
        nTemp := Val(FwInputBox("Digite a média de temperatura de " + aMeses[nCont] + ": "))
        AADD(aTemp, nTemp)
        nSoma += nTemp
    next nCont

    nMedia := nSoma / 12

    for nCont := 1 to 12
        if aTemp[nCont] > nMedia
            cMsg += aMeses[nCont] + ": " + Alltrim(cValToChar(aTemp[nCont])) + "°C" + CRLF
        endif
    next nCont

    FwAlertInfo("A temperatura média anual foi " + cValToChar(nMedia) + "°C" + CRLF + CRLF +;
    "O(s) mes(es) com temperatura acima da média anual foi(ram): " + cMsg, "Temperatura")

Return
