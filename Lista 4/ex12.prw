#INCLUDE "TOTVS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

#DEFINE C_GRUPO "99"
#DEFINE C_FILIAL "01"


User Function DataPedCom()

    Local cTitle      := "Data Pedido de Compra"
    Local cTexto      := "Informe a data de início: "
    Local cTexto2     := "Informe a data de fim: "
    Local cDataInicio := Space(15)
    Local cDataFim    := Space(15)
    Local nOp         := 0
    Local oDlg        := NIL

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO 100, 450 PIXEL
    
      @ 014, 010 SAY    cTexto        SIZE 120, 12 OF oDlg PIXEL
      @ 030, 010 SAY    cTexto2       SIZE 120, 12 OF oDlg PIXEL
      @ 010, 090 MSGET  cDataInicio   SIZE 55, 11 OF oDlg PIXEL PICTURE "@R 99/99/9999"
      @ 030, 090 MSGET  cDataFim      SIZE 55, 11 OF oDlg PIXEL PICTURE "@R 99/99/9999"
      @ 010, 160 BUTTON "Buscar"      SIZE 55, 11 OF oDlg PIXEL ACTION PesqDatPed(cDataInicio, cDataFim)
      @ 035, 160 BUTTON "Cancelar"    SIZE 55, 11 OF oDlg PIXEL ACTION (nOp := 1, oDlg:End())
    
    ACTIVATE MSDIALOG oDlg CENTERED

Return


Static Function PesqDatPed(cDataInicio, cDataFim)

    Local aArea   := GetArea()
    Local cAlias  := GetNextAlias()
    Local cQuery  := ""
    Local cMsg    := ""
    Local nCont   := 0

    RpcSetEnv(C_GRUPO, C_FILIAL)

    cDataInicio := DTOS(CTOD(TRANSFORM(cDataInicio, "@R 99/99/9999")))
    cDataFim := DTOS(CTOD(TRANSFORM(cDataFim, "@R 99/99/9999")))

    cQuery := "SELECT C7_NUM, C7_EMISSAO" + CRLF 
    cQuery += "FROM " + RetSqlName("SC7") + CRLF 
    cQuery += "WHERE C7_EMISSAO BETWEEN '" + cDataInicio + "' AND '" + cDataFim + "'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    while &(cAlias)->(!EOF())

        cMsg += "Pedido: " + &(cAlias)->(C7_NUM) + CRLF 
        cMsg += "Data de emissão: " + &(cAlias)->(C7_EMISSAO) + CRLF 
        cMsg += "-------------------------" + CRLF

        nCont++

        if nCont == 10
            FwAlertInfo(cMsg, "Pedidos de compra no período informado")
            cMsg  := ""
            nCont := 0
        endif

        &(cAlias)->(DbSkip())

    enddo

    FwAlertInfo(cMsg, "Pedidos de compra no período informado")

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return
