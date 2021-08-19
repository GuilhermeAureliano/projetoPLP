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

ehCadastrado :: String -> [[String]] -> Bool
ehCadastrado _ [[]] = False
ehCadastrado c (x:xs) | ((headCadastrado c x) == False) = ehCadastrado c xs
                   | otherwise = True

headCadastrado :: String -> [String] -> Bool
headCadastrado c (x:xs) = (c == x)

opcaoVaga :: String -> [[String]] -> [[String]]
opcaoVaga _ [] = []
opcaoVaga v (x:xs) | (aux v x) == True = opcaoVaga v xs
                   | otherwise = x:opcaoVaga v xs

aux :: String -> [String] -> Bool
aux v (x:xs) = (v == x)