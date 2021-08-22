module Util where
import System.IO
import Data.List 

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
ehCadastrado _ [] = False
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

escolheVaga :: IO()
escolheVaga = do

    arq <- readFile "arquivos/vagas.txt"

    let lista = ((Data.List.map (wordsWhen(==',') ) (lines arq)))
    
    if lista == []
        then do print ("Não há vagas!!!!")
    else
        do

    print(lista)
    input <- lerEntradaString
    let lista2 = opcaoVaga (input) lista

    let n = primeira (lista2)
    escreverArq (primeira (lista2))

escreverArq :: String -> IO()
escreverArq n = do

    arq <- openFile "arquivos/vagas.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq

primeira :: [[String]] -> String
primeira [] = ""
primeira (x:xs) = head x ++ "," ++ "\n" ++ primeira xs
