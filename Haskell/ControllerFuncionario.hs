module ControllerFuncionario where
import Util
import Mensagens
import Estacionamento
import Cliente
import Data.List
import System.IO

verificaFuncionario :: (IO()) -> IO()
verificaFuncionario menu = do
    Mensagens.ehFuncionario
    cpf <- Util.lerEntradaString
     
    arq <- readFile "arquivos/funcionarios.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if (Util.ehCadastrado cpf lista)
        then do {putStr("\nBem vindo de volta!\n"); loginFuncionario menu}
    else do
        {Mensagens.usuarioInvalido; verificaFuncionario menu}

loginFuncionario :: (IO()) -> IO()
loginFuncionario menu = do
    Mensagens.menuFuncionario

    putStr("Opção: ")
    op <- Util.lerEntradaString
    if op == "1"
        then do cadastrarCliente menu
    else if op == "2"
        then do {Mensagens.exibirListaVagas; Util.reescreveVagas; loginFuncionario menu}
    else if op == "3"
        then do {Mensagens.exibirListaClientesCadastrados; loginFuncionario menu}
    else if op == "5"
        then do calcularValorEstacionamento menu
    else if op == "6"
        then do menu
    else do
        {Mensagens.opcaoInvalida; loginFuncionario menu}

calcularValorEstacionamento :: (IO()) -> IO()
calcularValorEstacionamento menu = do
    Mensagens.informeCpf
    cpf <- Util.lerEntradaString

    arq <- readFile "arquivos/clientes.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if (Util.ehCadastrado cpf lista)
        then do {horaDeSaidaCalculo cpf; reescreverVaga cpf; loginFuncionario menu}
    else do
        {Mensagens.usuarioInvalido; loginFuncionario menu}

reescreverVaga :: String -> IO()
reescreverVaga cpf = do

    arq <- readFile "arquivos/cpv.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))
    putStr("")

horaDeSaidaCalculo :: String -> IO()
horaDeSaidaCalculo cpf = do
    arq <- readFile "arquivos/horario-cpf.txt"
    let lista = ((Data.List.map (wordsWhen(==',') ) (lines arq)))

    if (lista == [])
        then do Mensagens.usuarioInvalido
    else do
        Mensagens.horaDeSaida
        horaDeSaida <- Util.lerEntradaString
        let getVaga = Util.getIndiceCpv(Util.getVagaCpv cpf lista) ++ "," ++ "\n"
        appendFile "arquivos/vagas.txt" (getVaga)
        Util.escreverCpv (primeiraCpv (Util.opcaoVaga cpf lista))

        Util.escreverHorarioCpf (primeiraCpv (Util.opcaoVaga cpf lista))

        arqClientes <- readFile "arquivos/clientes.txt"
        let lista2 = ((Data.List.map (wordsWhen(==',') ) (lines arqClientes)))

        Mensagens.valorPago cpf lista2
        print(valorFinalEst horaDeSaida (dizHoraInt (horaCpf cpf lista)))
        putStr("")

horaCpf :: String -> [[String]] -> [[String]]
horaCpf _ [] = []
horaCpf v (x:xs) | (auxHoraCpf v x) == False = horaCpf v xs
                   | otherwise = x:horaCpf v xs

auxHoraCpf :: String -> [String] -> Bool
auxHoraCpf v (x:xs) = (v == x)

dizHoraInt:: [[String]] -> Int
dizHoraInt lista = read (lista !! 0 !! 3) :: Int

toInt :: String -> Int
toInt s = read (s) :: Int

valorFinalEst :: String -> Int -> Int
valorFinalEst saida entrada =  ((toInt saida) - entrada) * 5


cadastrarCliente :: (IO()) -> IO()
cadastrarCliente menu = do
    Mensagens.cadastrarNome
    nome <- Util.lerEntradaString
    Mensagens.informeCpf
    cpf <- Util.lerEntradaString

    arq <- readFile "arquivos/clientes.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if not (Util.ehCpfValido cpf)
        then do {Mensagens.cpfInvalido; cadastrarCliente menu}
    else if (Util.ehCadastrado cpf lista)
        then do {Mensagens.usuarioCadastrado; cadastrarCliente menu}
    else do
        Mensagens.cadastrarPlaca
        placa <- Util.lerEntradaString
        let clienteStr = cpf ++ "," ++ nome ++ "," ++ placa ++ "\n"
        appendFile "arquivos/clientes.txt" (clienteStr)

        Mensagens.cadastraHorarioEntrada
        horario <- Util.lerEntradaString
        let horaCpf = cpf ++ "," ++ horario ++ "\n"
        appendFile "arquivos/horario-cpf.txt" (horaCpf)
        
        loginFuncionario menu
