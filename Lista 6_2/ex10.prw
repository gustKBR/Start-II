#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "PARMTYPE.CH"


User Function CUSTOMERVENDOR()

    Local aParam    := PARAMIXB
    Local oObj      := NIL
    Local cIdPonto  := ""
    Local cIdModel  := ""
    Local lRet      := .T.
    Local cAlias    := "SB1"
    Local cTitulo   := "Cadastro de Produtos"

    DbSelectArea(cAlias)
    DbSetOrder(1)

    If aParam <> NIL
        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]

        If cIdPonto == "BUTTONBAR"
            lRet := {}
            AADD(lRet, {"Cadastro de Produtos", "", {||AxCadastro(cAlias, cTitulo, ".T.", ".T.")}, "Cadastro de Produtos"})
        endif
    EndIf

    DbCloseArea()

Return lRet
