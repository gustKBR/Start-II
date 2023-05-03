#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

User Function EX13_L3()

    Local aDias := {"Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"}
    Local nDia  := 0

    while nDia < 1 .OR. nDia > 7
        nDia := Val(FwInputBox("Digite o dia da semana em número:"))

        if nDia < 1 .OR. nDia > 7
            FwAlertError("O número digitado é inválido! Digite um número entre 1 e 7", "Atenção")
        endif
    enddo

    FwAlertInfo(aDias[nDia])

Return
