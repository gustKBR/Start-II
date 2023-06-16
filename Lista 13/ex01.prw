#INCLUDE "TOTVS.CH"


User Function EX1_L13()
	
    Local cCaminho  := GetTempPath()
	Local cFolder   := "lista13-ex01\"
	
    if !ExistDir(cCaminho + cFolder)
		if MakeDir(cCaminho + cFolder) == 0
			if ExistBlock("EX2_L13")
				ExecBlock("EX2_L13", .F., .F., cCaminho + cFolder)
			endif	
		else
			FwAlertError("Erro na criação da pasta!", "Erro")
		endif
	else
		if ExistBlock("EX2_L13")
			ExecBlock("EX2_L13", .F., .F., cCaminho + cFolder)
		endif
	endif

Return
