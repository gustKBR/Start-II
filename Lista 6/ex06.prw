#INCLUDE "TOTVS.CH"


User Function M030INC()
              
    Local aArea     := GetArea()
    Local aAreaSA1  := SA1->(GetArea())
    Local lRet      := .T.

    if INCLUI
        SA1->A1_MSBLQL := "1"
    endif

    RestArea(aArea)
    RestArea(aAreaSA1)
    
Return lRet
