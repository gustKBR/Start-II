#INCLUDE "TOTVS.CH"


User Function EX11_L5()

    Local aA        := {1, 2, 3, 4, 5, 6, 7, 8, 9, 10} 
    Local aB        := {} 
    Local nI        := 0
    Local nNum      := ""

    for nI := 1 to 10
        nNum += aA[nI]
        AADD(aB, (nNum))
    next nI
         
    FwAlertInfo("Matriz A: " + ArrTokStr(aA, ", ") + CRLF + "Matriz B: " + ArrTokStr(aB, ", "), "Valores do array")

Return
