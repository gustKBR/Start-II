#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"


User Function EX2_L10()

    Local cAlias    := "SA2"
    Local cTitle    := "Cadastro de Fornecedores"
    Local oBrowse   := FWMBrowse():New()

    oBrowse:AddButton("Relatório", {|| ShowForne()})
    
    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitle)
    oBrowse:DisableDetails()
    oBrowse:DisableReport()

    oBrowse:Activate()

Return 


Static Function MenuDef()

    Local aRotina := {}

    ADD OPTION aRotina TITLE "Incluir"    ACTION "VIEWDEF.EX2_L10" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar"    ACTION "VIEWDEF.EX2_L10" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir"    ACTION "VIEWDEF.EX2_L10" OPERATION 5 ACCESS 0

Return aRotina


Static Function ModelDef()

    Local oModel        := MPFormModel():New("EX2_L10M")
    Local oStruSA2      := FWFormStruct(1, "SA2")
    
    oModel:AddFields("SA2MASTER",, oStruSA2)
    oModel:SetDescription("Modelo de Dados Fornecedores")
    oModel:GetModel("SA2MASTER"):SetDescription("Formulário Fornecedor")
    oModel:SetPrimaryKey({"SA2_COD"})

Return oModel


Static Function ViewDef()

    Local oModel        := FWLoadModel("EX2_L10")
    Local oStruSA2      := FWFormStruct(2, "SA2")
    Local oView         := FWFormView():New()

    oView:SetModel(oModel)
    oView:AddField("VIEW_SA2", oStruSA2 , "SA2MASTER")
    oView:CreateHorizontalBox("TELA", 100)
    oView:SetOwnerView("VIEW_SA2", "TELA")

Return oView


Static Function ShowForne()

    Local oReport := CriaRel()

    oReport:PrintDialog()

Return 


Static Function CriaRel()

    Local cAlias    := GetNextAlias()
    Local oRel      := TReport():New("TReport", "Relatório de Clientes",, {|oRel| Imprime(oRel, cAlias)}, "Esse relatório imprimirá todos os cadastros de clientes.", .F.,,,,,,)
    Local oSection  := TRSection():New(oRel, "Cadastros de Clientes")
    
    TRCell():New(oSection, "A2_COD", "SA2", "CÓDIGO",, 8,,, "CENTER", .T., "CENTER",,, .T.,,, .T.) 
    TRCell():New(oSection, "A2_NOME", "SA2", "RAZÃO SOCIAL",, 25,,, "LEFT", .T., "LEFT",,, .T.,,, .T.) 
    TRCell():New(oSection, "A2_NREDUZ", "SA2", "NOME FANTASIA",, 25,,, "LEFT", .T., "LEFT",,, .T.,,, .T.) 
    TRCell():New(oSection, "A2_MUN", "SA2", "MUNICÍPIO",, 20,,, "LEFT", .T., "LEFT",,, .T.,,, .T.) 
    TRCell():New(oSection, "A2_EST", "SA2", "UF",, 8,,, "CENTER", .T., "CENTER",,, .T.,,, .T.) 
    TRCell():New(oSection, "A2_CGC", "SA2", "CNPJ/CPF",, 16,,, "LEFT", .F., "LEFT",,, .T.,,, .T.) 

Return oRel


Static Function Imprime(oRel, cAlias)

    Local oSection := oRel:Section(1)
    Local nTotReg  := 0
    Local cQuery   := CriaQuery()

    DbUseArea(.T., "TOPCONN", TcGenQry(/*Compat*/, /*Compat*/, cQuery), cAlias, .T., .T.)

    Count TO nTotReg

    oRel:SetMeter(nTotReg)
    oRel:SetTitle("Relatório de Fornecedores")
    oRel:StartPage()

    oSection:Init()

    (cAlias)->(DbGoTop())

    while (cAlias)->(!EOF())
        if oRel:Cancel()
            exit
        endif

        oSection:Cell("A2_COD"):SetValue((cAlias)->A2_COD)
		oSection:Cell("A2_NOME"):SetValue((cAlias)->A2_NOME)
		oSection:Cell("A2_NREDUZ"):SetValue((cAlias)->A2_NREDUZ)
		oSection:Cell("A2_MUN"):SetValue((cAlias)->A2_MUN)
		oSection:Cell("A2_EST"):SetValue((cAlias)->A2_EST)
		oSection:Cell("A2_CGC"):SetValue((cAlias)->A2_CGC)
		
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

    cQuery += "SELECT A2_COD, A2_NOME, A2_NREDUZ, A2_MUN, A2_EST, A2_CGC" + CRLF
	cQuery += "FROM " + RetSqlName("SA2") + " SA2" + CRLF
	cQuery += "WHERE A2_COD = '" + Alltrim(SA2->A2_COD) + " ' AND D_E_L_E_T_= ' '" + CRLF
    
Return cQuery
