module Cliente where

ehCliente :: String -> Bool
ehCliente cpf = True

getNome :: String -> String
getNome cpf = "Guilherme Aureliano"

cadastraCliente :: String -> String -> String -> String
cadastraCliente nome cpf placa = do
    if ehCliente cpf
        then "Erro: usuário já cadastrado!"
    else
        "Usuário cadastrado!\n" ++ "Bem vindo " ++ nome