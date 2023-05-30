#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"


User Function CadAluno()
    
    Local cAlias    := "ZZC"
    Local cTitle    := "Cadastro de Cursos"
    Local oMark     := FWMarkBrowse():New()
    
    oMark:SetAlias(cAlias)       
    oMark:SetDescription(cTitle) 
    oMark:SetFieldMark("ZZC_MARC")
    oMark:AddButton("Excluir marcados", "U_DelAlunos", 5, 1)
    oMark:DisableDetails() 
    oMark:DisableReport()       
    
    oMark:Activate()            
    
Return


Static Function MenuDef()
    
    Local aRotina := {}

    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.CadAluno" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.CadAluno" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.CadAluno" OPERATION 5 ACCESS 0

Return aRotina


Static Function ModelDef()

    Local bModelPos   := {|oModel| ValidPos(oModel)}
    Local aGatilho    := FwStruTrigger("ZZC_CODINS", "ZZC_NOMINS", "ZZA->ZZA_NOME", .T., "ZZA", 1, 'xFilial("ZZA")+AllTrim(M->ZZC_CODINS)')
    Local oStruZZC    := FWFormStruct(1, "ZZC")
    Local oModel      := MPFormModel():New("CadAlunoM", , bModelPos, , )

    oStruZZC:AddTrigger(aGatilho[1], aGatilho[2], aGatilho[3], aGatilho[4])

    oModel:AddFields("ZZCMASTER", /*cOwner*/, oStruZZC, , /*bFieldPos*/, /*bLoad*/)
    
    oStruZZC:SetProperty("ZZC_COD", MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD,  'GetSXENum("ZZC", "ZZC_COD")'))
    
    oModel:SetDescription("Cadastro de Alunos")
    
    oModel:GetModel("ZZCMASTER"):SetDescription("Cadastro de Alunos")
    
    oModel:SetPrimaryKey({"ZZC_COD"})

Return oModel


Static Function ViewDef()

    Local oModel    := FwLoadModel("CadAluno")
    Local oView     := FwFormView():New()
    Local oStruZZC  := FWFormStruct(2, "ZZC")

    oView:SetModel(oModel)

    oView:AddField("VIEW_ZZC", oStruZZC, "ZZCMASTER")

    oView:CreateHorizontalBox("ALUNOS", 100)

    oView:SetFieldAction("ZZC_COD", {|oView| ValidField(oView)})
    
    oView:SetOwnerView("VIEW_ZZC", "ALUNOS")

Return oView


Static Function ValidPos(oModel)

    Local cCodInstrutor     := oModel:GetValue("ZZCMASTER","ZZC_CODINS")
    Local cRealizaAulas     := oModel:GetValue("ZZCMASTER","ZZC_LISTA")
    Local nOperation        := oModel:GetOperation()
    Local lRet              := .T.
    
    DbSelectArea("ZZA")
    DbSetOrder(1)

    if nOperation == 3 
        if DbSeek(xFilial("ZZA") + cCodInstrutor)
            if ZZA->ZZA_QTD == 5
                lRet := .F.
                Help(NIL, NIL, "O instrutor está indisponível!", NIL, "O instrutor pode atender no máximo 5 alunos.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Selecione outro instrutor"})
            else
                RecLock("ZZA", .F.)
                    ZZA_QTD++
                MsUnlock()
            endif
        endif
    elseif nOperation == 5
        if cRealizaAulas == "1"
            lRet := .F.
            Help(NIL, NIL, "O aluno está em aula no momento!", NIL, "O aluno não pode ser excluído por estar em aula.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Selecione outro aluno"}) 
        else
            if DbSeek(xFilial("ZZA") + cCodInstrutor)
                RecLock("ZZA", .F.)
                    ZZA_QTD--
                MsUnlock()
            endif
        endif
    endif

Return lRet


User Function DelAlunos()

    if MsgYesNo("Confirma a exclusão dos alunos marcados?")
    
        DbSelectArea("ZZC")
        
        ZZC->(DbGotop())
        
        while ZZC->(!EOF())
            if oMark:IsMark() .AND. ZZC->ZZC_LISTA != "1"
                RecLock("ZZC", .F.)
                    ZZC->(DbDelete())
                    ExcAluno()
                ZZC->(MsUnlock())
            else 
                FwAlertError("O aluno está em aula no momento!", "Atenção")
            endif
            ZZC->(DbSkip())
        enddo
    endif
    
    oMark:Refresh(.T.)

Return


Static Function ExcAluno()
    
    DbSelectArea("ZZA")
    DbSetOrder(1)
    
    if DbSeek(xFilial("ZZA") + ZZC->ZZC_CODINS)
        RecLock("ZZA", .F.)
            ZZA_QTD--
        ZZA->(MsUnlock())
    endif

Return
