#INCLUDE "TOTVS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TOPCONN.CH"


User Function EX4_L10()

	Local oReport := GeraReport() 
	
 	oReport:PrintDialog()

Return


Static Function GeraReport()

	Local cAlias	:= GetNextAlias()
	Local oBreak   
	Local oReport	:= TReport():New("TReport", "Relatório de Pedidos de Compra",,{|oReport| Imprime(oReport, cAlias)}, "Informações de Pedidos de Compra",.F.,,,, .T., .T.)	
	Local oSection1	:= TRSection():New(oReport, "Pedidos de Compra",,,.F.,.T.)
    Local oSection2 := TRSection():New(oSection1, "Itens do Pedido de Compra",,,.F.,.T.)		

    TRCell():New(oSection1, "C7_NUM", "SC7", "Nº PEDIDO",, 8,,, "CENTER", .T., "CENTER",,, .T.,,, .T.)
	TRCell():New(oSection1, "C7_EMISSAO", "SC7", "DATA DE EMISSAO",, 14,,, "LEFT", .T., "LEFT",,, .T.,,, .T.)
	TRCell():New(oSection1, "C7_FORNECE", "SC7", "FORNECEDOR",, 8,,, "LEFT", .T., "LEFT",,, .T.,,, .T.)	
	TRCell():New(oSection1, "C7_LOJA", "SC7", "LOJA",, 5,,, "LEFT", .T., "LEFT",,, .T.,,, .T.)	
	TRCell():New(oSection1, "C7_COND", "SC7", "CONDICAO DE PAGAMENTO",, 5,,, "LEFT", .T., "LEFT",,, .T.,,, .T.)
	
    TRCell():New(oSection2, "C7_PRODUTO", "SC7", "COD. PRODUTO",, 8,,, "CENTER", .T., "CENTER",,, .T.,,, .T.)
	TRCell():New(oSection2, "C7_DESCRI", "SC7", "DESCRICAO DO PRODUTO",, 30,,, "LEFT", .T., "LEFT",,, .T.,,, .T.)
	TRCell():New(oSection2, "C7_QUANT", "SC7", "QTD. VENDIDA",, 4,,, "LEFT", .T., "LEFT",,, .T.,,, .T.)	
	TRCell():New(oSection2, "C7_PRECO", "SC7", "VALOR UNITARIO",, 10,,, "LEFT", .T., "LEFT",,, .T.,,, .T.)	
	TRCell():New(oSection2, "C7_TOTAL", "SC7", "VALOR TOTAL",, 10,,, "LEFT", .T., "LEFT",,, .T.,,, .T.)
	
    oBreak := TRBreak():New(oSection1, oSection1:Cell("C7_NUM"), , .T.)
	
	TRFunction():New(oSection2:Cell("C7_TOTAL"), "VALTOT", "SUM", oBreak, "VALOR TOTAL",,, .F., .F., .F.) 

Return oReport


Static Function Imprime(oReport, cAlias)

	Local oSection1 := oReport:Section(1)
    Local oSection2 := oSection1:Section(1)  
	Local nTotReg		:= 0
	Local cQuery		:= CriaQuery()	
	
	DbUseArea(.T., "TOPCONN", TcGenQry(/*Compat*/, /*Compat*/, cQuery), cAlias, .T., .T.)	
	
    Count TO nTotReg 
	
    oReport:SetMeter(nTotReg)
	oReport:SetTitle("Relatório de Pedidos de Compra")
	oReport:StartPage()
	
    oSection1:Init()  
	
    (cAlias)->(DBGoTop())
	
    oSection1:Cell("C7_NUM"):SetValue((cAlias)->C7_NUM)
	oSection1:Cell("C7_EMISSAO"):SetValue((cAlias)->C7_EMISSAO)	
	oSection1:Cell("C7_FORNECE"):SetValue((cAlias)->C7_FORNECE)		
	oSection1:Cell("C7_LOJA"):SetValue((cAlias)->C7_LOJA)	
	oSection1:Cell("C7_COND"):SetValue((cAlias)->C7_COND)
    
    oSection1:PrintLine()
	
    while (cAlias)->(!EOF())
		if oReport:Cancel()
			exit
		endif

        oSection2:Init()
        
		oSection2:Cell("C7_PRODUTO"):SetValue((cAlias)->C7_PRODUTO)
		oSection2:Cell("C7_DESCRI"):SetValue((cAlias)->C7_DESCRI)	
		oSection2:Cell("C7_QUANT"):SetValue((cAlias)->C7_QUANT)		
		oSection2:Cell("C7_PRECO"):SetValue((cAlias)->C7_PRECO)	
		oSection2:Cell("C7_TOTAL"):SetValue((cAlias)->C7_TOTAL)
		
		oSection2:PrintLine()
		oReport:IncMeter()
		
        (cAlias)->(DbSkip())
	enddo   
	
	(cAlias)->(DbCloseArea())

    oSection2:Finish()	
	oSection1:Finish()			
	
    oReport:EndPage()

Return  


Static Function CriaQuery()

	Local cQuery := ""

	cQuery += "SELECT C7_NUM, C7_EMISSAO, C7_FORNECE, C7_LOJA, C7_COND, C7_PRODUTO, C7_DESCRI, C7_QUANT, C7_PRECO, C7_TOTAL" + CRLF
	cQuery += "FROM " + RetSqlName("SC7") + " SC7" + CRLF
	cQuery += "WHERE D_E_L_E_T_= ' '" + CRLF
    cQuery += " AND C7_NUM = '" + SC7->C7_NUM + "'"

Return cQuery
