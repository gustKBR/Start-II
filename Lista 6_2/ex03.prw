#INCLUDE "TOTVS.CH"


User Function MTA410I()

    Local nPosQtd   := aScan(aHeader,{|aAux| AllTrim(aAux[2]) == "C6_DESCRI"})
    Local lRet      := .T.

    if aCols[n][nPosQtd] != "Inc. PE - "
        SC6->C6_DESCRI := AllTrim("Inc. PE - " + SC6->C6_DESCRI)
    endIf

Return lRet
