#INCLUDE "TOTVS.CH"


User Function CalculoTinta()

    Local cTitle    := "Calculo da área"
    Local cTexto    := "Digite a largura da parede em m²: "
    Local cTexto2   := "Digite a altura da parede em m²: "
    Local nOp       := 0
    Local nLargura  := Space(10)
    Local nAltura   := Space(10)
    Local oDlg      := NIL

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO 100, 400 PIXEL
    
        @ 014, 010 SAY    cTexto     SIZE 90, 12 OF oDlg PIXEL
        @ 030, 010 SAY    cTexto2    SIZE 90, 12 OF oDlg PIXEL
        @ 010, 100 MSGET  nLargura   SIZE 35, 11 OF oDlg PIXEL
        @ 030, 100 MSGET  nAltura    SIZE 35, 11 OF oDlg PIXEL
        @ 010, 140 BUTTON "Calcular" SIZE 55, 11 OF oDlg PIXEL ACTION CalcArea(nLargura, nAltura)
        @ 030, 140 BUTTON "Sair"     SIZE 55, 11 OF oDlg PIXEL ACTION (nOp := 1, oDlg:End())
        
    ACTIVATE MSDIALOG oDlg CENTERED

Return


Static Function CalcArea(nLargura, nAltura)

    FwAlertInfo("Área da parede: "                      + AllTrim(cValToChar((Val(nLargura) * ((Val(nAltura)))))) + "m²" + CRLF + ;
                "A quantidade de tinta necessária é "   + AllTrim(cValToChar((Val(nLargura) * ((Val(nAltura)))) / 2)) + " litros", "Tinta necessária")

Return
