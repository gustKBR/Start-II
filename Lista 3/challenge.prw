#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE C_GRUPO     "99"
#DEFINE C_FILIAL    "01"

User Function L3_CHALLENGE()

    Local aArea     := GetArea()
    Local cAlias    := GetNextAlias()
    Local cQuery    := ""
    Local cMsg      := ""
    Local cCodigo   := ""
    Local cTipoGrp  := ""

    RpcSetEnv(C_GRUPO, C_FILIAL)

    cQuery := "SELECT B1_COD, B1_DESC, B1_TIPO, B1_ZZGRP" + CRLF
    cQuery += "FROM " + RetSqlName("SB1") + CRLF
    cQuery += "WHERE B1_ZZGRP = ' '"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    DbSelectArea("SB1")
    DbSetOrder(2)

    while &(cAlias)->(!EOF())

        cCodigo := &(cAlias)->(B1_COD)
        cTipoGrp := &(cAlias)->(B1_TIPO)

        if cTipoGrp == "MP"
            cMsg := "Matéria Prima Produção"
        elseif cTipoGrp == "PA"
            cMsg := "Produto para Comercialização"
        else
            cMsg := "Outros Produtos"
        endif

        if DbSeek(xFilial("SB1") + cTipoGrp + cCodigo)
            Reclock("SB1", .F.)
            SB1->B1_ZZGRP := cMsg
            MsUnlock()
        endif

        &(cAlias)->(DbSkip())
    
    enddo

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return
