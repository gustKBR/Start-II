#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE C_GRUPO     "99"
#DEFINE C_FILIAL    "01"

User Function EX7_L3()

    Local aArea         := GetArea()
    Local cAlias        := GetNextAlias()
    Local cQuery        := ""
    Local cMsg          := ""
    Local cNumPed       := ""
    Local cCli          := ""
    Local dDataInicio   := ""
    Local dDataFim      := ""

    RpcSetEnv(C_GRUPO, C_FILIAL)

    dDataInicio   := CTOD(FwInputBox("Consulta de Pedidos", "Informe a Data de Início"))
    dDataFim      := CTOD(FwInputBox("Consulta de Pedidos", "Informe a Data de Fim"))
   
    cQuery := "SELECT C5_NUM, C5_CLIENTE, C5_EMISSAO" + CRLF 
    cQuery += "FROM " + RetSqlName("SC5") + CRLF
    cQuery += "WHERE C5_EMISSAO BETWEEN '" + DTOS(dDataInicio) + "' AND '" + DTOS(dDataFim) + "'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    while &(cAlias)->(!EOF())
        cNumPed := &(cAlias)->(C5_NUM)
        cCli := &(cAlias)->(C5_CLIENTE)

        cMsg += "Pedido: " + cNumPed + CRLF
        cMsg += "Cliente: " + cCli + CRLF
        cMsg += "Emissão: " + &(cAlias)->(C5_EMISSAO) + CRLF

        &(cAlias)->(DbSkip())
    end 

    FwAlertInfo(cMsg, "Pedidos com emissão no período digitado")
    
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return
