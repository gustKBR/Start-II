#INCLUDE "TOTVS.CH"
#INCLUDE "TBICONN.CH"


User Function EX3_L14()

    Local aDados        := {}
    Local nOper         := 5  
    Private lMsErroAuto := .F.

    RpcSetEnv("99","01")

    aAdd(aDados, {"A2_COD"    , "003"      , NIL}) 
    aAdd(aDados, {"A2_NOME"   , "Gustavo"  , NIL})

    MsExecAuto({|x, y| MATA020(x, y)}, aDados, nOper)

    if lMsErroAuto
        MostraErro()
    endif

Return
