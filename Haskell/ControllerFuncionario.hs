module ControllerFuncionario where
import Util
import Mensagens
import Estacionamento
import Cliente
import Data.List

verificaFuncionario :: IO()
verificaFuncionario = do
    Mensagens.ehFuncionario
    cpf <- Util.lerEntradaString
     
    arq <- readFile "arquivos/funcionarios.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if (Util.ehCadastrado cpf lista)
        then do {putStr("\nBem vindo de volta!\n"); loginFuncionario}
    else do
        {Mensagens.usuarioInvalido; verificaFuncionario}

loginFuncionario :: IO()
loginFuncionario = do
    Mensagens.menuFuncionario

    putStr("Opção: ")
    op <- Util.lerEntradaString
    if op == "1"
        then do cadastrarCliente
    else if op == "2"
        then do {Mensagens.exibirListaVagas; loginFuncionario}
    else if op == "3"
        then do {Mensagens.exibirListaClientesCadastrados; loginFuncionario}
    else if op == "5"
        then do calcularValorEstacionamento
    else if op == "6"
        then do {Mensagens.mensagemDeSaida; return()}
    else do
        {Mensagens.opcaoInvalida; loginFuncionario}

calcularValorEstacionamento :: IO()
calcularValorEstacionamento = do
    Mensagens.informeCpf
    cpf <- Util.lerEntradaString

    arq <- readFile "arquivos/horario-cpf.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if (Util.ehCadastrado cpf lista)
        then do {horaDeSaidaCalculo cpf; reescreverVaga cpf; loginFuncionario}
    else do
        {Mensagens.usuarioInvalido; loginFuncionario}

reescreverVaga :: String -> IO()
reescreverVaga cpf = do

    arq <- readFile "arquivos/cpv.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    let getVaga = Util.getIndiceCpv(Util.getVagaCpv cpf lista) ++ "," ++ "\n"
    appendFile "arquivos/vagas.txt" (getVaga)

    let excluirCpv = Util.opcaoVaga cpf lista
    print(excluirCpv)
    Util.escreverCpv (primeiraCpv (excluirCpv)) ----- TEM QUE EXCLUIR O HORARIO-CPF
    putStr("")


horaDeSaidaCalculo :: String -> IO()
horaDeSaidaCalculo cpf = do
    Mensagens.horaDeSaida
    horaDeSaida <- Util.lerEntradaString
    
    arq <- readFile "arquivos/horario-cpf.txt"
    let lista = ((Data.List.map (wordsWhen(==',') ) (lines arq)))

    arqClientes <- readFile "arquivos/clientes.txt"
    let lista2 = ((Data.List.map (wordsWhen(==',') ) (lines arqClientes)))

    Mensagens.valorPago cpf lista2
    print(valorFinalEst horaDeSaida (dizHoraInt (horaCpf cpf lista)))

horaCpf :: String -> [[String]] -> [[String]]
horaCpf _ [] = []
horaCpf v (x:xs) | (auxHoraCpf v x) == False = horaCpf v xs
                   | otherwise = x:horaCpf v xs

auxHoraCpf :: String -> [String] -> Bool
auxHoraCpf v (x:xs) = (v == x)

dizHoraInt:: [[String]] -> Int
dizHoraInt l = read (l !! 0 !! 1) :: Int

toInt :: String -> Int
toInt s = read (s) :: Int

valorFinalEst :: String -> Int -> Int
valorFinalEst saida entrada =  ((toInt saida) - entrada) * 5


cadastrarCliente :: IO()
cadastrarCliente = do
    Mensagens.cadastrarNome
    nome <- Util.lerEntradaString
    Mensagens.informeCpf
    cpf <- Util.lerEntradaString

    arq <- readFile "arquivos/clientes.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if not (Util.ehCpfValido cpf)
        then do {Mensagens.cpfInvalido; cadastrarCliente}
    else if (Util.ehCadastrado cpf lista)
        then do {Mensagens.usuarioCadastrado; cadastrarCliente}
    else do
        Mensagens.cadastrarPlaca
        placa <- Util.lerEntradaString
        let clienteStr = cpf ++ "," ++ nome ++ "," ++ placa ++ "\n"
        appendFile "arquivos/clientes.txt" (clienteStr)

        Mensagens.cadastraHorarioEntrada
        horario <- Util.lerEntradaString
        let horaCpf = cpf ++ "," ++ horario ++ "\n"
        appendFile "arquivos/horario-cpf.txt" (horaCpf)
        
        loginFuncionario
