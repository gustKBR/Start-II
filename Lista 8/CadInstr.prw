#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"


User Function CadInstr()
    
    Local cAlias := "ZZI"
    Local cTitle := "Cadastro de Instrutor"
    Local oMark   := FWMarkBrowse():New()

    oMark:SetAlias(cAlias)
    oMark:SetDescription(cTitle)
    oMark:SetFieldMark("ZZI_MARC")
    oMark:AddButton("Excluir Marcados", "U_DelInstr", 5, 1)
    oMark:DisableDetails()
    oMark:DisableReport()

    oMark:Activate()
    
Return 


Static Function MenuDef()

    Local aRotina := {}
 
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.CadInstr" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.CadInstr" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.CadInstr" OPERATION 5 ACCESS 0

Return aRotina


Static Function ModelDef()
    
    Local bModelPos     := {|oModel| ValidPos(oModel)}
    Local oStruZZI      := FWFormStruct(1, "ZZI")
    Local oModel        := MPFormModel():New("CadInstrM", , bModelPos, , )
 
    oModel:AddFields("ZZIMASTER", , oStruZZI)
 
    oModel:SetDescription("Cadastro de Instrutor")
 
    oModel:GetModel("ZZIMASTER"):SetDescription("Cadastro de Instrutor")
 
    oModel:SetPrimaryKey({"ZZI_COD"})

Return oModel


Static Function ViewDef()

    Local oModel    := FwLoadModel("CadInstr")
    Local oStruZZI  := FWFormStruct(2, "ZZI")
    Local oView     := FwFormView():New()

    oView:SetModel(oModel)

    oView:AddField("VIEW_ZZI", oStruZZI, "ZZIMASTER")

    oView:CreateHorizontalBox("INSTRUTORES", 100)

    oView:SetOwnerView("VIEW_ZZI", "INSTRUTORES")

Return oView


Static Function ValidPos(oModel)

    Local nOperation        := oModel:GetOperation()
    Local cEscolaridade     := AllTrim(oModel:GetValue("ZZIMASTER","ZZI_ESCOLA"))
    Local cQtdAlunos        := oModel:GetValue("ZZIMASTER","ZZI_QTDA")
    Local dDataNasc         := oModel:GetValue("ZZIMASTER","ZZI_DATNAS")
    Local dHabilita         := oModel:GetValue("ZZIMASTER","ZZI_DATHAB")
    Local lRet              := .T.
    
    if nOperation == 3
        if cEscolaridade == "F"
            lRet := .F.
            Help(NIL, NIL, "Baixo nível de escolaridade", NIL, "É necessário ter concluído o ensino médio!", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Realize o ensimo médio!"})
        elseif (DateDiffYear(dDataNasc, Date()) < 21)
            lRet := .F.
            Help(NIL, NIL, "Idade insuficiente", NIL, "A idade mínima deve ser de 21 anos", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Aguarde!"})
        elseif (DateDiffYear(dHabilita, Date()) < 2)
            lRet := .F.
            Help(NIL, NIL, "Habilitação inválida", NIL, "Você deve estar habilitado há 2 anos, no mínimo.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Aguarde!"})
        endif
    endif

    if nOperation == 5 .AND. cQtdAlunos >= 1
        lRet := .F.
        Help(NIL, NIL, "Operação não permitida", NIL, "Não é possível apagar instrutores com alunos!", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Remova os alunos deste instrutor para poder excluí-lo!"})
    endif

Return lRet


User Function DelInstr()

    if MsgYesNo("Confirma a exclusão dos instrutores marcados?")
        
        DbSelectArea("ZZI")
        
        ZZI->(DbGotop())
        
        while ZZI->(!EOF())
            if oMark:IsMark()
                RecLock("ZZI", .F.)
                    ZZI->(DbDelete())
                    ZZI->(MSUnlock())
            endif
            
            ZZI->(DbSkip())
        enddo
    endif
  
    oMark:Refresh(.T.)

Return
