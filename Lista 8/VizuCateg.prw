#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"


User Function VizuCateg()
    
    Local cAlias  := "ZZH"
    Local cTitle  := "Vizualizar cadastros"
    Local oBrowse := FwMBrowse():New()

    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitle)
    oBrowse:DisableDetails()
    oBrowse:DisableReport()

    oBrowse:Activate()
    
Return


Static Function MenuDef()

    Local aRotina := {}

    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.VizuCateg" OPERATION 2 ACCESS 0

Return aRotina


Static Function ModelDef()
    
    Local oModel    := MPFormModel():New("VizuCategM")
    Local oStruZZH  := FWFormStruct(1, "ZZH")
    Local oStruZZI  := FWFormStruct(1, "ZZI")
    Local oStruZZA  := FWFormStruct(1, "ZZA")

    oModel:AddFields("ZZHMASTER", /*cOwner*/, oStruZZH)

    oModel:AddGrid("ZZIDETAIL", "ZZHMASTER", oStruZZI)
    oModel:AddGrid("ZZADETAIL", "ZZIDETAIL", oStruZZA)

    oModel:SetDescription("Vizualizar cadastros")

    oModel:GetModel("ZZHMASTER"):SetDescription("Categorias")
    oModel:GetModel("ZZIDETAIL"):SetDescription("Instrutores")
    oModel:GetModel("ZZADETAIL"):SetDescription("Alunos")

    oModel:SetRelation("ZZIDETAIL", {{"ZZI_FILIAL", 'xFilial("ZZI")'}, {"ZZI_CATEGO", "ZZH_COD"}}, ZZI->(IndexKey(1)))
    oModel:SetRelation("ZZADETAIL", {{"ZZA_FILIAL", 'xFilial("ZZA")'}, {"ZZA_CODINS", "ZZI_COD"}}, ZZA->(IndexKey(1)))

    oModel:SetPrimaryKey({"ZZH_COD","ZZI_COD","ZZA_COD"})

Return oModel


Static Function ViewDef()

    Local oModel    := FwLoadModel("VizuCateg")
    Local oView     := FwFormView():New()
    Local oStruZZH  := FWFormStruct(2, "ZZH")
    Local oStruZZI  := FWFormStruct(2, "ZZI")
    Local oStruZZA  := FWFormStruct(2, "ZZA")

    oView:SetModel(oModel)

    oView:AddField("VIEW_ZZH", oStruZZH, "ZZHMASTER")
    oView:AddGrid("VIEW_ZZI", oStruZZI, "ZZIDETAIL")
    oView:AddGrid("VIEW_ZZA", oStruZZA, "ZZADETAIL")

    oView:CreateHorizontalBox("CATEGORIAS", 20)
    oView:CreateHorizontalBox("INSTRUTORES", 40)
    oView:CreateHorizontalBox("ALUNOS", 40)

    oView:SetOwnerView("VIEW_ZZH", "CATEGORIAS")
    oView:SetOwnerView("VIEW_ZZI", "INSTRUTORES")
    oView:SetOwnerView("VIEW_ZZA", "ALUNOS")

    oView:EnableTitleView("VIEW_ZZH", "CATEGORIAS")
    oView:EnableTitleView("VIEW_ZZI", "INSTRUTORES")
    oView:EnableTitleView("VIEW_ZZA", "ALUNOS")

Return oView
