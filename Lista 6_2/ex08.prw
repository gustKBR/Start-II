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

        if cIdPonto == "MODELVLDACTIVE"
            nOperacao := oObj:GetOperation()

            if INCLUI
                FwAlertInfo("Seja Bem vindo(a) ao Cadastro de Fornecedores!", "Boas vindas")
            elseif ALTERA 
                FwAlertInfo("Você está prestes a alterar o cadastro do fornecedor " + AllTrim(SA2->A2_NOME))
            elseif nOperacao == 5
                FwAlertInfo("Cuidado, você está prestes a excluir o fornecedor " + AllTrim(SA2->A2_NOME))
            endif 
        endif 
	endif

Return lRet
