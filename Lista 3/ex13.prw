#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

User Function EX13_L3()

    Local aDias := {"Domingo", "Segunda", "Ter�a", "Quarta", "Quinta", "Sexta", "S�bado"}
    Local nDia  := 0

    while nDia < 1 .OR. nDia > 7
        nDia := Val(FwInputBox("Digite o dia da semana em n�mero:"))

        if nDia < 1 .OR. nDia > 7
            FwAlertError("O n�mero digitado � inv�lido! Digite um n�mero entre 1 e 7", "Aten��o")
        endif
    enddo

    FwAlertInfo(aDias[nDia])

Return
