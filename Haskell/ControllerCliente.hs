module ControllerCliente where
import Util
import Mensagens
import Estacionamento
import Cliente


loginCliente :: IO()
loginCliente = do
    Mensagens.loginDoCliente
    cpf <- Util.lerEntradaString
    if Util.ehCpfValido cpf
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