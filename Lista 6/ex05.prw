#INCLUDE "TOTVS.CH"


User Function MT010INC()

    Local aArea     := GetArea()
    Local aAreaSB1  := SB1->(GetArea())
    Local lRet      := .T.

    if INCLUI
        SB1->B1_MSBLQL := "1"
    endif

    RestArea(aArea)
    RestArea(aAreaSB1)
    
Return lRet
