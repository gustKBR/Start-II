#INCLUDE "TOTVS.CH"


User Function EX2_L9()
    
    Local cTitulo       := "Relatório de Produtos Cadastrados"
    Private cNomeRel    := "EX2_L9"
    Private cPrograma   := "EX2_L9"
    Private cDescri     := "Relatório"
    Private cTamanho    := "M"
    Private nLastKey    := 0
    Private aReturn     := {"Zebrado", 1, "Administração", 1, 2,,, 1}
    Private m_Pag       := 1
    Private cAlias      := "SB1"
    
    cNomeRel := SetPrint(cAlias, cPrograma,, @cTitulo, cDescri,,, .F.,, .T., cTamanho,, .F.)
    
    SetDefault(aReturn, cAlias)
    
    RptStatus({|| Imprime()}, cTitulo, "Gerando Relatório...")

Return 


Static Function Imprime()

    Local cCabecalho := "CÓDIGO" + Space(9) + "DESCRIÇÃO" + Space(24) + "UN. MEDIDA" + Space(5) + "PREÇO" + Space(10) + "ARMAZÉM"
    Local nLinha := 2
    Local nCont  := 0
    
    DbSelectArea("SB1")
    SB1->(DbSetOrder(1))
    SB1->(DbGoTop())
    
    Cabec("Produtos Cadastrados", cCabecalho, "", cPrograma, cTamanho, 15)
    
    while !EOF()
        if !Empty(SB1->B1_COD)
            nLinha++

            @ nLinha, 00 PSAY PADR(AllTrim(SB1->B1_COD),  10)
            @ nLinha, 10 PSAY PADR(AllTrim(SB1->B1_DESC), 35)
            @ nLinha, 45 PSAY PADR(AllTrim(SB1->B1_UM), 15)
            @ nLinha, 60 PSAY "R$" + AllTrim(STR(SB1->B1_PRV1,, 2))
            @ nLinha, 75 PSAY PADR(AllTrim(SB1->B1_LOCPAD), 10)
            @ ++nLinha, 00 PSAY Replicate("-", 90)
            
            nCont++
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
