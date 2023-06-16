#INCLUDE "TOTVS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

#DEFINE ESQUERDA    1
#DEFINE CENTRO      2
#DEFINE DIREITA     3

#DEFINE GERAL       1
#DEFINE NUMERICO    2
#DEFINE CONTABIL    3
#DEFINE DATETIME    4


User Function EX2_L12()

	Local cCaminho  := "C:\Users\gustk\Desktop\"
	Local cFile     := "PlanilhaProdutos.xls"
	Local oExcel    := FwMsExcelEx():New()
	Local cAlias    := GetNextAlias()
	Local aArea     := GetArea()
	Local cQuery    := CriaQuery()
	
    RpcSetEnv("99","01")
	
    TCQUERY cQuery ALIAS (cAlias) NEW
	
    oExcel:AddWorkSheet("Planilha")
	
    oExcel:AddTable("Planilha", "Produtos")
	
    oExcel:AddColumn("Produtos", "Dados", PADR("Código",8)    , CENTRO  , GERAL)
	oExcel:AddColumn("Produtos", "Dados", PADR("Descrição",30), ESQUERDA, GERAL)
	oExcel:AddColumn("Produtos", "Dados", PADR("Tipo", 10)    , CENTRO  , GERAL)
	oExcel:AddColumn("Produtos", "Dados", PADR("U. Medida",10), CENTRO  , GERAL)
	oExcel:AddColumn("Produtos", "Dados", PADR("Preço",15)    , ESQUERDA, CONTABIL)
	
    oExcel:SetTitleFont("Poppins")
	oExcel:SetTitleBgColor("#f8f8f8")
	oExcel:SetTitleFrColor("#18311b")

	(cAlias)->(DbGoTop())
	
    while (cAlias)->(!EOF())
		if (cAlias)->(R_E_C_D_E_L_) > 0
			oExcel:SetCelFrColor("#FF0000")
			oExcel:AddRow("Produtos", "Dados", {(cAlias)->(B1_COD), (cAlias)->(B1_DESC), (cAlias)->(B1_TIPO), (cAlias)->(B1_UM), (cAlias)->(B1_PRV1)}, {1,2,3,4,5})
		else
			oExcel:AddRow("Produtos", "Dados", {(cAlias)->(B1_COD), (cAlias)->(B1_DESC), (cAlias)->(B1_TIPO), (cAlias)->(B1_UM), (cAlias)->(B1_PRV1)})
		endif
		
        (cAlias)->(DbSkip())
	enddo

	oExcel:Activate()
	
    oExcel:GetXMLFile(cCaminho + cFile)
	
    if ApOleClient("MsExcel")
		FwAlertSuccess("O arquivo foi criado com sucesso!", "Sucesso")
		oExec := MsExcel():New()
		oExec:WorkBooks:Open(cCaminho + cFile)
		oExec:SetVisible(.T.)
		oExec:Destroy()
	else
		FwAlertError("O arquivo não foi encontrado!", "Atenção")
	endif

	oExcel:DeActivate()
	
    RestArea(aArea)

Return


Static Function CriaQuery()

	Local cQuery := ""

	cQuery := "SELECT B1_COD, B1_DESC, B1_TIPO, B1_UM, B1_PRV1, R_E_C_D_E_L_" + CRLF
	cQuery += "FROM " + RetSqlName("SB1") + CRLF
	cQuery += "WHERE B1_COD != ' ' "

Return cQuery
