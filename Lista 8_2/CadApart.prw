#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"


User Function CadApart()

    Local cAlias  := "SZ1"
    Local cTitle  := "Blocos de Apartamentos"
    Local oBrowse := FwMBrowse():New()

    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitle)
    oBrowse:DisableDetails()
    oBrowse:DisableReport()
    
    oBrowse:Activate()

Return


Static Function MenuDef()

    Local aRotina := {}

    ADD OPTION aRotina TITLE "Visualizar"   ACTION "VIEWDEF.CadApart" OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE "Incluir"      ACTION "VIEWDEF.CadApart" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar"      ACTION "VIEWDEF.CadApart" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir"      ACTION "VIEWDEF.CadApart" OPERATION 5 ACCESS 0

Return aRotina


Static Function ModelDef()

    Local oModel    := MPFormModel():NEW("CadApartM")
    Local oStruSZ1  := FWFormStruct(1, "SZ1")
    Local oStruSZ2  := FWFormStruct(1, "SZ2")

    oModel:AddFields("SZ1MASTER", , oStruSZ1)

    oModel:AddGrid("SZ2DETAIL", "SZ1MASTER", oStruSZ2, bLinePre)

    oModel:SetDescription("Blocos de Apartamento")

    oModel:GetModel("SZ1MASTER"):SetDescription("Blocos")
    oModel:GetModel("SZ2DETAIL"):SetDescription("Apartamentos")

    oModel:SetRelation("SZ2DETAIL", {{"SZ2_FILIAL", 'xFilial("SZ2")'}, {"SZ2_BLOCO", "SZ1_COD"}}, SZ2->(IndexKey(1)))
    
    oStruSZ1:SetProperty("SZ1_COD", MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, AllTrim(GETSXENUM("SZ1","SZ1_COD"))))
    oStruSZ2:SetProperty("SZ2_COD", MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, AllTrim(GETSXENUM("SZ2","SZ2_COD"))))
    
    oModel:GetModel("SZ2DETAIL"):SetUniqueLine({"SZ2_COD"})
    
    oModel:SetPrimaryKey({"SZ1_COD", "SZ2_COD"})

Return oModel


Static Function ViewDef()

    Local oModel    := FWLoadModel("CadApart")
    Local oView     := FWFormView():New()
    Local oStruSZ1  := FWFormStruct(2, "SZ1")
    Local oStruSZ2  := FWFormStruct(2, "SZ2")

    oView:SetModel(oModel)

    oView:AddField("VIEW_SZ1", oStruSZ1, "SZ1MASTER")

    oView:AddGrid("VIEW_SZ2", oStruSZ2, "SZ2DETAIL")
    
    oView:CreateHorizontalBox("BLOCOS", 30)
    oView:CreateHorizontalBox("APARTAMENTOS", 70)

    oView:SetOwnerView("VIEW_SZ1", "BLOCOS")
    oView:SetOwnerView("VIEW_SZ2", "APARTAMENTOS")

    oView:EnableTitleView("VIEW_SZ1", "Dados do Bloco")
    oView:EnableTitleView("VIEW_SZ2", "Apartamentos no Bloco")

Return oView
