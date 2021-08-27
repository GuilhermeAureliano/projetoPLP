module ControllerCliente where
import Util
import Mensagens
import Estacionamento
import Cliente
import Data.List

loginCliente :: (IO()) -> IO()
loginCliente menu = do
    Mensagens.menuDoCliente

    putStr("Opção: ")
    opcao <- Util.lerEntradaString

    opcoesCliente menu opcao

opcoesCliente :: (IO()) -> String -> IO()
opcoesCliente menu opcao | opcao == "1" = do {Mensagens.exibirListaVagas; Util.reescreveVagas; loginCliente menu}
                        | opcao == "2" = do {vagaOcupadaCliente; loginCliente menu}
                        | opcao == "6" = menu
                        | otherwise = do {Mensagens.opcaoInvalida; loginCliente menu}

vagaOcupadaCliente :: IO()
vagaOcupadaCliente = do
    Mensagens.informeCpf
    cpf <- Util.lerEntradaString

    --- fazer cadastro antes de escolher a vaga!
    arq <- readFile "arquivos/cpv.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if (Util.ehCadastrado cpf lista)
        then do Mensagens.usuarioVagaOcupada
    else do
        Mensagens.cadastrarPlaca
        placa <- Util.lerEntradaString

        Util.escolheVaga cpf placa
        putStr("")

