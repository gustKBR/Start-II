#INCLUDE "TOTVS.CH"


User Function CotacaoDolar()

    Local cTitle        := "Conversão dólar -> real "
    Local cTexto        := "Digite a cotação do dólar: "
    Local cTexto2       := "Digite a quantidade de dólares: "
    Local nOp           := 0
    Local nCotacaoDolar := Space(10)
    Local nQtdDolar     := Space(10)
    Local oDlg          := NIL

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO 100, 400 PIXEL
    
        @ 014, 010 SAY    cTexto         SIZE 80, 12 OF oDlg PIXEL
        @ 030, 010 SAY    cTexto2        SIZE 80, 12 OF oDlg PIXEL
        @ 010, 090 MSGET  nCotacaoDolar  SIZE 45, 11 OF oDlg PIXEL
        @ 030, 090 MSGET  nQtdDolar      SIZE 45, 11 OF oDlg PIXEL
        @ 010, 140 BUTTON "Cotação"      SIZE 55, 11 OF oDlg PIXEL ACTION ConvertReal(nCotacaoDolar, nQtdDolar)
        @ 030, 140 BUTTON "Sair"         SIZE 55, 11 OF oDlg PIXEL ACTION (nOp := 1, oDlg:End())
    
    ACTIVATE MSDIALOG oDlg CENTERED

Return


Static Function ConvertReal(nCotacaoDolar, nQtdDolar)

    FwAlertInfo("$" + nQtdDolar + " em real é R$" + AllTrim(cValToChar(Val(nCotacaoDolar) * Val(nQtdDolar))), "Valor convertido em real")

Return
