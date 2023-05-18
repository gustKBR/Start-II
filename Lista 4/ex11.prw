#INCLUDE "TOTVS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
 
#DEFINE C_GRUPO "99"
#DEFINE C_FILIAL "01"


User Function PesqProd()

    Local cTitle  := "Pesquisa Produto"
    Local cTexto  := "Digite o código do produto: "
    Local cCod    := Space(15)
    Local nOp     := 0
    Local oDlg    := NIL

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO 100, 450 PIXEL
    
        @ 014, 010 SAY    cTexto        SIZE 120, 12 OF oDlg PIXEL
        @ 010, 090 MSGET  cCod          SIZE 55, 11 OF oDlg PIXEL
        @ 010, 160 BUTTON "Pesquisar"   SIZE 55, 11 OF oDlg PIXEL ACTION BuscaProd(cCod)
        @ 035, 160 BUTTON "Cancelar"    SIZE 55, 11 OF oDlg PIXEL ACTION (nOp := 2, oDlg:End())
    
    ACTIVATE MSDIALOG oDlg CENTERED

Return


Static Function BuscaProd(cCod)

    Local aArea     := GetArea()
    Local cAlias    := GetNextAlias()
    Local cQuery    := ""
    Local cMsg      := ""
    Local cCodigo   := ""
    Local cDescri   := ""
    Local cPrecoVen := ""
    Local nCont     := 0

    RpcSetEnv(C_GRUPO, C_FILIAL)

    cQuery := "SELECT B1_COD, B1_DESC, B1_PRV1 " + CRLF
    cQuery += "FROM " + RetSqlName("SB1") + CRLF
    cQuery += "WHERE D_E_L_E_T_ = ''" + CRLF
    cQuery += "ORDER BY B1_DESC"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())

      cCodigo := &(cAlias)->(B1_COD)
      cDescri := &(cAlias)->(B1_DESC)
      cPrecoVen := &(cAlias)->(B1_PRV1)

      if AllTrim(cCod) == AllTrim(cCodigo)
          cMsg += "Código: "    + cCodigo + CRLF + ; 
                  "Descrição: " + cDescri + CRLF + ;
                  "Preço de venda: R$" + AllTrim(cValToChar(cPrecoVen)) + CRLF + ;
                  "-------------------------" + CRLF
          nCont++
      endif

      &(cAlias)->(DbSkip())

    enddo

    if nCont > 0
        FwAlertSuccess(cMsg, "Produto com o código digitado")
    else
        FwAlertError("Este código não corresponde a nenhum produto")
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return
