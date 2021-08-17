module ControllerFuncionario where
import Util
import Mensagens
import Estacionamento
import Cliente

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
        let clienteStr = nome ++ "," ++ cpf ++ "," ++ placa ++ "," ++ " " ++ "\n"
        appendFile "arquivos/clientes.txt" (clienteStr)
        loginFuncionario