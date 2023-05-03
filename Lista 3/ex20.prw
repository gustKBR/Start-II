#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

User Function EX20_L3()

    Local cTipoGrp      := M->B1_TIPO
    Local cMsg          := ""

    if cTipoGrp == "MP"
        cMsg := "Mat�ria Prima Produ��o"
    elseif cTipoGrp == "PA"
        cMsg := "Produto para Comercializa��o"
    else
        cMsg := "Outros Produtos"
    endif

Return cMsg
