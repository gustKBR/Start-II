#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "FWPRINTSETUP.CH"
#INCLUDE "RPTDEF.CH"

#DEFINE PRETO    RGB(000,000,000)
#DEFINE MAX_LINE 770


User Function EX2_L11()

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

    cQuery := "SELECT A2_COD, A2_NOME, A2_NREDUZ, A2_END, A2_BAIRRO, A2_MUN, A2_EST, A2_CEP, A2_EMAIL, A2_HPAGE" + CRLF
    cQuery += "FROM " + RetSqlName("SA2") + CRLF
    cQuery += "WHERE D_E_L_E_T_ = ' ' AND A2_COD = '" + SA2->A2_COD + "'"
    
    TCQUERY cQuery ALIAS (cAlias) NEW
    
    (cAlias)->(DbGoTop())
    
    if (cAlias)->(EOF())
        cAlias := ""
    endif
    
    RestArea(aArea)

Return cAlias


Static Function CriaRel(cAlias)

    Local cCaminho := "C:\Users\gustk\Desktop\"
    Local cArquivo := "RelatorioFornecedor.pdf"

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

    oPrint:Say(30,20,  "Empresa/Filial: "+ AllTrim(SM0->M0_NOME) + " / " + AllTrim(SM0->M0_FILIAL), oFont14,,PRETO)
    oPrint:Say(50,230, "Relatório de Fornecedor", oFont14,,PRETO)
    
    oPrint:Box(70,15,770,580,"-8")
    
    oPrint:Box(780,15,820,580,"-8")

Return


Static Function ImpDados(cAlias)

    Private nCor    := PRETO
    
    DbSelectArea(cAlias)
    
    (cAlias)->(DbGoTop())
    
    oPrint:Say(nLinha+=20,210, "DADOS DO FORNECEDOR", oFont16,,nCor)
    
    oPrint:Say(nLinha,20,"Código:"   , oFont12B,,nCor)
    oPrint:Say(nLinha+=20,55, AllTrim((cAlias)->(A2_COD)), oFont12,,nCor)
    
    oPrint:Say(nLinha,20 ,"Nome Fornecedor:"  , oFont12B,,nCor)
    oPrint:Say(nLinha+=20,105, AllTrim((cAlias)->(A2_NOME)), oFont12,,nCor)
    
    oPrint:Say(nLinha,20 ,"Nome Fantasia:"  , oFont12B,,nCor)
    oPrint:Say(nLinha+=20,90, AllTrim((cAlias)->(A2_NREDUZ)), oFont12,,nCor)
    
    oPrint:Say(nLinha,20 ,"Endereço:"  , oFont12B,,nCor)
    oPrint:Say(nLinha+=20,67, AllTrim((cAlias)->(A2_END)), oFont12,,nCor)
    
    oPrint:Say(nLinha,20 ,"Bairro:"  , oFont12B,,nCor)
    oPrint:Say(nLinha,53, AllTrim((cAlias)->(A2_BAIRRO)), oFont12,,nCor)
    
    oPrint:Say(nLinha,200,"Cidade:"  , oFont12B,,nCor)
    oPrint:Say(nLinha+=20,235, AllTrim((cAlias)->(A2_MUN)) + " - " + AllTrim((cAlias)->(A2_EST)), oFont12,,nCor)
    
    oPrint:Say(nLinha,20 ,"CEP:"  , oFont12B,,nCor)
    oPrint:Say(nLinha+=20,45, AllTrim(TRANSFORM((cAlias)->(A2_CEP),"@R 99.999-999")), oFont12,,nCor)
    
    oPrint:Say(nLinha,20 ,"E-mail:"  , oFont12B,,nCor)
    oPrint:Say(nLinha,55, AllTrim((cAlias)->(A2_EMAIL)), oFont12,,nCor)
    
    oPrint:Say(nLinha,200 ,"Site:"  , oFont12B,,nCor)
    oPrint:Say(nLinha,225, AllTrim((cAlias)->(A2_HPAGE)), oFont12,,nCor)
    
    IncProc()
    
    (cAlias)->(DbCloseArea())

Return
