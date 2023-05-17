#INCLUDE "TOTVS.CH"

#DEFINE CLR_PRETO       RGB(0, 0, 0)
#DEFINE CLR_VERMELHO    RGB(255, 0, 0)

User Function MBlkColor()

    Local aRet := {}
 
    aAdd(aRet, (CLR_VERMELHO))
    aAdd(aRet, (CLR_PRETO))
 
Return aRet
