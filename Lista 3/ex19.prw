#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

User Function EX19_L3()

    Local cFrase    := ""
    Local nEspacos  := 0
    Local nA        := 0
    Local nE        := 0
    Local nI        := 0
    Local nO        := 0
    Local nU        := 0
    Local nCont     := 0
    
    cFrase := FwInputBox("Digite uma frase")

    for nCont := 1 to len(cFrase)

        if UPPER(SUBSTR(cFrase, nCont, 1)) == "A"
            nA++
        elseif UPPER(SUBSTR(cFrase, nCont, 1)) == "E"
            nE++
        elseif UPPER(SUBSTR(cFrase, nCont, 1)) == "I"
            nI++
        elseif UPPER(SUBSTR(cFrase, nCont, 1)) == "O"
            nO++
        elseif UPPER(SUBSTR(cFrase, nCont, 1)) == "U"
            nU++
        elseif UPPER(SUBSTR(cFrase, nCont, 1)) == " "
            nEspacos++
        endif

    next nCont

    FwAlertInfo("Frase digitada: " + cFrase + CRLF + CRLF + ;
    "Quantidade de espaços em branco: " + cValToChar(nEspacos) + CRLF + ;
    "A vogal A apareceu " + cValToChar(nA) + " vez(es)" + CRLF + ;
    "A vogal E apareceu " + cValToChar(nE) + " vez(es)" + CRLF + ;
    "A vogal I apareceu " + cValToChar(nI) + " vez(es)" + CRLF + ;
    "A vogal O apareceu " + cValToChar(nO) + " vez(es)" + CRLF + ;
    "A vogal U apareceu " + cValToChar(nU) + " vez(es)")

Return
