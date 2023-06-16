#INCLUDE "TOTVS.CH"


User Function EX4CR_L13()
	Local cFolder   := "Lista 13\"
    Local cCaminho  := "C:\TOTVS\Protheus12133\protheus_data"

	if !ExistDir(cCaminho + cFolder)
		if MakeDir(cCaminho + cFolder) == 0
			if ExistBlock("EX4CO_L13")
				ExecBlock("EX4CO_L13", .F., .F., cCaminho + cFolder)
			endif
		else
			FwAlertError("Erro na criação da pasta!", "Erro")
		endif
	else
		if ExistBlock("EX4CO_L13")
			ExecBlock("EX4CO_L13", .F., .F., cCaminho + cFolder)
		endif
	endif

Return
