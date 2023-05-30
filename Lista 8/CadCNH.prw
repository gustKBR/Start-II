#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"


User Function CadCNH()
    
    Local cAlias    := "ZZH"
    Local cTitle    := "Categorias de CNH"
    Local oBrowse   := FwMBrowse():New()
    
    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitle)
    oBrowse:DisableReport()
    oBrowse:DisableDetails()
    
    oBrowse:Activate()
    
Return 
 

Static Function MenuDef()
 
    Local aRotina := {}
 
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.CadCNH" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.CadCNH" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.CadCNH" OPERATION 5 ACCESS 0

Return aRotina

 
Static Function ModelDef()
    
    Local bModelPos := {|oModel| ValidPos(oModel)}
    Local aGatilho  := FwStruTrigger("ZZH_CODVEI", "ZZH_NOME", "ZZV->ZZV_NOME", .T., "ZZV", 1, 'xFilial("ZZV")+AllTrim(M->ZZH_CODVEI)')
    Local oStruZZH  := FWFormStruct(1, "ZZH")
    Local oModel    := MPFormModel():New("CadCNHM", , bModelPos, /*MODELCOMITTTS*/, )
    
    oStruZZH:AddTrigger(aGatilho[1], aGatilho[2], aGatilho[3], aGatilho[4])

    oModel:AddFields("ZZHMASTER", /*cOwner*/, oStruZZH, , /*bFieldPos*/, /*bLoad*/)
    
    oStruZZH:SetProperty("ZZH_COD", MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD,  'GetSXENum("ZZH", "ZZH_COD")'))
    
    oModel:SetDescription("Categorias de CNH")
    
    oModel:GetModel("ZZHMASTER"):SetDescription("Categorias de CNH")
    
    oModel:SetPrimaryKey({"ZZH_COD"})

Return oModel


Static Function ViewDef()

    Local oModel    := FwLoadModel("CatCNH")
    Local oView     := FwFormView():New()
    Local oStruZZH  := FWFormStruct(2, "ZZH")
    
    oView:SetModel(oModel)

    oView:AddField("VIEW_ZZH", oStruZZH, "ZZHMASTER")

    oView:CreateHorizontalBox("CNH", 100)

    oView:SetFieldAction("ZZH_COD", {|oView| ValidField(oView)})
    
    oView:SetOwnerView("VIEW_ZZH", "CNH")

Return oView


Static Function ValidPos(oModel)

    Local nOperation    := oModel:GetOperation()
    Local nTamanho      := len(AllTrim(oModel:GetValue("ZZHMASTER", "ZZH_SIGLA")))
    Local lRet          := .T.
    
    if nOperation == 3
        if nTamanho != 1 .AND. nTamanho != 3   
            lRet := .F.
            Help(NIL, NIL, "Sigla incorreta", NIL, "A sigla deve conter 1 ou 3 caracteres!", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Preencha a sigla com 1 ou 3 caracteres"})
        endif
    endif

Return lRet
