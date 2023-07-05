#INCLUDE "TOTVS.CH"

#DEFINE NOME_ALUNO  1
#DEFINE NOTA1       2
#DEFINE NOTA2       3
#DEFINE NOTA3       4
#DEFINE MEDIA       5


User Function EX16_L5()

    Local aNotas    := {{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0}}
    Local nCont     := 0
    Local nCont2    := 0
    Local cMsg      := ""

    for nCont := 1 to 4
        for nCont2 := 1 to 5
            if nCont2 == 1
                aNotas[nCont, NOME_ALUNO] := FWInputBox("Informe o nome do " + cValToChar(nCont) + "º aluno: ")
                cMsg += "Aluno:" + aNotas[nCont, NOME_ALUNO] + CRLF
            elseif nCont2 > 1 .AND. nCont2 <= 4
                aNotas[nCont, nCont2] := Val(FWInputBox("Informe a " + cValToChar(nCont2 - 1) + "ª nota do aluno: "))
                cMsg += cValToChar(nCont2-1) + "ª nota: " + cValToChar(aNotas[nCont, nCont2]) + CRLF
            else
                aNotas[nCont, MEDIA_ALUNO] := ((aNotas[nCont, NOTA1_ALUNO] + aNotas[nCont, NOTA2_ALUNO] + aNotas[nCont, NOTA3_ALUNO]) / 3)
                cMsg += "Media: " + cValToChar(aNotas[nCont, MEDIA_ALUNO]) + CRLF + CRLF
            endif
        next
    next

    FwAlertInfo(cMsg, "Conteúdo do Array")

Return
