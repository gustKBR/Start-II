#INCLUDE "TOTVS.CH"


#DEFINE cUsuario "admin"
#DEFINE cSenha    "1234"


User Function Login()

    Local cTitle    := "Login"
    Local cTexto    := "Usuário: "
    Local cTexto2   := "Senha: "
    Local nOp       := 0
    Local cLogin    := Space(5)
    Local cPass     := Space(5)
    Local oDlg      := NIL

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO 100, 400 PIXEL
    
        @ 014, 010 SAY    cTexto   SIZE 90, 12 OF oDlg PIXEL
        @ 034, 010 SAY    cTexto2  SIZE 90, 12 OF oDlg PIXEL
        @ 010, 080 MSGET  cLogin   SIZE 55, 11 OF oDlg PIXEL
        @ 030, 080 MSGET  cPass    SIZE 55, 11 OF oDlg PIXEL PASSWORD
        @ 010, 140 BUTTON "Entrar" SIZE 55, 11 OF oDlg PIXEL ACTION ValidaLogin(cLogin, cPass)
        @ 030, 140 BUTTON "Sair"   SIZE 55, 11 OF oDlg PIXEL ACTION (nOp := 2, oDlg:End())
        
    ACTIVATE MSDIALOG oDlg CENTERED

Return


Static Function ValidaLogin(cLogin, cPass)

    if cLogin == cUsuario .AND. cPass == cSenha
        FwAlertInfo("Acesso permitido!")
    else
        FwAlertInfo("Usuário ou senha inválido!")
    endif

Return
