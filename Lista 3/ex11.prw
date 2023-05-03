#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE C_GRUPO     "99"
#DEFINE C_FILIAL    "01"

User Function EX11_L3()

    Local aArea     := GetArea()
    Local cAlias    := GetNextAlias()
    Local cQuery    := ""
    Local cMsg      := ""
    Local cCodigo   := ""
    Local cNome     := ""

    RpcSetEnv(C_GRUPO, C_FILIAL)

    cQuery := "SELECT A2_COD, A2_NOME" + CRLF
    cQuery += "FROM " + RetSqlName("SA2") + CRLF
    cQuery += "WHERE A2_EST = 'SP'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())
    
    while &(cAlias)->(!EOF())

        cCodigo := &(cAlias)->(A2_COD)
        cNome := &(cAlias)->(A2_NOME)

        cMsg += "Código: " + cCodigo + CRLF
        cMsg += "Fornecedor: " + cNome + CRLF
        cMsg += "------------------------------" + CRLF

        &(cAlias)->(DbSkip())
        
    enddo

    FwAlertInfo(cMsg, "Fornecedores do estado de São Paulo")
    
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return
