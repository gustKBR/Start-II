#INCLUDE "TOTVS.CH"


User Function EX2_L5()

    Local aArray    := {}
    Local nVal      := 0
    Local nI        := 0

    for nI := 1 to 10
        nVal := Val(FwInputBox("Digite o " + AllTrim(cValToChar(nI)) +"� elemento: "))
        AADD(aArray, nVal)
    next nI

    for nI := 10 to 1 step -1
        FwAlertInfo("Posi��o " + AllTrim(cValToChar(nI)) + ": " + AllTrim(aArray[nI]))
    next nI

Return
