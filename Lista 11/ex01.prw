#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "FWPRINTSETUP.CH"
#INCLUDE "RPTDEF.CH"

#DEFINE PRETO    RGB(000,000,000)
#DEFINE MAX_LINE 770


User Function EX1_L11()

    Local cAlias := CriaQuery()
    
    if !Empty(cAlias)
        Processa({|| CriaRel(cAlias)}, "Aguarde...", "Imprimindo Relatório")
    else
        FwAlertError("Nenhum registro foi encontrado na consulta!", "Atenção")
    endif

Return 


Static Function CriaQuery()
    
    Local aArea     := GetArea()
    Local cAlias    := GetNextAlias()
    Local cQuery    := ""

    cQuery := "SELECT B1_COD, B1_DESC, B1_UM, B1_PRV1, B1_LOCPAD" + CRLF
    cQuery += "FROM " + RetSqlName("SB1") + CRLF
    cQuery += "WHERE D_E_L_E_T_ = ' '" + CRLF
    cQuery += "ORDER BY B1_COD"
    
    TCQUERY cQuery ALIAS (cAlias) NEW
    
    (cAlias)->(DbGoTop())
    
    if (cAlias)->(EOF())
        cAlias := ""
    endif
    
    RestArea(aArea)

Return cAlias


Static Function CriaRel(cAlias)

    Local cCaminho := "C:\Users\gustk\Desktop\"
    Local cArquivo := "RelatorioProdutos.pdf"

    Private nLinha := 80
    Private oPrint
    Private oFont10  := TFont():New("Arial",,10,, .F.,,,,,.F.,.F.)
    Private oFont12  := TFont():New("Arial",,12,, .F.,,,,,.F.,.F.)
    Private oFont14  := TFont():New("Arial",,14,, .F.,,,,,.F.,.F.)
    Private oFont16  := TFont():New("Arial",,16,, .T.,,,,,.T.,.F.)

    oPrint := FwMsPrinter():New(cArquivo,IMP_PDF, .F., "", .T.,, @oPrint, "",,,,.T.)

    oPrint:cPathPDF := cCaminho

    oPrint:SetPortrait()
    oPrint:SetPaperSize(9)

    oPrint:StartPage()

    Cabecalho()

    ImpDados(cAlias)

    oPrint:EndPage()
    oPrint:Preview()

Return


Static Function Cabecalho()

    oPrint:Box(15,15,85,580,"-8")
    
    oPrint:Line(50,15,50,580,,"-6")
    
    oPrint:Say(30,20,  "Empresa/Filial: "+ AllTrim(SM0->M0_NOME) + " / " + AllTrim(SM0->M0_FILIAL), oFont14,, PRETO)
    oPrint:Say(50,220, "Relatório de Produtos", oFont14,,PRETO)
    
    oPrint:Say(nLinha, 20 , "CÓDIGO"    , oFont12,, PRETO)
    oPrint:Say(nLinha, 90 , "DESCRIÇÃO" , oFont12,, PRETO)
    oPrint:Say(nLinha, 300, "UN. MEDIDA", oFont12,, PRETO)
    oPrint:Say(nLinha, 380, "PREÇO"     , oFont12,, PRETO)
    oPrint:Say(nLinha, 470, "ARMAZÉM"   , oFont12,, PRETO)
    
    nLinha += 5

    oPrint:Line(nLinha,15,nLinha,580,PRETO,"-6")

    nLinha += 20

Return


Static Function ImpDados(cAlias)

    Local cPreco    := ""
    Private nCor    := PRETO

    DbSelectArea(cAlias)

    (cAlias)->(DbGoTop())

    while (cAlias)->(!EOF())
        BreakPag()

        cPreco := "R$ " + AllTrim(Str((cAlias)->(B1_PRV1),,2))

        oPrint:Say(nLinha, 20 , AllTrim((cAlias)->(B1_COD))   , oFont10,,nCor)
        oPrint:Say(nLinha, 90 , AllTrim((cAlias)->(B1_DESC))  , oFont10,,nCor)
        oPrint:Say(nLinha, 310, AllTrim((cAlias)->(B1_UM))    , oFont10,,nCor)
        oPrint:Say(nLinha, 370, cPreco, oFont10,,nCor)
        oPrint:Say(nLinha, 485, AllTrim((cAlias)->(B1_LOCPAD)), oFont10,,nCor)

        nLinha += 20

        IncProc()

        (cAlias)->(DbSkip())
    enddo

    (cAlias)->(DbCloseArea())

Return


Static Function BreakPag()

    if nLinha > MAX_LINE
        oPrint:EndPage()
        oPrint:StartPage()

        nLinha := 80

        Cabecalho()
    endif

Return
