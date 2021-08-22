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
                    | opcao == "2" = Util.escolheVaga
                    | otherwise = do {Mensagens.opcaoInvalida; loginCliente}

