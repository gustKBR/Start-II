#INCLUDE "TOTVS.CH"


User Function CalculoTmb()

    Local cTitle    := "Cálculo TMB"
    Local cTexto    := "Digite seu peso (em kg): "
    Local cTexto2   := "Digite sua altura (em cm): "
    Local cTexto3   := "Digite sua idade: "
    Local nOp       := 0
    Local nPeso     := Space(3)
    Local nAltura   := Space(3)
    Local nIdade    := Space(3)
    Local oDlg      := NIL

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO 200, 450 PIXEL
    
        @ 014, 010 SAY    cTexto        SIZE 120, 12 OF oDlg PIXEL
        @ 034, 010 SAY    cTexto2       SIZE 120, 12 OF oDlg PIXEL
        @ 054, 010 SAY    cTexto3       SIZE 120, 12 OF oDlg PIXEL
        @ 010, 090 MSGET  nPeso         SIZE 55, 11 OF oDlg PIXEL
        @ 030, 090 MSGET  nAltura       SIZE 55, 11 OF oDlg PIXEL
        @ 050, 090 MSGET  nIdade        SIZE 55, 11 OF oDlg PIXEL
        @ 010, 160 BUTTON "TMB Homem"   SIZE 55, 11 OF oDlg PIXEL ACTION TmbHomem(nPeso, nAltura, nIdade)
        @ 030, 160 BUTTON "TMB Mulher"  SIZE 55, 11 OF oDlg PIXEL ACTION TmbMulher(nPeso, nAltura, nIdade)
        @ 075, 160 BUTTON "Sair"        SIZE 55, 11 OF oDlg PIXEL ACTION (nOp := 2, oDlg:End())
    
    ACTIVATE MSDIALOG oDlg CENTERED

Return


Static Function TmbHomem(nPeso, nAltura, nIdade)

    Local nTmb := 0

    nTmb := 66.5 + (13.75 * Val(nPeso)) + (5.003 * Val(nAltura)) - (6.75 * Val(nIdade))
    
    FwAlertInfo("Sua Taxa Metabólica Basal é "+ AllTrim(cValToChar(nTmb)), "TMB do paciente")

Return


Static Function TmbMulher(nPeso, nAltura, nIdade)

    Local nTmb := 0

    nTmb := 655.1  + (9.563 * Val(nPeso)) + (1.850 * Val(nAltura)) - (4.676 * Val(nIdade))
    
    FwAlertInfo("Sua Taxa Metabólica Basal é "+ AllTrim(cValToChar(nTmb)), "TMB do paciente")

Return
