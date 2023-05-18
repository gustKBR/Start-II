#INCLUDE "TOTVS.CH"


User Function CarroAlugado()

    Local cTitle    := "Valor do aluguel"
    Local cTexto    := "Quantos km percorridos: "
    Local cTexto2   := "Quantos dias de aluguel: "
    Local nOp       := 0
    Local nKm       := Space(10)
    Local nDias     := Space(10)
    Local oDlg      := NIL

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO 100, 400 PIXEL
    
        @ 014, 010 SAY    cTexto     SIZE 90, 12 OF oDlg PIXEL
        @ 030, 010 SAY    cTexto2    SIZE 90, 12 OF oDlg PIXEL
        @ 010, 100 MSGET  nKm        SIZE 35, 11 OF oDlg PIXEL
        @ 030, 100 MSGET  nDias      SIZE 35, 11 OF oDlg PIXEL  
        @ 010, 140 BUTTON "Calcular" SIZE 55, 11 OF oDlg PIXEL ACTION CalcPreco(nKm, nDias)
        @ 030, 140 BUTTON "Sair"     SIZE 55, 11 OF oDlg PIXEL ACTION (nOp := 1, oDlg:End())
    
    ACTIVATE MSDIALOG oDlg CENTERED

Return


Static Function CalcPreco(nKm, nDias)

    FwAlertInfo("O preço a pagar é R$" + AllTrim(cValToChar(((Val(nKm)) * 0.15) + ((Val(nDias)) * 60))), "Valor do aluguel")

Return
