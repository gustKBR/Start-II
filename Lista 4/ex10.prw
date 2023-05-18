#INCLUDE "TOTVS.CH"


User Function CalculoFolha()

    Local cTitle    := "Folha de pagamento"
    Local cTexto    := "Informe o valor da hora: "
    Local cTexto2   := "Informe a quantidade de horas: "
    Local nOpcao    := 0
    Local nHora     := Space(5)
    Local nQtdHoras := Space(5)
    Local oDlg      := NIL

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO 200, 450 PIXEL
    
        @ 014, 010 SAY    cTexto     SIZE 120, 12 OF oDlg PIXEL
        @ 034, 010 SAY    cTexto2    SIZE 120, 12 OF oDlg PIXEL
        @ 010, 090 MSGET  nHora      SIZE 55, 11 OF oDlg PIXEL
        @ 030, 090 MSGET  nQtdHoras  SIZE 55, 11 OF oDlg PIXEL
        @ 010, 160 BUTTON "Calcular" SIZE 55, 11 OF oDlg PIXEL ACTION FolhaPagamento(nHora, nQtdHoras)
        @ 075, 160 BUTTON "Cancelar" SIZE 55, 11 OF oDlg PIXEL ACTION (nOpcao := 2, oDlg:End())
    
    ACTIVATE MSDIALOG oDlg CENTERED

Return


Static Function FolhaPagamento(nHora, nQtdHoras) 
    
    Local nSalarioBruto     := 0
    Local nIR               := 0
    Local nINSS             := 0
    Local nFGTS             := 0
    Local nTotDescontos     := 0
    Local nSalarioLiq       := 0
    Local cIR               := ""

    nHora := Val(nHora)
    nQtdHoras := Val(nQtdHoras)

    nSalarioBruto := nHora * nQtdHoras

    if nSalarioBruto > 1200 .AND. nSalarioBruto <= 1800
        cIR := "5%"
        nIR := 0.05 * nSalarioBruto
    elseif nSalarioBruto > 1800 .AND. nSalarioBruto <= 2500
        cIR := "10%"
        nIR := 0.10 * nSalarioBruto
    elseif nSalarioBruto > 2500
        cIR := "20%"
        nIR := 0.20 * nSalarioBruto
    else
        FwAlertInfo("Isento de desconto")
        nIR := 1 * nSalarioBruto
    endif

    nINSS := 0.10 * nSalarioBruto

    nFGTS := 0.11 * nSalarioBruto

    nTotDescontos := nIR + nINSS

    nSalarioLiq := nSalarioBruto - nTotDescontos

    FwAlertInfo("Salário bruto (" + AllTrim(cValToChar(nHora)) + "*" + AllTrim(cValToChar(nQtdHoras)) + "): R$" + AllTrim(StrZero(nSalarioBruto, 7, 2)) + CRLF + ;
                "( - )IR (" + AllTrim(cIR)+"): R$" + AllTrim(StrZero(nIR, 5, 2)) + CRLF + ;
                "( - ) INSS (10%): R$" + AllTrim(StrZero(nINSS, 6, 2)) + CRLF + ;
                "FGTS (11%): R$" + AllTrim(StrZero(nFGTS, 6, 2)) + CRLF + ;
                "Total de descontos: R$" + AllTrim(StrZero(nTotDescontos, 6, 2)) + CRLF + ;
                "Salário Líquido: R$" + AllTrim(StrZero(nSalarioLiq, 7, 2)))

Return
