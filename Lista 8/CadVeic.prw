#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"


User Function CadVeic()
    
    Local cAlias    := "ZZV"
    Local cTitle    := "Cadastro de Ve�culos"
    Local oBrowse   := FwMBrowse():New()

    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitle)
    oBrowse:DisableReport()
    oBrowse:DisableDetails()

    oBrowse:Activate()
    
Return 
 

Static Function MenuDef()
 
    Local aRotina := {}
 
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.CadVeic" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.CadVeic" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.CadVeic" OPERATION 5 ACCESS 0

Return aRotina


Static Function ModelDef()
    
    Local oModel   := MPFormModel():New("CadVeicM")
    Local oStruZZV := FWFormStruct(1, "ZZV")

    oModel:AddFields("ZZVMASTER", , oStruZZV)

    oModel:SetDescription("Cadastro de Ve�culos")

    oModel:GetModel("ZZVMASTER"):SetDescription("Cadastro de Ve�culos")

    oModel:SetPrimaryKey({"ZZV_COD"})

Return oModel


Static Function ViewDef()

    Local oModel    := FwLoadModel("CadVeic")
    Local oView     := FwFormView():New()
    Local oStruZZV  := FWFormStruct(2, "ZZV")

    oView:SetModel(oModel)

    oView:AddField("VIEW_ZZV", oStruZZV, "ZZVMASTER")

    oView:CreateHorizontalBox("VE�CULOS", 100)

    oView:SetOwnerView("VIEW_ZZV", "VE�CULOS")

Return oView
