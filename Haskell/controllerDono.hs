module ControllerDono where
import Util
import Mensagens
import Estacionamento
import Cliente
import Data.List

verificaDono :: IO()
verificaDono = do
    Mensagens.ehFuncionario
    cpf <- Util.lerEntradaString
     
    arq <- readFile "arquivos/dono.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if (Util.ehCadastrado cpf lista)
        then do loginDono
    else do
        {Mensagens.usuarioInvalido; verificaDono}

loginDono :: IO()
loginDono = do
    Mensagens.menuDono
    op <- Util.lerEntradaString

    if op == "1"
        then do cadastrarFuncionario
    else if op == "4"
        then do {Mensagens.exibirListaFuncionariosCadastrados; loginDono} 
    else if op == "5"
        then do {Mensagens.exibirListaClientesCadastrados; loginDono}
    else if op == "6"
        then do {Mensagens.mensagemDeSaida; return()}
    else do
        {Mensagens.opcaoInvalida; return()}

cadastrarFuncionario :: IO()
cadastrarFuncionario = do
    Mensagens.cadastrarNome
    nome <- Util.lerEntradaString

    Mensagens.informeCpf
    cpf <- Util.lerEntradaString

    arq <- readFile "arquivos/funcionarios.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if not (Util.ehCpfValido cpf)
        then do {Mensagens.cpfInvalido; return()}
    else if (Util.ehCadastrado cpf lista)
       then do {Mensagens.usuarioCadastrado; cadastrarFuncionario}
    else do
        let funcionarioStr = cpf ++ "," ++ nome ++ "\n"
        appendFile "arquivos/funcionarios.txt" (funcionarioStr)   
        loginDono