#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

User Function EX14_L3()

    Local aNum  := {}
    Local nNum  := 0
    Local nI    := 0
    Local cMsg  := ""

    for nI := 1 to 5
        nNum := Val(FwInputBox("Digite um número"))
        AADD(aNum, nNum)
    next nI

    for nI := 1 to len(aNum)
        if nI >= len(aNum)
            cMsg += cValToChar(aNum[nI])
        else
            cMsg += cValToChar(aNum[nI]) + ", "
        endif
    next nI

    FwAlertInfo(cMsg)

Return
