import Util
import Mensagens
import Estacionamento

main :: IO ()
main = do
	Mensagens.mensagemInicial
	Mensagens.menuPrincipal
	
	opcao <- Util.lerEntradaString
	escolheOpcao opcao

escolheOpcao :: String -> IO()
escolheOpcao opcao | opcao == "1" = loginCliente
				   | opcao == "2" = loginAdministrador
                   | opcao == "3" = cadastrarUsuario
				   | opcao == "4" = Mensagens.mensagemDeSaida
                   | otherwise = do {Mensagens.opcaoInvalida; main}


loginCliente :: IO()
loginCliente = do
    Mensagens.loginDoCliente
    cpf <- Util.lerEntradaString
    if cpf == "S"
        then do main
    else if Util.ehCpfValido cpf
        then if Estacionamento.ehCliente cpf
                then do telaLogado cpf
            else do {Mensagens.usuarioInvalido; loginCliente
        }
    else do {Mensagens.cpfInvalido; loginCliente
}

telaLogado :: String -> IO()
telaLogado cpf = do
	let nome = Estacionamento.getNomeCliente cpf
	Mensagens.menuDoCliente nome

loginAdministrador :: IO()
loginAdministrador = do
	Mensagens.menuAdministrador

cadastrarUsuario :: IO()
cadastrarUsuario = do
    Mensagens.cadastrarNome
    nome <- Util.lerEntradaString
    if nome == "S" || nome == "s"
        then do main
    else do
        Mensagens.cadastrarCpf
        cpf <- Util.lerEntradaString
        if not (Util.ehCpfValido cpf)
            then do {Mensagens.cpfInvalido; cadastrarUsuario}
        else do
            Mensagens.cadastrarPlaca
            placa <- Util.lerEntradaString
            let clienteStr = nome ++ "," ++ cpf ++ "," ++ placa ++ "," ++ " " ++ "\n"
            appendFile "arquivos/clientes.txt" (clienteStr)