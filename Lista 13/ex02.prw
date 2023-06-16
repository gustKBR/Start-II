#INCLUDE "TOTVS.CH"


User Function EX2_L13()

	Local cCaminho  := PARAMIXB
	Local cFile     := "Lista13Ex02.txt"
	Local cTexto    := ""
	Local oWriter   := FwFileWriter():New(cCaminho + cFile, .T.)

	if File(cCaminho + cFile)
		FwAlertInfo("Outro arquivo nesta pasta já possui este nome!", "Atenção")
	else
		if !oWriter:Create()
			FwAlertError("Erro na criação do arquivo!" + CRLF + oWriter:Error():Message, "Erro")
		else
			cTexto := "Hello World!" + CRLF
			oWriter:Write(cTexto)
			oWriter:Close()

            if MsgYesNo("O arquivo foi gerado com sucesso", "Deseja Abri-lo?")
                ShellExecute("OPEN", cFile, "", cCaminho, 1)
            endif
		endif
	endif

Return
