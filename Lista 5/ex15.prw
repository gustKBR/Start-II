#INCLUDE "TOTVS.CH"


User Function EX15_L5()

    Local aArray    := {13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2}
    Local nI        := 0
    Local nJ        := 0
    Local nAux      := 0

    for nJ := 1 to len(aArray)
        for nI := 1 to len(aArray)
            if aArray[nI] > aArray[nJ]
                nAux := aArray[nJ]
                aArray[nJ] := aArray[nI]
                aArray[nI] := nAux
            endif
        next
    next

    FwAlertInfo(ArrToKStr(aArray, ", "), "Conteúdo do Array")

Return
