#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "PARMTYPE.CH"


User Function CUSTOMERVENDOR()

	Local aParam    := PARAMIXB
	Local oObj      := NIL
	Local cIdPonto  := ""
	Local cIdModel  := ""
	Local lRet      := .T.

    if aParam <> NIL
		oObj        := aParam[1]
		cIdPonto    := aParam[2]
		cIdModel    := aParam[3]

		if cIdPonto == "BUTTONBAR"
			oObj:GetModel("SA2MASTER"):LoadValue("A2_LOJA", "0" + Alltrim(STR(RANDOMIZE(1,9))))
			oView := FwViewActive()
			oView:Refresh()
		endif
	endif

Return lRet
