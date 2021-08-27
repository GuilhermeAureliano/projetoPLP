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

getNome :: String -> [[String]] -> String
getNome _ [] = ""
getNome c (x:xs)   | ((headCadastrado c x) == False) = getNome c xs
                   | otherwise = x !! 1

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

getVagaCpv :: String -> [[String]] -> [[String]]
getVagaCpv _ [] = []
getVagaCpv v (x:xs) | (aux v x) == False = getVagaCpv v xs
                   | otherwise = x:getVagaCpv v xs

getIndiceCpv :: [[String]] -> String
getIndiceCpv l = l !! 0 !! 2


aux :: String -> [String] -> Bool
aux v (x:xs) = (v == x)

escolheVaga :: String -> String -> IO()
escolheVaga cpf placa = do

    arq <- readFile "arquivos/vagas.txt"
    let lista = ((Data.List.map (wordsWhen(==',') ) (lines arq)))
    
    if lista == []
        then do print ("Não há vagas!!!!")
    else
        do

    print(lista)
    putStr("\nQual vaga você deseja? ")

    vaga <- lerEntradaString
    let lista2 = opcaoVaga (vaga) lista

    putStr("\nDeseja adicionar serviço extra de lava-jato e cera? [S/N] ")
    servicoextra <- Util.lerEntradaString


    let n = primeira (lista2)
    escreverArq (primeira (lista2))

    let cpvStr = cpf ++ "," ++ placa ++ "," ++ vaga ++ "\n"
    appendFile "arquivos/cpv.txt" (cpvStr)

    putStr("\nHora de entrada? ")
    horario <- Util.lerEntradaString

    let cpvh = cpf ++ "," ++ placa ++ "," ++ vaga ++ "," ++ horario ++ "," ++ servicoextra ++ "\n"

    appendFile "arquivos/horario-cpf.txt"  (cpvh)

    let cpfUltimaVaga = cpf ++ "," ++ vaga ++ "\n"
    appendFile "arquivos/recomendarVaga.txt" (cpfUltimaVaga)

escreverArq :: String -> IO()
escreverArq n = do

    arq <- openFile "arquivos/vagas.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq

escreverCpv :: String -> IO()
escreverCpv n = do

    arq <- openFile "arquivos/cpv.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq

escreverHorarioCpf :: String -> IO()
escreverHorarioCpf n = do

    arq <- openFile "arquivos/horario-cpf.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq

primeiraHorarioCpf :: [[String]] -> String
primeiraHorarioCpf [] = ""
primeiraHorarioCpf (x:xs) = head x ++ "," ++ (x !! 1) ++ "\n" ++ primeiraHorarioCpf xs

primeiraCpv :: [[String]] -> String
primeiraCpv [] = ""
primeiraCpv (x:xs) = head x ++ "," ++ (x !! 1) ++ "," ++ (x !! 2) ++ "," ++ (x !! 3) ++ "," ++ (x !! 4) ++ "\n" ++ primeiraCpv xs


primeira :: [[String]] -> String
primeira [] = ""
primeira (x:xs) = head x ++ "," ++ "\n" ++ primeira xs

-------- ORDENAR VAGAS ---------
getMenor :: [String] -> String
getMenor [x] = x
getMenor(x:xs) | ( parseToInt (x) < parseToInt (maxi)) = x
               | otherwise = maxi
             where maxi = getMenor xs

removeMenor :: [String] -> [String]
removeMenor [] = []
removeMenor (x:xs) | (x == getMenor(x:xs)) = xs
                   | otherwise = (x:removeMenor xs)

parseToInt :: String -> Int
parseToInt s = read (s) :: Int

ordena :: [String] -> [String] -> [String]
ordena lista_ordenada [] = lista_ordenada
ordena lista_ordenada listaOriginal = ordena (lista_ordenada++[getMenor listaOriginal]) (removeMenor listaOriginal)


ordenarLista :: [String] -> [String]
ordenarLista listaOriginal = ordena [] listaOriginal

parseDicToList :: [[String]] -> [String]
parseDicToList [] = []
parseDicToList lista = head (head lista):parseDicToList (tail lista)

parseToTxt :: [String] -> String
parseToTxt [] = ""
parseToTxt lista = head lista ++ "," ++ "\n" ++ parseToTxt (tail lista)

reescreveVagas :: IO()
reescreveVagas = do

    arq <- readFile "arquivos/vagas.txt"
    ---hPutStr arq n
    let lista = ((Data.List.map (Util.wordsWhen(==',') ) (lines arq)))

    print ((ordenarLista (parseDicToList (lista))))

recomendacaoVaga :: [[String]] -> String
recomendacaoVaga (x:xs) = (x !! 1) 

auxRecomendar :: String -> [[String]] -> [[String]]
auxRecomendar _ [] = []
auxRecomendar v (x:xs) | (aux v x) == False = auxRecomendar v xs
                   | otherwise = x:auxRecomendar v xs