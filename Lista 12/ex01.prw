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


User Function EX1_L12()
	Local cCaminho  := "C:\Users\gustk\Desktop\"
	Local cFile     := "PlanilhaFornecedor.xls"
	Local oExcel    := FwMsExcelEx():New()
	Local cAlias    := GetNextAlias()
	Local aArea     := GetArea()
	Local cQuery    := CriaQuery()

	RpcSetEnv("99","01")
	
    TCQUERY cQuery ALIAS (cAlias) NEW
	
    oExcel:AddWorkSheet("Planilha")
	
    oExcel:AddTable("Planilha", "Fornecedores")
	oExcel:SetBgColorHeader("#17a217")
	
    oExcel:SetTitleFont("Poppins")
	oExcel:SetTitleBgColor("#f8f8f8")
	oExcel:SetTitleFrColor("#17a217")
	oExcel:SetLineBgColor("#5ff767")
	oExcel:Set2LineBgColor("#f8f8f8")
    
	oExcel:AddColumn("Fornecedores", "Dados", PADR("Código",8)   , ESQUERDA, GERAL)
	oExcel:AddColumn("Fornecedores", "Dados", PADR("Nome",40)    , ESQUERDA, GERAL)
	oExcel:AddColumn("Fornecedores", "Dados", PADR("Loja",5)     , CENTRO  , GERAL)
	oExcel:AddColumn("Fornecedores", "Dados", PADR("CNPJ",15)    , CENTRO  , GERAL)
	oExcel:AddColumn("Fornecedores", "Dados", PADR("Endereço",30), ESQUERDA, GERAL)
	oExcel:AddColumn("Fornecedores", "Dados", PADR("Bairro",20)  , ESQUERDA, GERAL)
	oExcel:AddColumn("Fornecedores", "Dados", PADR("Cidade",20)  , ESQUERDA, GERAL)
	oExcel:AddColumn("Fornecedores", "Dados", PADR("UF",4)       , CENTRO  , GERAL)
	
	(cAlias)->(DbGoTop())

	while (cAlias)->(!EOF())
		oExcel:AddRow("Fornecedores", "Dados", {(cAlias)->(A2_COD), (cAlias)->(A2_NOME), (cAlias)->(A2_LOJA), (cAlias)->(A2_CGC), (cAlias)->(A2_END), (cAlias)->(A2_BAIRRO), (cAlias)->(A2_MUN), (cAlias)->(A2_EST)})
		(cAlias)->(DbSkip())
	enddo
	
    oExcel:Activate()
	
    oExcel:GetXMLFile(cCaminho + cFile)
	
    if ApOleClient("MsExcel")
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

	cQuery := "SELECT A2_COD, A2_NOME, A2_LOJA, A2_CGC, A2_END, A2_BAIRRO, A2_MUN, A2_EST" + CRLF
	cQuery += "FROM " + RetSqlName("SA2") + CRLF
	cQuery += "WHERE D_E_L_E_T_ = ' '' "
	
Return cQuery 
