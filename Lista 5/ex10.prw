#INCLUDE "TOTVS.CH"


User Function EX10_L5()

    Local aA        := {} 
    Local aB        := {} 
    Local aC        := {} 
    Local nI        := 0
    local cMsg      := ""

    for nI := 1 to 10
        AADD(aA, nI)
        AADD(aC, aA[nI])
    next nI

    for nI := 1 to 15
        AADD(aB, nI)
        AADD(aC, aB[nI])
    next nI
    
    for nI := 1 to len(aC)
        if nI < len(aC)
            cMsg += cValToChar(aC[nI]) + ", "
        else
            cMsg += cValToChar(aC[nI]) + "."
        endif
    next nI

    FwAlertInfo(cMsg, "Valores do array")

Return
