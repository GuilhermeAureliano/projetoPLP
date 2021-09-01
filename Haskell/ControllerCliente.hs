module ControllerCliente where
import Util
import Mensagens
import Data.List
import System.IO

loginCliente :: (IO()) -> IO()
loginCliente menu = do
    Mensagens.menuDoCliente

    putStr("Opção: ")
    opcao <- Util.lerEntradaString

    opcoesCliente menu opcao


--- Chama alguma função de acordo com o que foi digitado ---
opcoesCliente :: (IO()) -> String -> IO()
opcoesCliente menu opcao | opcao == "1" = do {Util.reescreveVagas; loginCliente menu}
                        | opcao == "2" = do {vagaOcupadaCliente; loginCliente menu}
                        | opcao == "3" = do {recomendarVaga; loginCliente menu}
                        | opcao == "4" = do {assinarContrato; loginCliente menu}
                        | opcao == "5" = do {clienteComContrato menu; loginCliente menu}
                        | opcao == "6" = menu
                        | otherwise = do {Mensagens.opcaoInvalida; loginCliente menu}


getlines :: Handle -> IO [String]
getlines h = hGetContents h >>= return . lines

--- Escreve no arquivo "usoDoContrato" que o cliente utilizou do seu contrato ---
clienteComContrato :: (IO()) -> IO()
clienteComContrato menu = do
    Mensagens.informeCpf
    cpf <- Util.lerEntradaString

    arq <- openFile "arquivos/usoDoContrato.txt" ReadMode
    xs <- getlines arq
    let lista = ((Data.List.map (wordsWhen(==',') ) (xs)))
    putStr("\nAtualmente temos os seguintes clientes ativos e suas respectivas vagas: ")
    print lista

    let cvc = Util.getVagaCpv cpf lista

    if not (Util.ehCadastrado cpf lista)
        then do 
            putStr("\nO senhor não tem contrato ativo!\n")
    else do
        if ((cvc !! 0 !! 2) == "s" && (cvc !! 0 !! 1) == "7") 
            then do renovacaoDeContrato cpf lista

        else if ((cvc !! 0 !! 2) == "m" && (cvc !! 0 !! 1) == "30")
            then do renovacaoDeContrato cpf lista

        else do
            putStr("\nBem-vindo de volta! O senhor estará usando seu contrato!\n")

            let var = (Util.primeiraCliente (Util.contrato cpf lista))
            Util.escreverUsoDoContrato ""
            putStr("")

            appendFile "arquivos/usoDoContrato.txt" (var)
            putStr("")

--- Zera a quantidade de vezes que o cliente usou o estacionamento, serve como uma renovação de contrato ----
renovacaoDeContrato :: String -> [[String]] -> IO()
renovacaoDeContrato cpf lista = do
    putStr("\nContrato do senhor acabou!")
    putStr("\nO senhor deseja renovar o contrato? [S/N] ")
    renova <- Util.lerEntradaString

    if (renova == "s")
        then do
            let var2 = (Util.primeiraCliente (Util.renovarContrato cpf lista))
            Util.escreverUsoDoContrato ""
            appendFile "arquivos/usoDoContrato.txt" (var2)
            putStr("\nContrato renovado com sucesso!\n")
    else do

        let var2 = (Util.primeiraCliente (Util.opcaoVaga cpf lista))
        Util.escreverUsoDoContrato ""
        appendFile "arquivos/usoDoContrato.txt" (var2)

        arqCont <- readFile "arquivos/contratos.txt"
        let lista2 = ((Data.List.map (wordsWhen(==',') ) (lines arqCont)))
        putStr("\nExcluindo cliente que tem o CPF " ++ cpf ++ " do sistema...")
        print (lista2)
        let var3 = (Util.primeiraCpv (Util.opcaoVaga cpf lista2))
        Util.escreverContratos ""
        appendFile "arquivos/contratos.txt" (var3)
        putStr("\nContrato não renovado! :( \n")

        let getVaga = Util.getIndiceContratos (Util.getVagaCpv cpf lista2) ++ "," ++ "\n"
        appendFile "arquivos/vagas.txt" (getVaga)

--- Assina contrato de exclusividade no estacionamento ---
assinarContrato :: IO()
assinarContrato = do
    Mensagens.informeCpf
    cpf <- Util.lerEntradaString
    arq2 <- readFile "arquivos/vagas.txt"
    let lista2 = ((Data.List.map (wordsWhen(==',') ) (lines arq2)))

    arq <- readFile "arquivos/usoDoContrato.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))


    if (Util.ehCadastrado cpf lista)
        then do putStr("\nVocê já tem contrato ativo! Tecle 5 na área do cliente para usar seu contrato!\n")
    else do

        putStr("Informe o nome: ")
        nome <- Util.lerEntradaString

        Mensagens.cadastrarPlaca
        placa <- Util.lerEntradaString

        putStrLn("       -----VAGAS DISPONÍVEIS-----\n")

        print lista2
        putStr("Qual vaga você deseja? ")
        vaga <- Util.lerEntradaString

        let cpfUltimaVaga = cpf ++ "," ++ vaga ++ "\n"
        appendFile "arquivos/recomendarVaga.txt" (cpfUltimaVaga)

        putStr("Qual o tipo de contrato? \n")
        putStr("O nosso mensal custa 150$ reais.\n")
        putStr("Já o nosso contrato semanal custa 25$ reais.\n")
        putStr("\nQual o senhor irá assinar? [S/M] ")
        contrato <- Util.lerEntradaString

        if contrato == "s"
            then do
                let clienteStr = cpf ++ "," ++ nome ++ "," ++ placa ++ "," ++ vaga ++ "," ++ "25" ++ "\n"
                appendFile "arquivos/contratos.txt" (clienteStr)
        else do
            let clienteStr = cpf ++ "," ++ nome ++ "," ++ placa ++ "," ++ vaga ++ "," ++ "150" ++ "\n"
            appendFile "arquivos/contratos.txt" (clienteStr)

        let usoCont = cpf ++ "," ++ "0" ++ "," ++ contrato ++ "\n"
        appendFile "arquivos/usoDoContrato.txt" (usoCont)
        escreveVaga (primeira (opcaoVaga (vaga) lista2))
        putStr("")

--- Escolhe uma vaga das disponíveis ---
vagaOcupadaCliente :: IO()
vagaOcupadaCliente = do
    putStr("\nPara continuar vai ser preciso efetuar um cadastro no sistema!\n")
    Mensagens.informeCpf
    cpf <- Util.lerEntradaString

    arq <- readFile "arquivos/cpv.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    arq2 <- readFile "arquivos/clientes.txt"
    let lista2 = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq2)))

    if (Util.ehCadastrado cpf lista)
        then do Mensagens.usuarioVagaOcupada
    else if (Util.ehCadastrado cpf lista2)
        then do
            putStr("\nVimos que o senhor já é cadastrado! Pode continuar!\n")

            Mensagens.cadastrarPlaca
            putStr("\n")
            placa <- Util.lerEntradaString
            Util.escolheVaga cpf placa
            putStr("")
    else do
        putStr("Informe o nome: ")
        nome <- Util.lerEntradaString

        Mensagens.cadastrarPlaca
        placa <- Util.lerEntradaString

        let clienteStr = cpf ++ "," ++ nome ++ "," ++ placa ++ "\n"
        appendFile "arquivos/clientes.txt" (clienteStr)

        Util.escolheVaga cpf placa
    putStr("")


--- Recomenda uma vaga para o cliente a partir do seu histórico prévio ---
recomendarVaga :: IO()
recomendarVaga = do
    Mensagens.informeCpf
    cpf <- Util.lerEntradaString

    arq <- readFile "arquivos/recomendarVaga.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if (Util.ehCadastrado cpf lista)
        then do
            putStr("Nós recomendamos a você a vaga: ") 
            print ( read (Util.recomendacaoVaga (Util.auxRecomendar cpf (reverse (lista)))) :: Int )

    else do
        putStr("\nO senhor nunca usou esse estacionamento!\n")