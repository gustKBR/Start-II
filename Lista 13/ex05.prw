#INCLUDE "TOTVS.CH"


User Function EX5_L13()

	Local cFolder   := GetTempPath() + "\lista13-ex01\"
    Local aArquivos := DIRECTORY(cFolder + "*.*", "D", , , 1)
    Local nI        := 0

    if ExistDir(cFolder)
        if MsgYesNo("Tem certeza que deseja excluir a pasta?", "Aten��o")
            if Len(aArquivos) > 0
                for nI := 1 to len(aArquivos)
                    if FErase(cFolder + aArquivos[nI][1]) == -1 
                        MsgStop("Erro na exclus�o do arquivo" + aArquivos[nI][1])
                    endif 
                next 
            endif
    
            if DirRemove(cFolder)
                FwAlertSuccess("A pasta foi exclu�da com sucesso!", "Sucesso")
            else 
                FwAlertError9("N�o foi poss�vel excluir a pasta!", "Erro")
            endif 
        endif 
    endif 

Return 
