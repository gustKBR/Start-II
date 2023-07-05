#INCLUDE "TOTVS.CH"


User Function EX17_L5()

    Local aArray        := ACLONE(PopArray(8))
    Local nOp           := 0
    Local nAltJan       := 450
    Local nLargJan      := 500
    Local oDlg          := NIL

    while nOp <> 12

        DEFINE MSDIALOG oDlg TITLE "Jogo Array"   FROM 000,000 TO nAltJan,nLargJan PIXEL

            @ 010,020 BUTTON "Popular aleatoriamente"   SIZE 120,020 OF oDlg ACTION (nOp := 1,aArray := ACLONE(PopArray(8)))    PIXEL
            @ 025,020 BUTTON "Popular manualmente"      SIZE 120,020 OF oDlg ACTION (nOp := 2,aArray := ACLONE(DigitArray()))   PIXEL
            @ 040,020 BUTTON "Exibir conteúdo array"    SIZE 120,020 OF oDlg ACTION (nOp := 3,ExibArray(aArray))                PIXEL
            @ 055,020 BUTTON "Ordem crescente"          SIZE 120,020 OF oDlg ACTION (nOp := 4,Crescent(aArray))                 PIXEL
            @ 070,020 BUTTON "Ordem decrescente"        SIZE 120,020 OF oDlg ACTION (nOp := 5,Decresce(aArray))                 PIXEL
            @ 085,020 BUTTON "Pesquisar valor"          SIZE 120,020 OF oDlg ACTION (nOp := 6,PesqArray(aArray))                PIXEL
            @ 100,020 BUTTON "Somatório"                SIZE 120,020 OF oDlg ACTION (nOp := 7,SomaArray(aArray))                PIXEL
            @ 115,020 BUTTON "Média"                    SIZE 120,020 OF oDlg ACTION (nOp := 8,Media(aArray))                    PIXEL
            @ 130,020 BUTTON "Maior e Menor"            SIZE 120,020 OF oDlg ACTION (nOp := 9,MaiorMenor(aArray))               PIXEL
            @ 145,020 BUTTON "Embaralhar"               SIZE 120,020 OF oDlg ACTION (nOp := 10,Embaralh(aArray))               PIXEL
            @ 160,020 BUTTON "Valores Repetidos"        SIZE 120,020 OF oDlg ACTION (nOp := 11,Repete(aArray))                  PIXEL

            @ 185,020 BUTTON "Cancelar" SIZE 150,020 OF oDlg ACTION (nOp := 12,oDlg:END()) PIXEL

        ACTIVATE MSDIALOG oDlg CENTERED

    enddo

Return 


Static Function PopArray(nTam)

    Local nCont := 0
    Local aArray[nTam]

    for nCont := 1 TO nTam
        aArray[nCont] := RANDOMIZE(1, 100)
    next

Return aArray


Static Function DigitArray()

    Local nCont  := 1
    Local aArray[8]

    for nCont := 1 to 8
        aArray[nCont] := VAL(FwInputBox("Digite um valor: "))
    next

Return aArray


Static Function ExibArray(aArray)

    Local cMsg  := ""
    Local nCont := 0

    for nCont := 1 to len(aArray)
        if nCont < len(aArray)
            cMsg += cValToChar(aArray[nCont])  + ", "
        else
            cMsg += cValToChar(aArray[nCont])
        endif
    next

    FwAlertSuccess("Conteúdo do Array: " + CRLF + cMsg, "Exibir Array")

Return


Static Function Crescent(aArray)

    Local nI        := 0
    Local nJ        := 0
    Local nAux      := 0

    for nJ := 1 to len(aArray)-1 
        for nI := 1 to len(aArray)-1
            if aArray[nI] > aArray[nI+1]
                nAux        := aArray[nI]
                aArray[nI]   := aArray[nI+1]
                aArray[nI+1] := nAux
            endif
        next
    next 
    
    FwAlertSuccess("O vetor foi ordenado em ordem crescente!", "Ordem Crescente")

Return aArray


Static Function Decresce(aArray)

    Local nI        := 0
    Local nJ        := 0
    Local nAux      := 0

    for nJ := 1 to len(aArray)-1 
        for nI := 1 to len(aArray)-1
            if aArray[nI] < aArray[nI+1]
                nAux        := aArray[nI]
                aArray[nI]   := aArray[nI+1]
                aArray[nI+1] := nAux
            endif
        next
    next 

    FwAlertSuccess("O vetor foi ordenado em ordem decrescente!", "Ordem Derescente")
    
Return aArray


Static Function PesqArray(aArray)

    Local nValor    := Val(FWInputBox("Digite o valor que deseja buscar: "))
    Local nCont     := 0
    Local lPesq     := .F.
    Local lVazio    := .T.
    Local aArray    := {}
    Local cMsg      := ""

    if len(aArray) == 0
        lVazio := .T.
    endif

    for nCont := 1 to len(aArray)
        if nValor == aArray[nCont]
            lPesq := .T.
            AADD(aArray, nCont)
        endif 

        if aArray[nCont] <> 0 .OR. aArray[nCont] <> NIL
            lVazio := .F.
        endif
    next

    if lPesq
        if len(aArray) > 1
            cMsg += "O número digitado foi encontrado nas posições "

            for nCont := 1 to len(aArray)
                if nCont < len(aArray)
                    cMsg += cValToChar(aArray[nCont]) + ", "
                else
                    cMsg += cValToChar(aArray[nCont])
                endif
            next
        else
            cMsg += "O número digitado foi encontrado na posição " + cValToChar(aArray[1])
        endif
    else
        If lVazio
            cMsg := "Array vazio!"
        else
            cMsg := "O número digitado não foi encontrado na pesquisa!"
        endif
    endif

    FwAlertInfo(cMsg, "Pesquisa no Array")

Return


Static Function SomaArray(aArray)

    Local nSoma := 0
    Local nCont := 0

    for nCont := 1 to len(aArray)
        nSoma += aArray[nCont]
    next

    FwAlertInfo("Total da soma: " + cValToChar(nSoma), "Somatória Array")

Return 


Static Function Media(aArray)

    Local nSoma  := 0
    Local nMedia := 0
    Local nCont  := 0

    for nCont := 1 to len(aArray)
        nSoma += aArray[nCont]
    next
    
    nMedia := nSoma / len(aArray)

    FwAlertInfo("Média dos valores do array: " + cValToChar(nMedia), "Média Array")

Return


Static Function MaiorMenor(aArray)

    Local nMaior := aArray[1]
    Local nMenor := aArray[1]
    Local nCont  := 0

    for nCont := 1 to len(aArray)
        if aArray[nCont] > nMaior
            nMaior := aArray[nCont]
        endif

        if aArray[nCont] < nMenor
            nMenor := aArray[nCont]
        endif
    next

    FwAlertInfo("O maior número do array é: " + cValToChar(nMaior) + CRLF +;
                "O menor número do array é: " + cValToChar(nMenor), "Maior e Menor")

Return


Static Function Embaralh(aArray)

    Local nRepete       := 0
    Local nRandom       := 0
    Local nCont         := 0
    Local nAux          := 0

    for nRepete := 1 to 80
        for nCont := 1 to len(aArray)
            nRandom := RANDOMIZE(1, len(aArray))
            nAux                := aArray[nCont]
            aArray[nCont]       := aArray[nRandom]
            aArray[nRandom]     := nAux
        next
    next

    FwAlertSuccess("O vetor foi embaralhado!", "Embaralha Array")

Return


Static Function Repete(aArray)

    Local nRepete       := 0
    Local aRepete       := {}
    Local aQtdRep       := {}
    Local nI            := 0
    Local nJ            := 0
    Local cMsg          := ""

    for nI := 1 to len(aArray)
        nRepete := 1

        for nJ := 1 to nI-1
            if aArray[nI] == aArray[nJ]
                nRepete++
            endif
        next
        
        if nRepete > 1
            AADD(aRepete, aArray[nI])
            AADD(aQtdRep, nRepete)
        endif 
    next

    for nI := 1 to len(aRepete)
        for nJ := 1 to nI-1
            if aRepete[nJ] == aRepete[nI]
                ADEL(aRepete,nJ)
                ADEL(aQtdRep,nJ)
            endif
        next
    next
    
    for nI := 1 to len(aRepete)
        if aRepete[nI] > 0
            cMsg += cValToChar(aRepete[nI]) + ": " + cValToChar(aQtdRep[nI]) + CRLF
        endif
    next

    FwAlertInfo("Os números que se repetiram foram: " + cMsg, "Números repetidos")

Return
