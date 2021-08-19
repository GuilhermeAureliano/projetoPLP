module ControllerCliente where
import Util
import Mensagens
import Estacionamento
import Cliente


loginCliente :: IO()
loginCliente = do
    Mensagens.menuDoCliente
    opcao <- Util.lerEntradaString

    opcoesCliente opcao

opcoesCliente :: String -> IO()
opcoesCliente opcao | opcao == "1" = Mensagens.exibirListaVagas
                    | otherwise = do {Mensagens.opcaoInvalida; loginCliente}

