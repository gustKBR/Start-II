#INCLUDE "TOTVS.CH"


User Function EX4_L5()

    Local aArray    := {} 
    Local nI        := 0
    local cMsg      := ""

    for nI := 2 to 20 step 2
        AADD(aArray, nI)
    next nI

    for nI := 1 to 10
        if nI < 10
            cMsg += cValToChar(aArray[nI]) + ", "
        else
            cMsg += cValToChar(aArray[nI]) + "."
        endif
    next nI

    FwAlertInfo(cMsg, "Valores do array")

Return
