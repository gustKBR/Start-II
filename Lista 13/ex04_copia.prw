#INCLUDE "TOTVS.CH"


User Function EX4CO_L13()

	Local cFolderFrom   := GetTempPath() + "\lista13-ex1\"
    Local cFolderTo     := "\Lista 13\"
    Local aArquivos     := Directory(cFolderFrom + "*.*", "D", , , 1)
    Local nI            := 0 

    if len(aArquivos) > 0 
        for nI := 3 to len(aArquivos)
            if !CpyT2S(cFolderFrom + aArquivos[nI][1], cFolderTo)
                MsgStop("Erro na cópia do arquivo (" + aArquivos[nI][1] + ")")
            endif 
        next 

        FwAlertSuccess("O(s) arquivo(s) foi(ram) copiado(s) para a nova pasta destino!", "Sucesso")
    else 
        FwAlertInfo("Não existe nenhum arquivo ou subpasta na pasta destino!", "Atenção")
    endif 

Return
