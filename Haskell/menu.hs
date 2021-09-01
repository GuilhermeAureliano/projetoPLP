import ControllerCliente
import ControllerFuncionario
import ControllerDono
import Util
import Mensagens

main :: IO ()
main = do
	putStr("      === Bem-vindo ao ESTACIONAMENTO ===\n")
	Mensagens.menuPrincipal
	
	opcao <- Util.lerEntradaString
	escolheOpcao opcao

escolheOpcao :: String -> IO()
escolheOpcao opcao | opcao == "1" = ControllerCliente.loginCliente main
				   | opcao == "2" = ControllerFuncionario.verificaFuncionario main
				   | opcao == "3" = ControllerDono.verificaDono main
				   | opcao == "4" = Mensagens.mensagemDeSaida
                   | otherwise = do {Mensagens.opcaoInvalida; main}
