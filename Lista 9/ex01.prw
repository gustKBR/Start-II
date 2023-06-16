#INCLUDE "TOTVS.CH"


User Function EX1_L9()

    Local cTitulo       := "Relat�rio de Produtos Cadastrados"
    Private cNomeRel    := "EX1_L9"
    Private cPrograma   := "EX1_L9"
    Private cDescri     := "Relat�rio"
    Private cTamanho    := "M"
    Private aReturn     := {"Zebrado", 1, "Administra��o", 1, 2,,, 1}
    Private cAlias      := "SB1"
    
    cNomeRel := SetPrint(cAlias, cPrograma,, @cTitulo, cDescri,,, .F.,, .T., cTamanho,, .F.)
    
    SetDefault(aReturn, cAlias)
    
    RptStatus({|| Imprime()}, cTitulo, "Gerando Relat�rio...")

Return 


Static Function Imprime()
    
    Local nLinha := 2
    Local nCont  := 0
    
    DbSelectArea("SB1")
    SB1->(DbSetOrder(1))
    SB1->(DbGoTop())
    
    while !EOF()
        if !Empty(SB1->B1_COD)
            nCont++

            @ ++nLinha, 00 PSAY PADR("C�digo: ", 15)         + AllTrim(SB1->B1_COD)
            @ ++nLinha, 00 PSAY PADR("Descri��o: ", 15)      + AllTrim(SB1->B1_DESC)
            @ ++nLinha, 00 PSAY PADR("Un. Medida: ", 15)     + AllTrim(SB1->B1_UM)
            @ ++nLinha, 00 PSAY PADR("Pre�o: ", 15)  + "R$"  + AllTrim(STR(SB1->B1_PRV1,,2))
            @ ++nLinha, 00 PSAY PADR("Armaz�m: ", 15)        + AllTrim(SB1->B1_LOCPAD)
            @ ++nLinha, 00 PSAY Replicate("*", 40)
            
            if nCont == 10
                nCont := 0
                nLinha := 0
            endif
        endif
        
        SB1->(DbSkip())
    enddo
    
    SET DEVICE TO SCREEN
    
    if aReturn[5] == 1
        SET PRINTER TO DbCommitAll()
        OurSpool(cNomeRel)
    endif
    
    MS_FLUSH()
Return
