import System.IO

main :: IO ()
main = do
	putStr ("\n=====Menu=====\n\n(1) Cliente\n(2) Funcionário")
	putStr ("\n(3) Dono\n(4) Sair")
	putStr ("\n\nOpção => ")
	hFlush stdout --limpa a saida e evita da entra de usuario receba algo inseperado
	entrada <- getChar

	case entrada of
		'1' ->
			do
				putStr ("Digite a placa do automóvel: ")
				hFlush stdout --limpa a saida e evita da entra de usuario receba algo inseperado
				getLine --Evita que o leitor de entrada do usuario receba espacos em branco
				placa <- getLine
				putStr ("Digite seu CPF: ")
				hFlush stdout --limpa a saida e evita da entra de usuario receba algo inseperado
				cpf <- getLine

				putStr ("\n=====VAGAS DISPONÍVEIS=====\nDeseja serviço extra de lava jato e cera? [S/N] ")
				hFlush stdout --limpa a saida e evita da entra de usuario receba algo inseperado
				extra <- getChar
				case extra of 
					'S' ->
						do
							print extra

				putStr ("\nDeseja assinar contrato de exclusividade? [S/N] ")
				hFlush stdout --limpa a saida e evita da entra de usuario receba algo inseperado
				contrato <- getChar

				case contrato of 
					'S' ->
						do
							print contrato
				main
		'4' ->
			return ()