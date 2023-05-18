#INCLUDE "TOTVS.CH"


User Function ReajusteSal()

    Local cTitle    := "Calculo de reajuste de salário"
    Local cTexto    := "Digite o salário do funcionário: "
    Local cTexto2   := "Digite o percentual de reajuste: "
    Local nOp       := 0
    Local nSalario  := Space(10)
    Local nReajuste := Space(10)
    Local oDlg      := NIL

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO 100, 400 PIXEL
    
        @ 014, 010 SAY    cTexto     SIZE 80, 12 OF oDlg PIXEL
        @ 030, 010 SAY    cTexto2    SIZE 80, 12 OF oDlg PIXEL
        @ 010, 090 MSGET  nSalario   SIZE 45, 11 OF oDlg PIXEL
        @ 030, 090 MSGET  nReajuste  SIZE 45, 11 OF oDlg PIXEL  
        @ 010, 140 BUTTON "Reajuste" SIZE 55, 11 OF oDlg PIXEL ACTION CalcReajuste(nSalario, nReajuste)
        @ 030, 140 BUTTON "Sair"     SIZE 55, 11 OF oDlg PIXEL ACTION (nOp := 1, oDlg:End())
    
    ACTIVATE MSDIALOG oDlg CENTERED

Return


Static Function CalcReajuste(nSalario, nReajuste)

    FwAlertInfo("O valor do reajuste é R$"      + AllTrim(cValToChar((Val(nSalario) * ((Val(nReajuste)) / 100)))) + CRLF + ;
                "O salário reajustado é R$"     + AllTrim(cValToChar((Val(nSalario) * ((1 + (Val(nReajuste)) / 100))))), "Reajuste de salário")

Return
