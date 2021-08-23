import ControllerCliente
import ControllerFuncionario
import ControllerDono
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
escolheOpcao opcao | opcao == "1" = ControllerCliente.loginCliente
				   | opcao == "2" = ControllerFuncionario.verificaFuncionario
				   | opcao == "3" = ControllerDono.verificaDono
				   | opcao == "4" = Mensagens.mensagemDeSaida
                   | otherwise = do {Mensagens.opcaoInvalida; main}
