#INCLUDE "TOTVS.CH"


User Function MA410COR()

    Local aArea     := GetArea()
    Local aAreaSC5  := SC5->(GetArea())
    Local aCores    := {}

    AADD(aCores, {"Empty(C5_LIBEROK).And.Empty(C5_NOTA)"    , "CHECKOK"})
    AADD(aCores, {"!Empty(C5_NOTA).Or.C5_LIBEROK=='E'"      , "BR_CANCEL"})
    AADD(aCores, {"!Empty(C5_LIBEROK).And.Empty(C5_NOTA)"   , "GCTPIMSE"})

    RestArea(aArea)
    RestArea(aAreaSC5)

Return aCores
