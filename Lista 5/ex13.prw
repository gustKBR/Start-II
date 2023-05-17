#INCLUDE "TOTVS.CH"


User Function EX13_L5()

    Local aArray := {} 

    PopulaVet(aArray)

    FwAlertInfo(ArrTokStr(aArray, ", "), "Valores do Array")

Return


Static Function PopulaVet(aArray)

    Local nI := 0

    for nI := 1 to 50
        AADD(aArray, CHR(RANDOMIZE(65,90)))
    next nI
         
Return 
