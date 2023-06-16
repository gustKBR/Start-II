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


User Function EX3_L12()

	Local cCaminho  := "C:\Users\gustk\Desktop\"
	Local cFile     := "PlanilhaCursos.xls"
	Local oExcel    := FwMsExcel():New()
	Local cAlias    := GetNextAlias()
	Local aArea     := GetArea()
	Local cQuery    := CriaQuery()
	Local cUltCurso := ""

	RpcSetEnv("99","01")

	oExcel:SetTitleBgColor("#ffffff")
	oExcel:SetTitleFrColor("#a200ff")
	oExcel:SetBgColorHeader("#a200ff")
	oExcel:SetLineBgColor("#eda9f5")
	oExcel:Set2LineBgColor("#e5e7e4")
	
    TCQUERY cQuery ALIAS (cAlias) NEW

	(cAlias)->(DbGoTop())
	
    while (cAlias)->(!EOF())
		if (cAlias)->(ZZC_COD) != cUltCurso
			oExcel:AddWorkSheet((cAlias)->(ZZC_NOME))

			oExcel:AddTable((cAlias)->(ZZC_NOME), (cAlias)->(ZZC_NOME))
			
            oExcel:AddColumn((cAlias)->(ZZC_NOME), (cAlias)->(ZZC_NOME), PADR("Código",8)            , CENTRO  , GERAL)
			oExcel:AddColumn((cAlias)->(ZZC_NOME), (cAlias)->(ZZC_NOME), PADR("Nome do aluno(a)", 20), ESQUERDA, GERAL)
			oExcel:AddColumn((cAlias)->(ZZC_NOME), (cAlias)->(ZZC_NOME), PADR("Idade",10)            , CENTRO  , GERAL)
			
            cUltCurso := (cAlias)->(ZZC_COD)
		endif
		
        oExcel:AddRow((cAlias)->(ZZC_NOME), (cAlias)->(ZZC_NOME), {(cAlias)->(ZZB_COD), (cAlias)->(ZZB_NOME), (cAlias)->(ZA_IDADE)})
		
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

	cQuery := "SELECT ZZC_COD, ZZC_NOME, ZZB_COD, ZZB_NOME, ZA_IDADE" + CRLF
	cQuery += "FROM " + RetSqlName("ZZC") + " ZZC" + CRLF
	cQuery += "INNER JOIN " + RetSqlName("ZZB") + " ON ZZB_CURSO = ZZC_COD" + CRLF
	cQuery += "INNER JOIN " + RetSqlName("SZA") + " ON ZA_COD = ZZB_COD" + CRLF
	cQuery += "WHERE ZZC.D_E_L_E_T_ = ' ' ORDER BY ZZC_NOME"

Return cQuery
