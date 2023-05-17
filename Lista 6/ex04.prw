#INCLUDE "TOTVS.CH"

User Function MA410LEG()

    Local aArea     := GetArea()
    Local aAreaSC5   := SC5->(GetArea())
    Local aLegenda  := {}
    
    AADD({"CHECKOK",      "Pedido em Aberto"})
    AADD({"BR_CANCEL",    "Pedido Encerrado"})
    AADD({"GCTPIMSE",     "Pedido Liberado"})
    AADD({"BR_AZUL",      "Pedido Bloquado por Regra"})
    AADD({"BR_LARANJA",   "Pedido Bloqueado por Venda"})

    RestArea(aArea)
    RestArea(aAreaSC5)

return aLegenda
