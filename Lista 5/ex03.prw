#INCLUDE "TOTVS.CH"


User Function EX3_L5()

    Local aArray    := {} 
    Local nI        := 0
    local cMsg      := ""

    for nI := 1 to 30
        AADD(aArray, nI)
    next nI

    for nI := 1 to 30
        if nI < 30
            cMsg += cValToChar(aArray[nI]) + ", "
        else
            cMsg += cValToChar(aArray[nI]) + "."
        endif
    next nI

    FwAlertInfo(cMsg, "Valores do array")

Return
