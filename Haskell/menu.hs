import Util
import Mensagens
import Estacionamento

main :: IO ()
main = do
	Mensagens.putMensagem
	Mensagens.putOpcoesMenu
	
	opcao <- Util.lerEntradaString
	escolheOpcao opcao

escolheOpcao :: String -> IO()
escolheOpcao opcao | opcao == "1" = telaLoginCliente
				   | opcao == "2" = telaLoginAdmin
				   | opcao == "4" = Mensagens.putMsgSaida
                   | otherwise = do {Mensagens.putMsgOpcaoInvalida; main}


telaLoginCliente :: IO()
telaLoginCliente = do
    Mensagens.putMsgLoginCliente
    cpf <- Util.lerEntradaString
    if cpf == "S"
        then do main
    else if Util.ehCpfValido cpf
        then if Estacionamento.ehCliente cpf
                then do telaLogado cpf
            else do {Mensagens.putMsgUserInvalido; telaLoginCliente}
    else do {Mensagens.putMsgCpfInvalido; telaLoginCliente}

telaLogado :: String -> IO()
telaLogado cpf = do
	let nome = Estacionamento.getNomeCliente cpf
	Mensagens.putMsgOpcoesMenuCliente nome

telaLoginAdmin :: IO()
telaLoginAdmin = do
	Mensagens.putMsgOpcoesMenuAdmin
