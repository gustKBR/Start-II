#INCLUDE "TOTVS.CH"


User Function EX14_L5()

    Local aArray        := {}
    Local cLetra        := 0
    Local nRepet       := 0

    while len(aArray) <= 12
        cLetra := CHR(RANDOMIZE(97, 122))
        nRepet := aScan(aArray, cLetra, 1, len(aArray))

        if nRepet == 0
            AADD(aArray, cLetra)
        endif

    enddo

    ExibeArray(aArray)

Return 


Static Function ExibeArray(aArray)

    Local cMsg := ""
    Local nI   := 0

    for nI := 1 to len(aArray)
        if nI < 12
            cMsg += cValToChar(aArray[nI]) + ", "
        else 
            cMsg += cValToChar(aArray[nI]) + "."
        endif
    next nI

    FwAlertSuccess(cMsg, "Conteúdo do Array")
    
Return
