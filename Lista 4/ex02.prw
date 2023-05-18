#INCLUDE "TOTVS.CH"


User Function CotacaoDolar()

    Local cTitle        := "Convers�o d�lar -> real "
    Local cTexto        := "Digite a cota��o do d�lar: "
    Local cTexto2       := "Digite a quantidade de d�lares: "
    Local nOp           := 0
    Local nCotacaoDolar := Space(10)
    Local nQtdDolar     := Space(10)
    Local oDlg          := NIL

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO 100, 400 PIXEL
    
        @ 014, 010 SAY    cTexto         SIZE 80, 12 OF oDlg PIXEL
        @ 030, 010 SAY    cTexto2        SIZE 80, 12 OF oDlg PIXEL
        @ 010, 090 MSGET  nCotacaoDolar  SIZE 45, 11 OF oDlg PIXEL
        @ 030, 090 MSGET  nQtdDolar      SIZE 45, 11 OF oDlg PIXEL
        @ 010, 140 BUTTON "Cota��o"      SIZE 55, 11 OF oDlg PIXEL ACTION ConvertReal(nCotacaoDolar, nQtdDolar)
        @ 030, 140 BUTTON "Sair"         SIZE 55, 11 OF oDlg PIXEL ACTION (nOp := 1, oDlg:End())
    
    ACTIVATE MSDIALOG oDlg CENTERED

Return


Static Function ConvertReal(nCotacaoDolar, nQtdDolar)

    FwAlertInfo("$" + nQtdDolar + " em real � R$" + AllTrim(cValToChar(Val(nCotacaoDolar) * Val(nQtdDolar))), "Valor convertido em real")

Return
