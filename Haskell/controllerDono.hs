module ControllerDono where
import Util
import Mensagens
import Data.List
import System.IO

verificaDono :: (IO()) -> IO()
verificaDono menu = do
    Mensagens.ehFuncionario
    cpf <- Util.lerEntradaString
     
    arq <- readFile "arquivos/dono.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if (Util.ehCadastrado cpf lista)
        then do loginDono menu
    else do
        {Mensagens.usuarioInvalido; menu}

loginDono :: (IO()) -> IO()
loginDono menu = do
    Mensagens.menuDono
    op <- Util.lerEntradaString

    if op == "1"
        then do cadastrarFuncionario menu
    else if op == "2"
        then do {excluirFuncionario menu; loginDono menu}
    else if op == "3"
        then do {gerenciarFinancas; loginDono menu}
    else if op == "4"
        then do {Mensagens.exibirListaFuncionariosCadastrados; loginDono menu} 
    else if op == "5"
        then do {Mensagens.exibirListaClientesCadastrados; loginDono menu}
    else if op == "6"
        then do menu
    else do
        {Mensagens.opcaoInvalida; loginDono menu}

gerenciarFinancas :: IO()
gerenciarFinancas = do
    Mensagens.menuFinancas
    op <- Util.lerEntradaString

    if op == "1"
        then do exibirContratosAtivos
    else if op == "2"
        then do alterarValor
    else if op == "3"
        then do return()
    else do
        Mensagens.opcaoInvalida

alterarValor :: IO()
alterarValor = do
    putStr("\nQual o novo valor do estacionamento? ")
    newValue <- Util.lerEntradaString

    arq <- openFile "arquivos/valorEstacionamento.txt" WriteMode
    hPutStr arq newValue
    hFlush arq
    hClose arq

    putStr("\nValor do estacionamento alterado com sucesso!\n")


getLinesFuncionarios :: Handle -> IO [String]
getLinesFuncionarios h = hGetContents h >>= return . lines

excluirFuncionario :: (IO()) -> IO()
excluirFuncionario menu = do

    arq <- openFile "arquivos/funcionarios.txt" ReadMode
    xs <- getLinesFuncionarios arq
    let lista = ((Data.List.map (wordsWhen(==',') ) (xs)))
    putStr("\nAtualmente temos os seguintes funcionários no sistema: ")
    print (lista)

    putStr("\nInforme o CPF do funcionário que deseja excluir: ")
    cpf <- Util.lerEntradaString

    if not (Util.ehCadastrado cpf lista)
        then do Mensagens.usuarioInvalido
    else do
        let funcionarios = Util.primeiraHorarioCpf (Util.opcaoVaga cpf lista)
        Util.escreveFuncionario ""

        appendFile "arquivos/funcionarios.txt" (funcionarios)

        putStr("\nFuncionário excluído com sucesso!\n")

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