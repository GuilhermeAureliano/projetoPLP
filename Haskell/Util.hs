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


wordsWhen     :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'

ehCliente :: String -> [[String]] -> Bool
ehCliente _ [[]] = False
ehCliente c (x:xs) | ((headCliente c x) == False) = ehCliente c xs
                   | otherwise = True

headCliente :: String -> [String] -> Bool
headCliente c (x:xs) = (c == x)