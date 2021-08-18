module ControllerCliente where
import Util
import Mensagens
import Estacionamento
import Cliente


loginCliente :: IO()
loginCliente = do
    Mensagens.menuDoCliente