#INCLUDE "TOTVS.CH"


User Function A410EXC()

    Local aArea     := GetArea()
    Local aAreaSC5  := SC5->(GetArea())
    Local lRet      := .T.

    if SC5->C5_TIPOINC == "Automatico"
        lRet := .F.
    endif

    RestArea(aArea)
    RestArea(aAreaSC5)
    
Return lRet
