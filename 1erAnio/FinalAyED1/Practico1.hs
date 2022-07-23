--Ejercicio 1
--a)
esCero :: Int -> Bool
esCero x = x==0

--b)
esPositivo :: Int -> Bool
esPositivo x = x > 0
--c)
esVocal :: Char -> Bool
esVocal x = x=='a' || x=='e' || x=='i' || x=='o' || x=='u'

--Ejercicio 2
--a)
paratodo :: [Bool] -> Bool
paratodo [] = True
paratodo (x:xs) = x == True && paratodo xs
--b)
sumatoria :: [Int] -> Int
sumatoria [] = 0
sumatoria (x:xs) = x + sumatoria xs

--c)
productoria :: [Int] -> Int
productoria [] = 1
productoria (x:xs) = x * productoria xs
--d)
factorial :: Int -> Int
factorial 0 = 1
factorial x = x* factorial (x-1)
--e)
promedio :: [Int] -> Int
promedio xs = div (sumatoria xs)  (length xs)

--3)
pertenece :: Int -> [Int] -> Bool
pertenece _ [] = False
pertenece x (y:ys) = x == y || pertenece x ys

--4)
--a)
paratodo' :: [a] -> (a -> Bool) -> Bool
paratodo' [] _ = True
paratodo' (x:xs) t = t x && paratodo' xs t
--b)
existe' :: [a] -> (a -> Bool) -> Bool
existe' [] _ = False
existe' (x:xs) t = (t x) || (existe' xs t)
--c)
sumatoria' :: [a] -> (a -> Int) -> Int
sumatoria' [] _ = 0
sumatoria' (x:xs) t = t x + sumatoria' xs t
--d)
productoria' :: [a] -> (a -> Int) -> Int
productoria' [] _ = 1
productoria' (x:xs) t = t x * productoria' xs t
--5)
paratodo'' :: [a] -> (a-> Bool) -> Bool
paratodo'' (x:xs) t = paratodo' (x:xs) t

--6)
--a)

todosPares :: [Int] -> Bool
todosPares [] = True
todosPares (x:xs) = paratodo' (x:xs) even
--b)
esMultiplo :: Int -> Int -> Bool
esMultiplo y x = mod x y == 0 

hayMultiplo :: Int -> [Int] -> Bool
hayMultiplo y xs = existe' xs (esMultiplo y)
--c)
sumaCuadrados :: Int -> Int
sumaCuadrados 0 = 0
sumaCuadrados y = sumatoria' [0..y-1] (^2)
--d)
factorial' :: Int -> Int
factorial' y = productoria [1..y] 
--e)
multiplicaPares :: [Int] -> Int
multiplicaPares xs = productoria (filter even xs)
--8)
--a)
duplica :: [Int] -> [Int]
duplica [] = []
duplica (x:xs) = x *2 : duplica xs
--b)

duplica' :: [Int] -> [Int]
duplica' xs = map (*2) xs 

--9)
--a)
dejarPares :: [Int] -> [Int]
dejarPares [] = []
dejarPares (x:xs)   | even x = x : dejarPares xs
                    | otherwise = dejarPares xs
--b)
dejarPares' :: [Int] -> [Int]
dejarPares' xs = filter even xs
--c)está bien así
--10)
--a)
primIgualesA :: Eq a => a -> [a] -> [a]
primIgualesA _ [] = []
primIgualesA y (x:xs) | y == x = y: primIgualesA y xs
                      | otherwise = []
--b)
primIgualesA' :: Eq a => a -> [a] -> [a]
primIgualesA' y xs = takeWhile(y==) xs

