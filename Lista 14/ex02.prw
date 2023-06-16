#INCLUDE "TOTVS.CH"
#INCLUDE "TBICONN.CH"


User Function EX2_L14()

    Local aDados        := {}
    Local nOper         := 4
    Private lMsErroAuto := .F.

    RpcSetEnv("99","01")
    
    aAdd(aDados, {"A1_COD"  , "002"        , NIL}) 
    aAdd(aDados, {"A1_END"  , "Rua TOTVS"  , NIL})
    aAdd(aDados, {"A1_DDD"  , "19"         , NIL})  
    aAdd(aDados, {"A1_TEL"  , "123456789"  , NIL})

    MsExecAuto({|x, y| CRMA980(x, y)}, aDados, nOper)
    
    if lMsErroAuto
        MostraErro()
    endif

Return
