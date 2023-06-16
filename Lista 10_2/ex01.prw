#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "REPORT.CH"


User Function EX1_L102()

    Local oReport := CrialRel()

    oReport:PrintDialog()

Return


Static Function CrialRel()

    Local cAlias := GetNextAlias()
    Local oReport	:= TReport():New("TReport", "Relatório de Pedidos de Venda",,{|oReport| Imprime(oReport, cAlias)}, "Informações de Pedidos de Compra",.F.,,,, .T., .T.)	
    Local oSection1 := TRSection():New(oReport, "Pedidos de Venda",,, .F., .T.)
    Local oSection2 := TRSection():New(oSection1, "Itens do Pedido de Venda",,,.F.,.T.)
    Local oBreak

    TRCell():New(oSection1, "C5_NUM", "SC5", "Nº PEDIDO",, 8,,, "CENTER", .T., "CENTER",,, .T.,,, .T.)
    TRCell():New(oSection1, "A1_NOME", "SA1", "NOME CLIENTE",, 30,,, "LEFT", .T., "LEFT",,, .T.,,, .T.)
    TRCell():New(oSection1, "C5_EMISSAO", "SC5", "DATA EMISSAO",, 14,,, "CENTER", .T., "CENTER",,, .T.,,, .T.)
    TRCell():New(oSection1, "E4_DESCRI", "SE4", "CONDICAO DE PAGAMENTO",, 15,,, "LEFT", .T., "LEFT",,, .T.,,, .T.)

    TRCell():New(oSection2, "C6_ITEM", "SC6", "Nº ITEM",, 8,,, "CENTER", .T., "CENTER",,, .T.,,, .T.)
    TRCell():New(oSection2, "C6_PRODUTO", "SC6", "COD. PRODUTO",, 8,,, "CENTER", .T., "CENTER",,, .T.,,, .T.)
    TRCell():New(oSection2, "C6_DESCRI", "SC6", "DESCRICAO DO PRODUTO",, 30,,, "LEFT", .T., "LEFT",,, .T.,,, .T.)
    TRCell():New(oSection2, "C6_QTDVEN", "SC6", "QTD. VENDIDA",, 4,,, "CENTER", .T., "CENTER",,, .T.,,, .T.)
    TRCell():New(oSection2, "C6_PRCVEN", "SC6", "VALOR UNITARIO",, 10,,, "CENTER", .T., "CENTER",,, .T.,,, .T.)
    TRCell():New(oSection2, "C6_VALOR", "SC6", "VALOR TOTAL",, 10,,, "CENTER", .T., "CENTER",,, .T.,,, .T.)
    
    oBreak := TRBreak():New(oSection1, oSection1:Cell("C5_NUM"), , .T.)
    
    TRFunction():New(oSection2:Cell("C6_VALOR"), "VALTOT", "SUM", oBreak, "VALOR TOTAL",,, .F., .F., .F.)

Return oReport


Static Function Imprime(oReport, cAlias)

    Local oSection1 := oReport:Section(1)
    Local oSection2 := oSection1:Section(1)
    Local nTotReg   := 0
    Local cProd    := ""
    Local cQuery    := CriaQuery()

    DbUseArea(.T., "TOPCONN", TcGenQry(/*Compat*/, /*Compat*/, cQuery), cAlias, .T., .T.)
    
    Count TO nTotReg
    
    oReport:SetMeter(nTotReg)
    oReport:SetTitle("Relatório de Pedidos de Vendas")
    oReport:StartPage()
    
    (cAlias)->(DbGoTop())
    
    while (cAlias)->(!EOF())
        if oReport:Cancel()
            exit 
        endif 
    
        if AllTrim(cProd) <> AllTrim((cAlias)->C5_NUM)
            if !Empty(cProd)
                oSection2:Finish()
                oSection1:Finish()
                oReport:EndPage()
            endif 
    
            oSection1:Init()
    
            oSection1:Cell("C5_NUM"):SetValue((cAlias)->(C5_NUM))
            oSection1:Cell("A1_NOME"):SetValue((cAlias)->(A1_NOME))
            oSection1:Cell("C5_EMISSAO"):SetValue(DtoC(StoD((cAlias)->C5_EMISSAO)))
            oSection1:Cell("E4_DESCRI"):SetValue((cAlias)->(E4_DESCRI))
    
            cProd := ((cAlias)->(C5_NUM))
    
            oSection1:PrintLine()
            oSection2:Init()
        endif

            oSection2:Cell("C6_ITEM"):SetValue((cAlias)->(C6_ITEM))
            oSection2:Cell("C6_PRODUTO"):SetValue((cAlias)->(C6_PRODUTO))
            oSection2:Cell("C6_DESCRI"):SetValue((cAlias)->(C6_DESCRI))
            oSection2:Cell("C6_QTDVEN"):SetValue((cAlias)->(C6_QTDVEN))
            oSection2:Cell("C6_PRCVEN"):SetValue((cAlias)->(C6_PRCVEN))
            oSection2:Cell("C6_VALOR"):SetValue((cAlias)->(C6_VALOR))

            oSection2:PrintLine()
            oReport:SkipLine(1)
            oReport:IncMeter()
            
            (cAlias)->(DbSkip())
    enddo

    oSection2:Finish()
    
    oReport:SkipLine(1)
    
    oSection1:Finish()
    
    (cAlias)->(DbCloseArea())
    
    oReport:EndPage()

Return


Static Function CriaQuery()

    Local cQuery := ""

    cQuery += "SELECT C5.C5_NUM, C5.C5_EMISSAO, A1.A1_NOME, E4.E4_DESCRI, C6.C6_ITEM, C6.C6_PRODUTO, C6.C6_DESCRI, C6.C6_QTDVEN, C6.C6_PRCVEN, C6.C6_VALOR " + CRLF
    cQuery += "FROM " + RetSqlName("SC5") + " C5" + CRLF
    cQuery += "INNER JOIN " + RetSqlName("SE4") + " E4 ON C5.C5_CONDPAG = E4.E4_CODIGO AND E4.D_E_L_E_T_ = C5.D_E_L_E_T_ " + CRLF
    cQuery += "INNER JOIN " + RetSqlName("SA1") + " A1 ON C5.C5_CLIENTE = A1.A1_COD AND C5.D_E_L_E_T_ = A1.D_E_L_E_T_ " + CRLF
    cQuery += "INNER JOIN " + RetSqlName("SC6") + " C6 ON C5.C5_NUM = C6.C6_NUM AND C6.D_E_L_E_T_ = C5.D_E_L_E_T_ " + CRLF
    cQuery += "WHERE C5.D_E_L_E_T_ = ' ' AND C6.D_E_L_E_T_ = ' ' AND E4.D_E_L_E_T_ = ' ' AND A1.D_E_L_E_T_ = ' ' AND C5.C5_NUM = '" + AllTrim(SC5->C5_NUM) + "'" + CRLF
    cQuery += "ORDER BY C5.C5_NUM"

Return cQuery
