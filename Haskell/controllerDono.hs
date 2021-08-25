module ControllerDono where
import Util
import Mensagens
import Estacionamento
import Cliente
import Data.List

verificaDono :: (IO()) -> IO()
verificaDono menu = do
    Mensagens.ehFuncionario
    cpf <- Util.lerEntradaString
     
    arq <- readFile "arquivos/dono.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if (Util.ehCadastrado cpf lista)
        then do loginDono menu
    else do
        {Mensagens.usuarioInvalido; verificaDono menu}

loginDono :: (IO()) -> IO()
loginDono menu = do
    Mensagens.menuDono
    op <- Util.lerEntradaString

    if op == "1"
        then do cadastrarFuncionario menu
    else if op == "4"
        then do {Mensagens.exibirListaFuncionariosCadastrados; loginDono menu} 
    else if op == "5"
        then do {Mensagens.exibirListaClientesCadastrados; loginDono menu}
    else if op == "6"
        then do menu
    else do
        {Mensagens.opcaoInvalida; loginDono menu}

cadastrarFuncionario :: (IO()) -> IO()
cadastrarFuncionario menu = do
    Mensagens.cadastrarNome
    nome <- Util.lerEntradaString

    Mensagens.informeCpf
    cpf <- Util.lerEntradaString

    arq <- readFile "arquivos/funcionarios.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if not (Util.ehCpfValido cpf)
        then do {Mensagens.cpfInvalido; loginDono menu}
    else if (Util.ehCadastrado cpf lista)
       then do {Mensagens.usuarioCadastrado; cadastrarFuncionario menu}
    else do
        let funcionarioStr = cpf ++ "," ++ nome ++ "\n"
        appendFile "arquivos/funcionarios.txt" (funcionarioStr)   
        loginDono menu