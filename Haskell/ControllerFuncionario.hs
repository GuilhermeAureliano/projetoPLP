module ControllerFuncionario where
import Util
import Mensagens
import Estacionamento
import Cliente
import Data.List

verificaFuncioanrio :: IO()
verificaFuncioanrio = do
    Mensagens.ehFuncionario
    cpf <- Util.lerEntradaString
     
    arq <- readFile "arquivos/funcionarios.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if (Util.ehCadastrado cpf lista)
        then do {putStr("\nBem vindo de volta!\n"); loginFuncionario}
    else do
        return ()

loginFuncionario :: IO()
loginFuncionario = do
    Mensagens.menuFuncionario
    op <- Util.lerEntradaString
    if op == "1"
        then do cadastrarCliente
    else if op == "2"
        then do {Mensagens.exibirListaVagas; loginFuncionario}
    else if op == "3"
        then do {Mensagens.exibirListaClientesCadastrados; loginFuncionario}
    else if op == "5"
        then do return()
    else if op == "6"
        then do return()
    else do
        {Mensagens.opcaoInvalida; loginFuncionario}

cadastrarCliente :: IO()
cadastrarCliente = do
    Mensagens.cadastrarNome
    nome <- Util.lerEntradaString
    Mensagens.cadastrarCpf
    cpf <- Util.lerEntradaString

    if not (Util.ehCpfValido cpf)
        then do {Mensagens.cpfInvalido; cadastrarCliente}
    else do
        Mensagens.cadastrarPlaca
        placa <- Util.lerEntradaString
        let clienteStr = cpf ++ "," ++ nome ++ "," ++ placa ++ "," ++ " " ++ "\n"
        appendFile "arquivos/clientes.txt" (clienteStr)

        Mensagens.cadastraHorario
        horario <- Util.lerEntradaString
        let horaCpf = cpf ++ "," ++ horario ++ "\n"
        appendFile "arquivos/horario-cpf.txt" (horaCpf)
        
        loginFuncionario
