#INCLUDE "TOTVS.CH"


User Function EX7_L5()

    Local aA        := {} 
    Local aB        := {} 
    Local nI        := 0
    Local cMsg      := ""

    for nI := 1 to 15
        AADD(aA, nI)
    next nI

    for nI := 15 to 1 step - 1
        AADD(aB, nI)
    next nI

    for nI := 1 to 15
        if nI < 15
            cMsg += cValToChar(aB[nI]) + ", "
        else
            cMsg += cValToChar(aB[nI]) + ". "
        endif
    next nI

    FwAlertInfo(cMsg, "Valores do array")

Return
