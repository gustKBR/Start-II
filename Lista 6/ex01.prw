#INCLUDE "TOTVS.CH"


User Function MT010ALT()

    Local aArea     := GetArea()
    Local aAreaSB1  := SB1->(GetArea())
    Local lRet      := .F.

    SB1->B1_DESC := AllTrim("Cad. Manual - " + M->B1_DESC)

    RestArea(aArea)
    RestArea(aAreaSB1)

Return lRet


User Function MT010INC()

    Local aArea     := GetArea()
    Local aAreaSB1  := SB1->(GetArea())
    Local lRet      := .F.

    SB1->B1_DESC := AllTrim("Cad. Manual - " + M->B1_DESC)

    RestArea(aArea)
    RestArea(aAreaSB1)

Return lRet
