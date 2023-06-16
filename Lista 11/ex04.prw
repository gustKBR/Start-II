#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "FWPRINTSETUP.CH"
#INCLUDE "RPTDEF.CH"

#DEFINE PRETO    RGB(000,000,000)
#DEFINE MAX_LINE 760


User Function EX4_L11()

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

    cQuery := "SELECT SC7.C7_NUM, SC7.C7_EMISSAO, SC7.C7_FORNECE, SC7.C7_LOJA, SC7.C7_COND, SC7.C7_PRODUTO, SC7.C7_DESCRI, SC7.C7_QUANT, SC7.C7_PRECO, SC7.C7_TOTAL, E4.E4_DESCRI, A2.A2_NOME" + CRLF
    cQuery += "FROM " + RetSqlName("SC7") + " SC7" + CRLF
    cQuery += "INNER JOIN " + RetSqlName("SE4") + " E4 ON SC7.C7_COND = E4.E4_CODIGO" + CRLF
    cQuery += "INNER JOIN " + RetSqlName("SA2") + " A2 ON SC7.C7_FORNECE = A2.A2_COD" + CRLF
    cQuery += "WHERE SC7.D_E_L_E_T_ = ' ' AND C7_NUM = '" + SC7->C7_NUM + "'"

    TCQUERY cQuery ALIAS (cAlias) NEW

    (cAlias)->(DbGoTop())

    if (cAlias)->(EOF())
        cAlias := ""
    endif

    RestArea(aArea)

Return cAlias


Static Function CriaRel(cAlias)

    Local cCaminho := "C:\Users\gustk\Desktop\"
    Local cArquivo := "RelatorioPedCompra2.pdf"

    Private nLinha := 90
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
    
    oPrint:Box(15,15,60,580,"-8")

    oPrint:Line(35,15,35,580,,"-6")
    
    oPrint:Say(30,20,  "Empresa/Filial: " + AllTrim(SM0->M0_NOME) + " / " + AllTrim(SM0->M0_FILIAL), oFont16,,PRETO)
    oPrint:Say(50,230, "Relatório de Pedido de Compra", oFont16,,PRETO)
    
    oPrint:Box(70,15,770,580,"-8")

    oPrint:Box(780,15,820,580,"-8")

Return


Static Function ImpDados(cAlias)

    Local cPreco      := ""
    Local nTotVenda   := 0

    Private nCor      := PRETO

    DbSelectArea(cAlias)

    (cAlias)->(DbGoTop())
    
    oPrint:Say(nLinha,20, "Número do Pedido:", oFont14,,nCor)
    oPrint:Say(nLinha,110, AllTrim((cAlias)->(C7_NUM)), oFont12,,nCor)
    
    oPrint:Say(nLinha,260, "Cód. Fornecedor:", oFont14,,nCor)
    oPrint:Say(nLinha,340, AllTrim((cAlias)->(C7_FORNECE)), oFont12,,nCor)
    
    oPrint:Say(nLinha,380, "Loja:", oFont14,,nCor)
    oPrint:Say(nLinha+=15,405, AllTrim((cAlias)->(C7_LOJA)), oFont12,,nCor)
    
    oPrint:Say(nLinha,20, "Fornecedor:", oFont14,,nCor)
    oPrint:Say(nLinha,85, AllTrim((cAlias)->(A2_NOME)), oFont12,,nCor)
    
    oPrint:Say(nLinha,260, "Data Emissão:", oFont14,,nCor)
    oPrint:Say(nLinha+=15,330, TRANSFORM(DtoC(StoD((cAlias)->(C7_EMISSAO))), "@R 99/99/9999"), oFont12,,nCor)
    
    oPrint:Say(nLinha,20, "Cond. Pagamento:", oFont14,,nCor)
    oPrint:Say(nLinha+=15,105, AllTrim((cAlias)->(C7_COND)) + " - " + AllTrim((cAlias)->(E4_DESCRI)), oFont12,,nCor)
    
    Item()
    
    while (cAlias)->(!EOF())
        BreakPag()
        
        oPrint:Say(nLinha,30, (cAlias)->(C7_PRODUTO), oFont10,,PRETO)
        oPrint:Say(nLinha,80, (cAlias)->(C7_DESCRI) , oFont10,,PRETO)
        
        oPrint:Say(nLinha,360, cValToChar((cAlias)->(C7_QUANT)),oFont10,,PRETO)
        
        cPreco := "R$" + AllTrim(STR((cAlias)->(C7_PRECO),,2))
        oPrint:Say(nLinha,415, cPreco, oFont10,,PRETO)
        
        cPreco := "R$" + AllTrim(STR((cAlias)->(C7_TOTAL),,2))
        oPrint:Say(nLinha,500, cPreco, oFont10,,PRETO)
        
        nLinha += 20
        
        nTotVenda += (cAlias)->(C7_TOTAL)
        
        IncProc()
        
        (cAlias)->(DbSkip())
    enddo
    
    nLinha -= 10
    
    oPrint:Line(nLinha,30,nLinha,555,,"-6")
    
    nLinha += 10
    
    cPreco := "R$" + AllTrim(Str(nTotVenda,,2))
    oPrint:Say(nLinha,30 ,"Total da venda: " ,oFont12,,PRETO)
    oPrint:Say(nLinha,140 , cPreco    ,oFont12,,PRETO)
    
    (cAlias)->(DbCloseArea())

Return


Static Function Item()

    oPrint:Say(nLinha,280, "ITENS", oFont12,,nCor)

    nLinha += 10
    
    oPrint:Box(nLinha,20,MAX_LINE,575,"-8")
    
    nLinha += 20
    
    oPrint:Say(nLinha,30 , "CÓDIGO"         ,oFont12,,PRETO)
    oPrint:Say(nLinha,80 , "DESCRIÇÃO"      ,oFont12,,PRETO)
    oPrint:Say(nLinha,340, "QUANTIDADE"     ,oFont12,,PRETO)
    oPrint:Say(nLinha,415, "VALOR UNITÁRIO" ,oFont12,,PRETO)
    oPrint:Say(nLinha,500, "VALOR TOTAL"    ,oFont12,,PRETO)
    
    nLinha += 5
    
    oPrint:Line(nLinha,30,nLinha,555,,"-6")
    
    nLinha += 20

Return


Static Function BreakPag()

    if nLinha > (MAX_LINE-20)
        oPrint:EndPage()
        oPrint:StartPage()

        nLinha := 90

        Cabecalho()
        Item()
    endif

Return
