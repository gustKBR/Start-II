#INCLUDE "TOTVS.CH"


User Function CadProd()

    Local cAlias      := "SB1"
    Private cCadastro := "Cadastro de Produtos"
    Private aRotina   := {{ "Pesquisar",    "AxPesqui", 0, 1 },;
                          { "Visualizar",   "AxVisual", 0, 2 },;
                          { "Incluir",      "AxInclui", 0, 3 },;
                          { "Alterar",      "AxAltera", 0, 4 },;
                          { "Excluir",      "AxDeleta", 0, 5 }}

    DbSelectArea(cAlias)
    DbSetOrder(1)

    MBrowse(,,,,cAlias,,,,,,,,,,,,,,)

    DbCloseArea()
    
Return
