#INCLUDE "TOTVS.CH"


User Function EX9_L5()

    Local aA        := {} 
    Local aB        := {} 
    Local nI        := 0
    Local cMsg      := ""

    for nI := 1 to 8 
        AADD(aA, nI)
        AADD(aB, aA[nI] * 3)
    next nI

    for nI := 1 to 8
        if nI < 8
            cMsg += cValToChar(aB[nI]) + ", "
        else
            cMsg += cValToChar(aB[nI]) + "."
        endif
    next nI

    FwAlertInfo(cMsg, "Valores do array")

Return
