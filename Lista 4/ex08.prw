#INCLUDE "TOTVS.CH"


User Function DadosIMC()

    Local cTitle    := "Cálculo IMC"
    Local cTexto    := "Digite seu peso (em kg): "
    Local cTexto2   := "Digite sua altura (em metros): "
    Local nOp       := 0
    Local nPeso     := Space(3)
    Local nAltura   := Space(3)
    Local oDlg      := NIL

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO 200, 550 PIXEL
    
        @ 014, 010 SAY    cTexto     SIZE 120, 12 OF oDlg PIXEL
        @ 034, 010 SAY    cTexto2    SIZE 120, 12 OF oDlg PIXEL
        @ 010, 130 MSGET  nPeso      SIZE 55, 11 OF oDlg PIXEL
        @ 030, 130 MSGET  nAltura    SIZE 55, 11 OF oDlg PIXEL PICTURE "@R 9.99"
        @ 010, 200 BUTTON "Calcular" SIZE 55, 11 OF oDlg PIXEL ACTION CalculaIMC(nPeso, nAltura)
        @ 030, 200 BUTTON "Cancelar" SIZE 55, 11 OF oDlg PIXEL ACTION (nOp := 2, oDlg:End())
    
    ACTIVATE MSDIALOG oDlg CENTERED

Return


Static Function CalculaIMC(nPeso, nAltura)

    Local nImc := 0

    nImc := Val(nPeso) / (Val(nAltura) ^ 2)

    if nImc < 18.5
        FwAlertInfo("Seu IMC é " + cValToChar(nImc) + CRLF + "Magreza - Obesidade (Grau): 0")
    elseif nImc >= 18.5 .AND. nImc <= 24.9
        FwAlertInfo("Seu IMC é " + cValToChar(nImc) + CRLF + "Normal - Obesidade (Grau): 0")
    elseif nImc >= 25.0 .AND. nImc <= 29.9
        FwAlertInfo("Seu IMC é " + cValToChar(nImc) + CRLF + "Sobrepeso - Obes. (Grau): I")
    elseif nImc >= 30.0 .AND. nImc <= 39.9
        FwAlertInfo("Seu IMC é " + cValToChar(nImc) + CRLF + "Obesidade - Obes. (Grau): II")
    else
        FwAlertInfo("Seu IMC é " + cValToChar(nImc) + CRLF + "Obes. Grave - Obes. (Grau): III")
    endif

Return
