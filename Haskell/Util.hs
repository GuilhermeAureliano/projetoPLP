module Util where
import System.IO.Unsafe

lerEntradaString :: IO String
lerEntradaString = do
    x <- getLine
    return x

ehCpfValido :: String -> Bool
ehCpfValido cpf | length cpf /= 11 = False
                | otherwise = all (`elem` ['0'..'9']) cpf