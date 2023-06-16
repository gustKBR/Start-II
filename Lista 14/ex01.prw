#INCLUDE "TOTVS.CH"
#INCLUDE "TBICONN.CH"


User Function EX1_L14()
    
    Local aDados        := {}
    Local nOper         := 3  
    Private lMsErroAuto := .F.
    
    RpcSetEnv("99","01")
    
    aAdd(aDados, {"A1_FILIAL" , xFilial("SA1")   , NIL})  
    aAdd(aDados, {"A1_COD"    , "001"            , NIL})  
    aAdd(aDados, {"A1_LOJA"   , "01"             , NIL})  
    aAdd(aDados, {"A1_NOME"   , "Gustavo Cabral" , NIL})  
    aAdd(aDados, {"A1_NREDUZ" , "Cabral"         , NIL})  
    aAdd(aDados, {"A1_TIPO"   , "F"              , NIL})  
    aAdd(aDados, {"A1_END"    , "Rua Protheus"   , NIL})  
    aAdd(aDados, {"A1_EST"    , "SP"             , NIL})  
    aAdd(aDados, {"A1_MUN"    , "SUMARÉ"         , NIL})  
    
    MsExecAuto({|x, y| CRMA980(x, y)}, aDados, nOper)
    
    if lMsErroAuto
        MostraErro()
    endif

Return
