#INCLUDE "TOTVS.CH"


User Function EX12_L5()

    Local aA        := {} 
    Local aB        := {} 
    Local nI        := 0

    for nI := 1 to 5
        AADD(aA, nI)
        AADD(aB, (aA[nI] * -1))
    next nI
    
    FwAlertInfo(ArrTokStr(aB), "Valores do Array")

Return
