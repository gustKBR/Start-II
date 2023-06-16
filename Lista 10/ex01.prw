#INCLUDE "TOTVS.CH"
#INCLUDE "REPORT.CH"


User Function EX1_L10()

    Local oReport := CriaRel()

    oReport:PrintDialog()

Return 


Static Function CriaRel()

    Local cAlias    := GetNextAlias()
    Local oRel      := TReport():New("TReport", "Relatório de Produtos",, {|oRel| Imprime(oRel, cAlias)}, "Esse relatório imprimirá todos os cadastros de produtos.", .F.)
    Local oSection  := TRSection():New(oRel, "Cadastro de Produtos")
    
    TRCell():New(oSection, "B1_COD", "SB1", "CÓDIGO",, 8,,, "CENTER", .T., "CENTER",,, .T.,,, .T.) 
    TRCell():New(oSection, "B1_DESC", "SB1", "DESCRIÇÃO",, 30,,, "LEFT", .T., "LEFT",,, .T.,,, .T.)
    TRCell():New(oSection, "B1_UM", "SB1", "UM",, 4,,, "CENTER", .F., "CENTER",,, .T.,,, .T.)  
    TRCell():New(oSection, "B1_PRV1", "SB1", "PREÇO R$",, 9,,, "LEFT", .T., "LEFT",,, .T.,,, .T.) 
    TRCell():New(oSection, "B1_LOCPAD", "SB1", "ARMAZÉM",, 4,,, "CENTER", .F., "CENTER",,, .T.,,, .T.) 

Return oRel


Static Function Imprime(oRel, cAlias)

    Local oSection := oRel:Section(1)
    Local nTotReg  := 0
    Local cQuery   := CriaQuery()

    DbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cAlias, .T., .T.)

    Count TO nTotReg

    oRel:SetMeter(nTotReg)
    oRel:SetTitle("Relatório de Produtos")
    oRel:StartPage()

    oSection:Init()

    (cAlias)->(DbGoTop())

    while (cAlias)->(!EOF())
        if oRel:Cancel()
            exit
        endif

        oSection:Cell("B1_COD"):SetValue((cAlias)->B1_COD)
		oSection:Cell("B1_DESC"):SetValue((cAlias)->B1_DESC)
		oSection:Cell("B1_UM"):SetValue((cAlias)->B1_UM)
		oSection:Cell("B1_PRV1"):SetValue((cAlias)->B1_PRV1)
		
        if !Empty(SB1->B1_PRV1)
            oSection:Cell("B1_PRV1"):SetValue("R$" + (cAlias)->B1_PRV1)
        endif

		oSection:Cell("B1_LOCPAD"):SetValue((cAlias)->B1_LOCPAD)
		
        oSection:PrintLine()
		oRel:ThinLine()
		oRel:IncMeter()

		(cAlias)->(DbSkip())
    enddo

    (cAlias)->(DbCloseArea())
	
	oSection:Finish()			
	
	oRel:EndPage()

Return


Static Function CriaQuery()

    Local cQuery := ""

    cQuery += "SELECT B1_COD, B1_DESC, B1_UM, B1_PRV1, B1_LOCPAD" + CRLF
	cQuery += "FROM " + RetSqlName("SB1") + " SB1" + CRLF
	cQuery += "WHERE D_E_L_E_T_= ' '" + CRLF

Return cQuery
