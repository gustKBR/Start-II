#INCLUDE "TOTVS.CH"


User Function Login2()

    Local cTitle        := "Login"
    Local cTexto        := "Crie um username com mais de 5 caracteres:  "
    Local cTexto2       := "Crie uma senha com pelo menos 6 caracteres: "
    Local cTexto3       := "Digite a senha novamente: "
    Local nOp           := 0
    Local cLogin        := Space(10)
    Local cPass         := Space(10)
    Local cConfirma     := Space(10)
    Local oDlg          := NIL

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO 200, 550 PIXEL
    
        @ 014, 010 SAY    cTexto        SIZE 120, 12 OF oDlg PIXEL
        @ 034, 010 SAY    cTexto2       SIZE 120, 12 OF oDlg PIXEL
        @ 054, 010 SAY    cTexto3       SIZE 120, 12 OF oDlg PIXEL
        @ 010, 130 MSGET  cLogin        SIZE 55, 11 OF oDlg PIXEL
        @ 030, 130 MSGET  cPass         SIZE 55, 11 OF oDlg PIXEL PASSWORD
        @ 050, 130 MSGET  cConfirma     SIZE 55, 11 OF oDlg PIXEL PASSWORD
        @ 010, 200 BUTTON "Cadastrar"   SIZE 55, 11 OF oDlg PIXEL ACTION ValidaLogin(cLogin, cPass, cConfirma)
        @ 030, 200 BUTTON "Cancelar"    SIZE 55, 11 OF oDlg PIXEL ACTION (nOp := 2, oDlg:End())
    
    ACTIVATE MSDIALOG oDlg CENTERED

Return


Static Function ValidaLogin(cLogin, cPass, cConfirma)

    Local cSenha    := ""
    Local lValido   := .F.
    Local nCont     := 0
    Local nAux      := 0
    Local nUsuario  := 0

    cLogin    := RTRIM(cLogin)
    cPass     := RTRIM(cPass)
    cConfirma := RTRIM(cConfirma)


    if cLogin == ""
        FwAlertInfo("Campo do usu�rio est� em branco!") 
    elseif LEN(cLogin) <= 5
        FwAlertInfo("Usu�rio inv�lido (deve conter mais de 5 caracteres).")
    else
        FwAlertInfo("O username " + cLogin + " est� nos padr�es!")
        nUsuario++
    endif

    if cConfirma == "" .OR. cPass == ""
        FwAlertInfo("Campo da senha est� em branco!") 
    elseif len(cPass) < 6 
        FwAlertInfo("Usu�rio inv�lido (deve conter pelo menos 6 caracteres).")
    elseif cConfirma != cPass
        FwAlertInfo("A senha de confirma��o deve ser a mesma!") 
    else
        for nCont := 1 to len(cPass)
            if lValido == .F. .AND. (asc(SubStr(cPass, nCont)) >= 65 .AND. asc(SubStr(cPass, nCont)) <= 90)
                cSenha += "Cont�m letra mai�scula!" + CRLF
                nAux++
                lValido := .T.
            endif
        next

        lValido := .F.

        for nCont:= 1 to len(cPass)
            if lValido  == .F. .AND. (asc(SubStr(cPass, nCont)) >= 33 .AND. asc(SubStr(cPass, nCont)) <= 47) .OR. (asc(SubStr(cPass, nCont)) >= 58 .AND. asc(SubStr(cPass, nCont)) <= 64) .OR. (asc(SubStr(cPass, nCont)) >= 91 .AND. asc(SubStr(cPass, nCont)) <= 96) .OR. (asc(SubStr(cPass, nCont)) >= 123 .AND. asc(SubStr(cPass, nCont)) <= 126)
                cSenha += "Cont�m s�mbolo!" + CRLF
                nAux++
                lValido := .T.
            endif
        next

        lValido := .F.

        for nCont:= 1 to len(cPass)
            if lValido == .F. .AND. (asc(SubStr(cPass, nCont)) >= 48 .AND. asc(SubStr(cPass, nCont)) <= 57)
                cSenha += "Cont�m valor num�rico!" + CRLF
                nAux++
                lValido := .T.
            endif
        next

        if nAux == 3
            FwAlertSuccess(cSenha + CRLF + "A senha atende os requisitos!")
        else
            FwAlertInfo("A senha n�o atende aos requisitos. A senha deve conter ao menos uma letra mai�scula, um d�gito num�rico e um s�mbolo!", "Senha inv�lida")
        endif
    endif

    if cConfirma == cPass .AND. nAux == 3 .AND. nUsuario == 1
        FwAlertSuccess("Usu�rio cadastrado com sucesso! " + CRLF + "Username: " + cLogin, "Sucesso") 
    endif

Return
