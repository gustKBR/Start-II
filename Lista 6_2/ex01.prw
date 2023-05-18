#INCLUDE "TOTVS.CH"


User Function MT120PCOL()

	Local nOper := PARAMIXB[1]
	Local nI    := 0
	Local lRet  := .T.

	if nOper == 1
		for nI := 1 to len(aCols)
			if EMPTY(aCols[nI][33])
                FwAlertError("Você deve preencher o campo Tipo de Entrada")
				lRet := .F.
			endif
		next
	endif
    
Return lRet
