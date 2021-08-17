module Mensagens where
import System.IO
import Util

mensagemInicial :: IO ()
mensagemInicial = do
    arq <- openFile "arquivos/mensagem.txt" ReadMode
    conteudo <- hGetContents arq
    putStrLn conteudo
    hClose arq

menuPrincipal :: IO ()
menuPrincipal = do
    putStrLn("       ----MENU PRINCIPAL----")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Login como cliente")
    putStrLn("[2] Login como funcionário")
    putStrLn("[3] Login como dono")
    putStrLn("[4] Sair\n")

opcaoInvalida :: IO()
opcaoInvalida = do
     putStrLn("\nError: OPÇÃO INVÁLIDA\n")

putMsgTeclaEnter :: IO ()
putMsgTeclaEnter = do
    putStrLn("\nPressione a tecla ENTER para voltar!")
    opcao <- Util.lerEntradaString
    putStr("")

mensagemDeSaida :: IO()
mensagemDeSaida = do
    putStrLn("\nHasta La Vista...E volte sempre!")

loginDoCliente :: IO()
loginDoCliente = do
    putStrLn("       -----LOGIN CLIENTE----\n")
    putStrLn ("\nOBS: Para voltar ao menu basta digitar 'S'!\n")
    putStrLn("Olá, senhor(a)!")

    putStr("Por favor, informe o seu CPF: ")

menuDoCliente :: String -> IO()
menuDoCliente nome = do
    putStrLn("\nOlá, " ++ nome ++ "!")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Listar vagas disponíveis")
    putStrLn("[2] Escolher vaga")
    putStrLn("[3] Recomendação de vaga do Estacionamento")
    putStrLn("[4] Assinar contrato de exclusividade")
    putStrLn("[5] Adicionar serviço extra de lava jato e cera")
    putStrLn("[6] Voltar ao menu principal\n")

usuarioInvalido :: IO()
usuarioInvalido = do
    putStrLn("\nErro: usuário não cadastrado!")
    putMsgTeclaEnter

cpfInvalido :: IO()
cpfInvalido = do
    putStrLn("\nErro: CPF inválido!")
    putMsgTeclaEnter

menuFuncionario :: IO()
menuFuncionario = do
    putStrLn("       -----FUNCIONÁRIO----")
    putStrLn("\nOlá, funcionário!")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Cadastrar cliente")
    putStrLn("[2] Exibir lista das vagas disponíveis")
    putStrLn("[3] Exibir clientes cadastrados")
    putStrLn("[4] Gerenciar clientes")
    putStrLn("[5] Calcular valor do estacionamento")
    putStrLn("[6] Voltar ao menu principal\n")

cadastrarNome :: IO()
cadastrarNome = do
    putStrLn("       -----CADASTRO DE USUÁRIO----")
    putStrLn("Informe seu nome: ")

cadastrarCpf :: IO()
cadastrarCpf = do
    putStrLn("Agora digite seu CPF: ")

cadastrarPlaca :: IO()
cadastrarPlaca = do
    putStrLn("Para concluir o cadastro informe a placa do veículo...")
    putStr("Placa: ")

exibirListaVagas :: IO()
exibirListaVagas = do
    arq <- openFile "arquivos/vagas.txt" ReadMode
    conteudo <- hGetContents arq
    putStrLn conteudo
    hClose arq
    putStr "\n"

exibirListaClientesCadastrados :: IO()
exibirListaClientesCadastrados = do
    arq <- openFile "arquivos/clientes.txt" ReadMode
    conteudo <- hGetContents arq
    putStrLn conteudo
    hClose arq
    putStr "\n"