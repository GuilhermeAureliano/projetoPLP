import Util
import Mensagens
import Estacionamento
import Cliente

main :: IO ()
main = do
	Mensagens.mensagemInicial
	Mensagens.menuPrincipal
	
	opcao <- Util.lerEntradaString
	escolheOpcao opcao

escolheOpcao :: String -> IO()
escolheOpcao opcao | opcao == "1" = loginCliente
				   | opcao == "2" = loginFuncionario
				   | opcao == "4" = Mensagens.mensagemDeSaida
                   | otherwise = do {Mensagens.opcaoInvalida; main}


loginCliente :: IO()
loginCliente = do
    Mensagens.loginDoCliente
    cpf <- Util.lerEntradaString
    if cpf == "S"
        then do main
    else if Util.ehCpfValido cpf
        then if Cliente.ehCliente cpf
                then do telaLogado cpf
            else do {Mensagens.usuarioInvalido; loginCliente
        }
    else do {Mensagens.cpfInvalido; loginCliente
}

telaLogado :: String -> IO()
telaLogado cpf = do
	let nome = Estacionamento.getNomeCliente cpf
	Mensagens.menuDoCliente nome

loginFuncionario :: IO()
loginFuncionario = do
    Mensagens.menuFuncionario

    op <- Util.lerEntradaString
    if op == "1"
        then do cadastrarCliente
    else if op == "2"
        then do Mensagens.exibirListaVagas
    else if op == "3"
        then do Mensagens.exibirListaClientesCadastrados
    else if op == "5"
        putStr "Informe o CPF do cliente: "
        putStr "Informe o horário de saída: "
    else if op == "6"
        then do main
    else do
        {Mensagens.opcaoInvalida; loginFuncionario}

cadastrarCliente :: IO()
cadastrarCliente = do
    Mensagens.cadastrarNome
    nome <- Util.lerEntradaString
    if nome == "S" || nome == "s"
        then do main
    else do
        Mensagens.cadastrarCpf
        cpf <- Util.lerEntradaString
        if not (Util.ehCpfValido cpf)
            then do {Mensagens.cpfInvalido; cadastrarCliente}
        else do
            Mensagens.cadastrarPlaca
            placa <- Util.lerEntradaString
            let clienteStr = nome ++ "," ++ cpf ++ "," ++ placa ++ "," ++ " " ++ "\n"
            appendFile "arquivos/clientes.txt" (clienteStr)