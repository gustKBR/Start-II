#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "PARMTYPE.CH"


User Function CUSTOMERVENDOR()

    Local aParam    := PARAMIXB
    Local oObj      := NIL
    Local nOperacao := 0
    Local cIdPonto  := ""
    Local cIdModel  := ""
    Local lRet      := .T.

    if aParam <> NIL
        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]

        if cIdPonto == "MODELPOS"
            nOperacao := oObj:GetOperation()

            if nOperacao == 5
                lRet := MsgYesNo("Você tem certeza que deseja excluir o cadastro?", "Exclusão")
            endif
        endIf
    endif

Return lRet
