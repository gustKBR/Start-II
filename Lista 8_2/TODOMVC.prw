#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"


User Function TODOMVC()

	Local cAlias    := "ZZT"
	Local cTitle    := "TODO List"
	Local oMark     := FwMarkBrowse():New()

	oMark:SetAlias(cAlias)
	oMark:SetDescription(cTitle)
	oMark:SetFieldMark("ZZT_MARC")
	oMark:DisableDetails()
	oMark:DisableReport()

	oMark:AddLegend("ZZT->ZZT_STTS == '1'", "RED",    "Não iniciado")
	oMark:AddLegend("ZZT->ZZT_STTS == '2'", "YELLOW", "Em andamento")
	oMark:AddLegend("ZZT->ZZT_STTS == '3'", "GREEN",  "Concluído")

	oMark:Activate()

Return


Static Function MenuDef()

	Local aRotina := {}

	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.TODOMVC" OPERATION 2 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir"    ACTION "VIEWDEF.TODOMVC" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar"    ACTION "VIEWDEF.TODOMVC" OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE "Excluir"    ACTION "VIEWDEF.TODOMVC" OPERATION 5 ACCESS 0
	ADD OPTION aRotina TITLE "Legenda"    ACTION "U_Legenda()"     OPERATION 9 ACCESS 0

Return aRotina


Static Function ModelDef()

	Local oModel    := MPFormModel():New("TODOMVCM")
	Local oStruZZT  := FWFormStruct(1,"ZZT")
	Local oStruZZP  := FWFormStruct(1,"ZZP")
	Local bLineLoad := { |oGrid,nLine| LoadPassos(oGrid)}

	oModel:AddFields("ZZTMASTER", , oStruZZT)

	oModel:AddGrid("ZZPDETAILS", "ZZTMASTER", oStruZZP, , , , , bLineLoad)

	oModel:SetDescription("TO-DO List")
	
    oModel:GetModel("ZZTMASTER"):SetDescription("TAREFAs")
	oModel:GetModel("ZZPDETAILS"):SetDescription("PASSOS")

	oStruZZT:SetProperty("ZZT_COD",MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'GETSXENUM("ZZT", "ZZT_COD")'))

	oModel:SetRelation("ZZPDETAILS", {{"ZZP_FILIAL", 'xFilial("ZZP")'}, {"ZZP_COD", "ZZT_COD"}}, ZZP->(IndexKey(1)))

	oModel:SetPrimaryKey({"ZZT_COD", "ZZP_COD"})

Return oModel


Static Function ViewDef()

	Local oModel    := FwLoadModel("TODOMVC")
	Local oView     := FwFormView():New()
	Local oStruZZT  := FWFormStruct(2, "ZZT")
	Local oStruZZP  := FWFormStruct(2, "ZZP")

	oView:SetModel(oModel)

	oView:AddField("VIEW_ZZT", oStruZZT, "ZZTMASTER")

	oView:AddGrid("VIEW_ZZP", oStruZZP, "ZZPDETAILS")

	oView:CreateHorizontalBox("TAREFAS", 30)
	oView:CreateHorizontalBox("PASSOS", 70)

	oView:SetOwnerView("VIEW_ZZT", "TAREFAS")
	oView:SetOwnerView("VIEW_ZZP", "PASSOS")

	oView:EnableTitleView("VIEW_ZZT", "TAREFA")
	oView:EnableTitleView("VIEW_ZZP", "PASSO")

Return oView


User Function Legenda()

	Local aLegenda := {}

	aAdd(aLegenda, {"BR_VERMELHO",  "Não iniciado"})
	aAdd(aLegenda, {"BR_AMARELO",   "Em andamento"})
	aAdd(aLegenda, {"BR_VERDE",     "Concluído"})

	BrwLegenda("Legenda", "Legenda", aLegenda)

Return
