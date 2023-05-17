#INCLUDE "TOTVS.CH"


User Function FISA010()

	Local aParam   := PARAMIXB
	Local lRet     := .T.
	Local oObj     := Nil
	Local cIdPonto := ""
	Local cIdModel := ""

	if aParam != NIL

		oObj     := aParam[1]
		cIdPonto := aParam[2]
		cIdModel := aParam[3]

		if cIdPonto == "MODELPOS"
			if ExistBlock("CadMuni")
				lRet := ExecBlock("CadMuni", .F., .F.)
			endif
		endif
	endif

Return lRet
