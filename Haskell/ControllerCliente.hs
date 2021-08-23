module ControllerCliente where
import Util
import Mensagens
import Estacionamento
import Cliente
import Data.List

loginCliente :: IO()
loginCliente = do
    Mensagens.menuDoCliente

    putStr("Opção: ")
    opcao <- Util.lerEntradaString

    opcoesCliente opcao

opcoesCliente :: String -> IO()
opcoesCliente opcao | opcao == "1" = do {Mensagens.exibirListaVagas; loginCliente}
                    | opcao == "2" = do {vagaOcupadaCliente; loginCliente}
                    | opcao == "6" = do {Mensagens.mensagemDeSaida; return()}
                    | otherwise = do {Mensagens.opcaoInvalida; loginCliente}

vagaOcupadaCliente :: IO()
vagaOcupadaCliente = do
    Mensagens.informeCpf
    cpf <- Util.lerEntradaString

    arq <- readFile "arquivos/cpv.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if (Util.ehCadastrado cpf lista)
        then do Mensagens.usuarioVagaOcupada
    else do
        Mensagens.cadastrarPlaca
        placa <- Util.lerEntradaString

        Util.escolheVaga cpf placa
        putStr("")

