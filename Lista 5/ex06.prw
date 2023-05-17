#INCLUDE "TOTVS.CH"


User Function EX6_L5()

    Local aA        := {1, 2, 3, 4, 5, 6, 7, 8, 9, 10} 
    Local aB        := {10, 20, 30, 40, 50, 60, 70, 80, 90, 100} 
    Local aC        := {} 
    Local nI        := 0
    Local cMsg      := ""

    for nI := 1 to 10
        AADD(aC, aA[nI])
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
