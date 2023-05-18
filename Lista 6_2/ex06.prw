#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "PARMTYPE.CH"


User Function CUSTOMERVENDOR()

	Local aParam    := PARAMIXB
	Local oObj      := NIL
	Local cIdPonto  := ""
	Local cIdModel  := ""
	Local lRet      := .T.


	If aParam <> NIL
		oObj        := aParam[1]
		cIdPonto    := aParam[2]
		cIdModel    := aParam[3]

		if cIdPonto == "MODELPOS"
            if EMPTY(M->A2_PAIS)
                Help("", 1, "Aviso",,"O preenchimento do campo país é obrigatório!", 1)
                lRet := .F.
            elseif M->A2_PAIS == "105" .AND. EMPTY(M->A2_CGC)
                Help("", 1, "Aviso",,"O preenchimento do campo CNPJ é obrigatório!", 1)
                lRet := .F.
            endif
        endif
	endif

Return lRet
