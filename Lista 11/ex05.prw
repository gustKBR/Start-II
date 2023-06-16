#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "FWPRINTSETUP.CH"
#INCLUDE "RPTDEF.CH"

#DEFINE PRETO    RGB(000,000,000)
#DEFINE MAX_LINE 1


User Function EX5_L11()
	
    Local cAlias := CriaQuery()
	
    if !Empty(cAlias)
		Processa({|| CriaRel(cAlias)}, "Aguarde...", "Imprimindo Relatório")
	else
		FwAlertError("Nenhum registro foi encontrado na consulta!", "Atenção")
    endif

Return


Static Function CriaQuery()

	Local aArea     := GetArea()
	Local cAlias    := GetNextAlias()
	Local cQuery    := ""

	cQuery := "SELECT SC7.C7_NUM, SC7.C7_PRODUTO, SC7.C7_DESCRI, SC7.C7_ITEM, SC7.C7_QUANT, SC7.C7_PRECO, SC7.C7_TOTAL, SC7.C7_LOJA, SC7.C7_EMISSAO, E4_DESCRI, A2_NREDUZ"+ CRLF
	cQuery += "FROM " + RetSqlName("SC7") + " SC7" + CRLF
	cQuery += "INNER JOIN " + RetSqlName("SE4") + " E4 ON SC7.C7_COND = E4.E4_CODIGO" + CRLF
    cQuery += "INNER JOIN " + RetSqlName("SA2") + " A2 ON SC7.C7_FORNECE = A2.A2_COD" + CRLF
	cQuery += "WHERE SC7.D_E_L_E_T_ = ' '"

	TCQUERY cQuery ALIAS (cAlias) NEW

	(cAlias)->(DbGoTop())

	if (cAlias)->(EOF())
		cAlias := ""
	endif

	RestArea(aArea)

Return cAlias


Static Function CriaRel(cAlias)

	Local cCaminho := "C:\Users\gustk\Desktop\"
	Local cArquivo := "RelatorioPedCompra3.pdf"

	Private nLine   := 120
	Private oPrint
	Private oFont10  := TFont():New("Arial",,10,, .F.,,,,,.F.,.F.)
	Private oFont12  := TFont():New("Arial",,12,, .F.,,,,,.F.,.F.)
	Private oFont14  := TFont():New("Arial",,14,, .F.,,,,,.F.,.F.)
	Private oFont16  := TFont():New("Arial",,16,, .T.,,,,,.T.,.F.)

	oPrint := FwMsPrinter():New(cArquivo,IMP_PDF, .F., "", .T.,, @oPrint, "",,,,.T.)

	oPrint:cPathPDF := cCaminho

	oPrint:SetPortrait()
	oPrint:SetPaperSize(9)
	oPrint:StartPage()

	Cabecalho()

	ImpDados(cAlias)

	oPrint:EndPage()
	oPrint:Preview()

Return


Static Function Cabecalho()

	oPrint:Say(35,479,  AllTrim(SM0->M0_NOMECOM), oFont16,, PRETO)
	oPrint:Say(45,454, "Empresa/Filial: " + AllTrim(SM0->M0_NOME) + " / " + AllTrim(SM0->M0_FILIAL), oFont14,, PRETO)
    oPrint:Say(55,421,  AllTrim(SM0->M0_ENDENT) + " " + AllTrim(SM0->M0_BAIRENT) + "/" + AllTrim(SM0->M0_ESTENT) + " " + AllTrim(Transform(SM0->M0_CEPENT, "@E 99999-999")), oFont14,, PRETO)
	
    oPrint:Say(65,478, "CNPJ:" +  AllTrim(Transform(SM0->M0_CGC, "@R 99.999.999/9999-99")), oFont14,, PRETO)
	oPrint:Say(75,513, "Fone: " +  AllTrim(SM0->M0_TEL), oFont14,, PRETO)
	
    oPrint:Line(85,15,85,580,,"-6")
	oPrint:Say(100,230, "Pedidos de Compra",oFont16,, PRETO)
	oPrint:Line(105,15,105,580,,"-6")
	
    oPrint:Say(nLine,20, "Nº Pedido: ", oFont12,, PRETO)
	oPrint:Say(nLine,270, "Data de Emissão: ", oFont12,, PRETO)
	oPrint:Say(nLine+=15,20, "Fornecedor: ", oFont12,, PRETO)
	oPrint:Say(nLine+=15,20, "Loja: ", oFont12,, PRETO)
	oPrint:Say(nLine+=15,20, "Pagamento: ", oFont12,, PRETO)
	
    oPrint:Box(nLine+=20,15, 560,580, "-8")
	oPrint:Say(nLine+=10,20, "Item", oFont12,, PRETO)
	oPrint:Say(nLine,64, "Produto", oFont12,, PRETO)
	oPrint:Say(nLine,150, "Descrição do Produto", oFont12,, PRETO)
	oPrint:Say(nLine,320, "Qtd.", oFont12,, PRETO)
	oPrint:Say(nLine,390, "Prc Unit.", oFont12,, PRETO)
	oPrint:Say(nLine,490, "Prc Total.", oFont12,, PRETO)
	
    nLine += 5
	
    oPrint:Line(nLine, 15, nLine, 580, , "-6")

Return


Static Function ImpDados(cAlias)

	Local cUltPed  := ""
	Local nPag := 0

	Private nCont := 1
	
	DbSelectArea(cAlias)

	(cAlias)->(DbGoTop())

	while (cAlias)->(!EOF())
		if (cAlias)->(C7_NUM) != cUltPed
			BreakPag(MAX_LINE)
			
            nCont++
            
			nLine := 120
			
            oPrint:Say(nLine,74, (cAlias)->(C7_NUM), oFont10,, PRETO)
			oPrint:Say(nLine,360, DtoC(StoD((cAlias)->(C7_EMISSAO))), oFont10,, PRETO)
			oPrint:Say(nLine+=15,80, (cAlias)->(A2_NREDUZ), oFont10,, PRETO)
			oPrint:Say(nLine+=15,54, (cAlias)->(C7_LOJA), oFont10,, PRETO)
			oPrint:Say(nLine+=15,80, (cAlias)->(E4_DESCRI) , oFont10,, PRETO)
			
            cUltPed := (cAlias)->(C7_NUM)
            
            nLine += 45
			
            nPag++
		endif
		
        oPrint:Say(nLine,20, (cAlias)->(C7_ITEM)   , oFont10,, PRETO)
		oPrint:Say(nLine,64, (cAlias)->(C7_PRODUTO), oFont10,, PRETO)
		oPrint:Say(nLine,150, (cAlias)->(C7_DESCRI) , oFont10,, PRETO)
		oPrint:Say(nLine,326, cValToChar((cAlias)->(C7_QUANT)), oFont10,, PRETO)
		oPrint:Say(nLine,392, "R$" + STRTRAN(STR((cAlias)->(C7_PRECO),9,2), ".", ","), oFont10,, PRETO)
		oPrint:Say(nLine,493, "R$" + STRTRAN(STR((cAlias)->(C7_TOTAL),9,2), ".", ","), oFont10,, PRETO)
		
        nLine += 15
		
        IncProc()
		
        oPrint:Say(810,520, "Pagina: " + cValToChar(nPag), oFont12,, PRETO)
		
		(cAlias)->(DbSkip())
	enddo

Return


Static Function BreakPag(nMax)

	if nCont > nMax
		oPrint:EndPage()
		oPrint:StartPage()

		nLine := 120

		Cabecalho()
	endif

Return
