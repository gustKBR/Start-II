#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

User Function EX20_L3()

    Local cTipoGrp      := M->B1_TIPO
    Local cMsg          := ""

    if cTipoGrp == "MP"
        cMsg := "Matéria Prima Produção"
    elseif cTipoGrp == "PA"
        cMsg := "Produto para Comercialização"
    else
        cMsg := "Outros Produtos"
    endif

Return cMsg
