#INCLUDE "TOTVS.CH"


User Function EX3_L13()

	Local cCaminho  := GetTempPath() + "\lista13-ex01\"
	Local cFile     := "Lista13Ex02.txt"
	Local cMsg      := ""
	Local oArq      := FwFileReader():New(cCaminho + cFile)

	if oArq:Open()
		if !oArq:EOF()
			while oArq:HasLine()
				cMsg += oArq:GetLine(.T.)
			enddo
		endif

		oArq:Close()
	endif

	FwAlertInfo(cMsg, "Arquivo gerado com sucesso!")

Return
