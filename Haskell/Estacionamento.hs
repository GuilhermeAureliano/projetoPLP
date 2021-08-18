module Estacionamento where
import Cliente

ehCliente :: String -> Bool
ehCliente cpf = Cliente.ehCliente cpf

getNomeCliente :: String -> String
getNomeCliente cpf = Cliente.getNome cpf

calcularValor :: String -> String
calcularValor horario = horario