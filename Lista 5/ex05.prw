#INCLUDE "TOTVS.CH"


User Function EX5_L5()

    Local aA        := {} 
    Local aB        := {} 
    Local aC        := {} 
    Local nI        := 0
    Local cMsg      := ""

    for nI := 1 to 20 
        AADD(aA, RANDOMIZE(1, 40))
        AADD(aB, RANDOMIZE(1, 80))
        AADD(aC, (aA[nI] + aB[nI]))
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
