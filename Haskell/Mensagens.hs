module Mensagens where
import Util
import Data.List
import System.IO

mensagemInicial :: IO ()
mensagemInicial = do
    arq <- openFile "arquivos/mensagem.txt" ReadMode
    conteudo <- hGetContents arq
    putStrLn conteudo
    hClose arq

menuPrincipal :: IO ()
menuPrincipal = do
    putStrLn("       -----MENU PRINCIPAL-----")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Área do Cliente")
    putStrLn("[2] Login como funcionário")
    putStrLn("[3] Login como dono")
    putStrLn("[4] Sair\n")

opcaoInvalida :: IO()
opcaoInvalida = do
     putStrLn("\nError: OPÇÃO INVÁLIDA\n")

mensagemDeSaida :: IO()
mensagemDeSaida = do
    putStrLn("\nHasta La Vista...E volte sempre!")

menuDoCliente :: IO()
menuDoCliente = do
    putStrLn("\n       -----ÁREA DO CLIENTE-----")
    putStrLn("\nOlá, Cliente!")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Listar vagas disponíveis")
    putStrLn("[2] Escolher vaga")
    putStrLn("[3] Recomendação de vaga do Estacionamento")
    putStrLn("[4] Assinar contrato de exclusividade")
    putStrLn("[5] Ocupar vaga para clientes com contrato")
    putStrLn("[6] Voltar ao menu principal\n")

usuarioInvalido :: IO()
usuarioInvalido = do
    putStrLn("\nErro: usuário não cadastrado!")

usuarioCadastrado :: IO()
usuarioCadastrado = do
    putStrLn("\nErro: usuário já cadastrado!")

usuarioVagaOcupada :: IO()
usuarioVagaOcupada = do
    putStrLn("\nErro: usuário já está ocupando uma vaga!")

cpfInvalido :: IO()
cpfInvalido = do
    putStrLn("\nErro: CPF inválido!")

menuFuncionario :: IO()
menuFuncionario = do
    putStrLn("\n       -----FUNCIONÁRIO-----")
    putStrLn("\nOlá, funcionário!")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Cadastrar cliente")
    putStrLn("[2] Exibir lista das vagas disponíveis")
    putStrLn("[3] Exibir clientes cadastrados")
    putStrLn("[4] Excluir cliente do sistema")
    putStrLn("[5] Calcular valor do estacionamento")
    putStrLn("[6] Voltar ao menu principal\n")

cadastrarNome :: IO()
cadastrarNome = do
    putStrLn("\n       -----CADASTRO DE USUÁRIO-----")
    putStr("\nInforme o nome: ")

informeCpf :: IO()
informeCpf = do
    putStr("Informe o CPF: ")

cadastrarPlaca :: IO()
cadastrarPlaca = do
    putStr("Informe a placa do veículo: ")

cadastraHorarioEntrada :: IO()
cadastraHorarioEntrada = do
    putStr("Por fim, o horário de entrada(números): ")

horaDeSaida :: IO()
horaDeSaida = do
    putStr("Hora de saída: ")

exibirListaVagas :: IO()
exibirListaVagas = do
    putStrLn("       -----VAGAS DISPONÍVEIS-----\n")
    ---arq <- openFile "arquivos/vagas.txt" ReadMode
    ---conteudo <- hGetContents arq
    ---putStrLn conteudo
    ---hClose arq

    --arq <- readFile "arquivos/vagas.txt"
    --let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))
    --print lista


exibirListaClientesCadastrados :: IO()
exibirListaClientesCadastrados = do
    putStrLn("       -----CLIENTES CADASTRADOS-----\n")
    ---arq <- readFile "arquivos/clientes.txt"
    ---let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))
    ---print lista

    arq <- openFile "arquivos/clientes.txt" ReadMode
    conteudo <- hGetContents arq
    putStrLn conteudo
    hClose arq

menuDono :: IO()
menuDono = do
    putStrLn("\n       -----DONO-----")
    putStrLn("\nOi, chefinho!")

    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Cadastrar funcionário")
    putStrLn("[2] Excluir funcionários")
    putStrLn("[3] Gerenciar finanças")
    putStrLn("[4] Visualizar funcionários ativos")
    putStrLn("[5] Visualizar clientes ativos")
    putStrLn("[6] Voltar ao menu principal\n")


exibirListaFuncionariosCadastrados :: IO()
exibirListaFuncionariosCadastrados = do
    putStrLn("       -----FUNCIONARIOS CADASTRADOS-----\n")
    ---arq <- readFile "arquivos/funcionarios.txt"
    ---let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))
    ---print lista

    arq <- openFile "arquivos/funcionarios.txt" ReadMode
    conteudo <- hGetContents arq
    putStrLn conteudo
    hClose arq

ehFuncionario :: IO()
ehFuncionario = do
    putStr("\nInforme seu CPF para fazer o login: ")

valorPago :: String -> [[String]] -> IO()
valorPago cpf lista2 = do

    putStr("O valor a ser pago em REAIS pelo cliente " ++ Util.getNome cpf lista2 ++ " é: ")

cadastradoEfetuado :: IO()
cadastradoEfetuado = do
    putStr("\nCADASTRADO EFETUADO COM SUCESSO!")