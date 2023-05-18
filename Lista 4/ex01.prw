#INCLUDE "TOTVS.CH"


User Function DoisPositivos()

    Local cTitle    := "Calculadora"
    Local cTexto    := "Digite o primeiro valor: "
    Local cTexto2   := "Digite o segundo valor: "
    Local nOp       := 0
    Local nVal1     := Space(10)
    Local nVal2     := Space(10)
    Local oDlg      := NIL

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO 100, 400 PIXEL
    
        @ 014, 010 SAY    cTexto        SIZE 55, 07 OF oDlg PIXEL
        @ 030, 010 SAY    cTexto2       SIZE 55, 07 OF oDlg PIXEL
        @ 010, 070 MSGET  nVal1         SIZE 55, 11 OF oDlg PIXEL
        @ 030, 070 MSGET  nVal2         SIZE 55, 11 OF oDlg PIXEL
        @ 010, 140 BUTTON "Operações"   SIZE 55, 11 OF oDlg PIXEL ACTION Operacoes(nVal1, nVal2)
        @ 030, 140 BUTTON "Sair"        SIZE 55, 11 OF oDlg PIXEL ACTION (nOp := 1, oDlg:End())
    
    ACTIVATE MSDIALOG oDlg CENTERED

Return


Static Function Operacoes(nVal1, nVal2)

    nVal1 := Val(nVal1)
    nVal2 := Val(nVal2)

    FwAlertInfo("Soma: "        + AllTrim(cValToChar(nVal1 + nVal2)) + CRLF + ;
                "Diferença: "   + AllTrim(cValToChar(nVal1 - nVal2)) + CRLF + ;
                "Produto: "     + AllTrim(cValToChar(nVal1 * nVal2)) + CRLF + ;
                "Quociente: "   + AllTrim(cValToChar(nVal1 / nVal2)), "Operações")

Return
