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

aux :: String -> [String] -> Bool
aux v (x:xs) = (v == x)

getVagaCpv :: String -> [[String]] -> [[String]]
getVagaCpv _ [] = []
getVagaCpv v (x:xs) | (aux v x) == False = getVagaCpv v xs
                   | otherwise = x:getVagaCpv v xs

getIndiceCpv :: [[String]] -> String
getIndiceCpv l = l !! 0 !! 2



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
    escreveVaga (primeira (lista2))

    let cpvStr = cpf ++ "," ++ placa ++ "," ++ vaga ++ "\n"
    appendFile "arquivos/cpv.txt" (cpvStr)

    putStr("\nHora de entrada? ")
    horario <- Util.lerEntradaString

    let cpvh = cpf ++ "," ++ placa ++ "," ++ vaga ++ "," ++ horario ++ "," ++ servicoextra ++ "\n"

    appendFile "arquivos/horario-cpf.txt"  (cpvh)

    let cpfUltimaVaga = cpf ++ "," ++ vaga ++ "\n"
    appendFile "arquivos/recomendarVaga.txt" (cpfUltimaVaga)

escreveCliente :: String -> IO()
escreveCliente n = do

    arq <- openFile "arquivos/clientes.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq

escreveVaga :: String -> IO()
escreveVaga n = do

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

escreverUsoDoContrato :: String -> IO()
escreverUsoDoContrato n = do

    arq <- openFile "arquivos/usoDoContrato.txt" WriteMode
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


primeiraCliente :: [[String]] -> String
primeiraCliente [] = ""
primeiraCliente (x:xs) = head x ++ "," ++ (x !! 1) ++ "," ++ (x !! 2) ++ "\n" ++ primeiraCliente xs

primeira :: [[String]] -> String
primeira [] = ""
primeira (x:xs) = head x ++ "," ++ "\n" ++ primeira xs

-------- ORDENAR VAGAS ---------
getMenor :: [String] -> String
getMenor [x] = x
getMenor(x:xs) | ( parseToInt2 (x) < parseToInt2 (maxi)) = x
               | otherwise = maxi
             where maxi = getMenor xs

removeMenor :: [String] -> [String]
removeMenor [] = []
removeMenor (x:xs) | (x == getMenor(x:xs)) = xs
                   | otherwise = (x:removeMenor xs)

parseToInt2 :: String -> Int
parseToInt2 s = read (s) :: Int

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

toInt2 :: String -> Int
toInt2 s = read (s) :: Int

toString :: Int -> String
toString n = show (n)


primeiraContrato :: [[String]] -> String
primeiraContrato [] = ""
primeiraContrato (x:xs) = head x ++ "," ++ (x !! 1) ++ "," ++ (x !! 2) ++  "\n" ++ primeiraContrato xs

contrato :: String -> [[String]] -> [[String]]
contrato _ [] = []
contrato cpf (x:xs) |  ((x !! 0) == cpf) = ((x !! 0):(toString ((toInt2 (x !! 1) + 1))):(x !! 2):[]):contrato cpf xs
                    | otherwise = ((x !! 0):(toString ((toInt2 (x !! 1)))):(x !! 2):[]):contrato cpf xs

renovarContrato :: String -> [[String]] -> [[String]]
renovarContrato _ [] = []
renovarContrato cpf (x:xs) |  ((x !! 0) == cpf) = ((x !! 0):(toString ((toInt2 (x !! 1) * 0))):(x !! 2):[]):renovarContrato cpf xs
                    | otherwise = ((x !! 0):(toString ((toInt2 (x !! 1)))):(x !! 2):[]):renovarContrato cpf xs

---[["20","0"],["90","0"],["85","1"],["25","0"]]  

escreverUsoDoContratoRenovado :: String -> IO()
escreverUsoDoContratoRenovado n = do

    arq <- openFile "arquivos/usoDoContrato.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq