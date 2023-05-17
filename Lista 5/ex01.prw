#INCLUDE "TOTVS.CH"


User Function EX1_L5()

    Local aDias     := {"Domingo","Segunda-Feira","Terça-Feira","Quarta-Feira","Quinta-Feira","Sexta-Feira","Sábado"}
    Local nDia      := 0
    Local cDia      := ""

    while nDia < 1 .OR. nDia > 7
        nDia := Val(FwInputBox("Digite um número de 1 a 7 de acordo com o dia da semana: "))

        if nDia < 1 .OR. nDia > 7
            FwAlertError("Você deve digitar um número entre 1 e 7!")
        endif
    enddo

    cDia := aDias[nDia]

    FwAlertInfo("O " + Alltrim(cValToChar(nDia)) + "º é equivalente a " + Alltrim(cValToChar(cDia)))

Return
