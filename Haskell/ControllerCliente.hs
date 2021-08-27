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
                        | opcao == "3" = do {recomendarVaga; loginCliente menu}
                        | opcao == "5" = menu
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
        putStr("Informe o nome: ")
        nome <- Util.lerEntradaString

        Mensagens.cadastrarPlaca
        placa <- Util.lerEntradaString

        let clienteStr = cpf ++ "," ++ nome ++ "," ++ placa ++ "\n"
        appendFile "arquivos/clientes.txt" (clienteStr)

        Util.escolheVaga cpf placa
    putStr("")

recomendarVaga :: IO()
recomendarVaga = do
    Mensagens.informeCpf
    cpf <- Util.lerEntradaString

    arq <- readFile "arquivos/recomendarVaga.txt"
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    if (Util.ehCadastrado cpf lista)
        then do
            putStr("Nós recomendamos a você a vaga: ") 
            print ( read (Util.recomendacaoVaga (Util.auxRecomendar cpf lista)) :: Int )

    else do
        putStr("")