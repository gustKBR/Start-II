#INCLUDE "TOTVS.CH"


User Function EX8_L5()

    Local aArray    := {} 
    Local nI        := 0

    for nI := 8 to 1 step -1
        AADD(aArray, nI)
    next nI

    for nI := 1 to 8
        aDel(aArray, 1)
    next nI

    aSize(aArray, 8)

    FwAlertInfo(ArrTokStr(aArray))

Return
