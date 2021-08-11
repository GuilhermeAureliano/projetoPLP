module Util where
import System.IO.Unsafe

lerEntradaString :: IO String
lerEntradaString = do
    x <- getLine
    return x

ehCpfValido :: String -> Bool
ehCpfValido cpf = True 
---- Comentado para aceitar qualquer número por enquanto
---ehCpfValido cpf | length cpf /= 11 = False
 ---               | otherwise = all (`elem` ['0'..'9']) cpf