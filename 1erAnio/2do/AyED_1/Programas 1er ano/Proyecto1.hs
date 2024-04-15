--Proyecto 1 
import Language.Haskell.TH.Syntax (tupleDataName, Callconv (Prim))

--1)a) 
esCero :: Int -> Bool
esCero x = x==0

--b) 
esPositivo :: Int -> Bool
esPositivo x = x > 0

--c) 
esVocal :: Char -> Bool
esVocal char = char == 'a' || char == 'e' || char == 'i' || char == 'o' || char == 'u'

--2) a) 
paraTodo :: [Bool] -> Bool
paraTodo [] = True
paraTodo (x:xs) = x == True && paraTodo xs
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
factorial 1 = 1
factorial x = x * (x-1)
--e) 
promedio :: [Int] -> Int
promedio (x:xs) = div (sumatoria (x:xs)) (length xs)

-- 3)
pertenece :: Int -> [Int] -> Bool
pertenece n [] = False
pertenece n (x:xs) = n == x || pertenece n xs

-- 4) a) 
paraTodo1  :: [a] -> (a -> Bool) -> Bool
paraTodo1 [] t = True
paraTodo1 (x:xs) t = (t x) && paraTodo1 xs t

-- b) 
existe1 :: [a] -> (a -> Bool) -> Bool
existe1 [] t = False
existe1 (x:xs) t = (t x) || existe1 xs t

-- c) 
sumatoria1 :: [a] -> (a -> Int) -> Int
sumatoria1 [] t = 0
sumatoria1 (x:xs) t = (t x) + sumatoria1 xs t

--d)
productoria1 :: [a] -> (a -> Int) -> Int
productoria1 [] t = 1
productoria1 (x:xs) t = (t x) * productoria1 xs t

--5. 
f :: Bool -> Bool
f x = (x == True)

paraTodo2 :: [Bool] -> Bool
paraTodo2 (x:xs) = paraTodo1 (x:xs) f

--6) a) 
todosPares :: [Int] -> Bool
todosPares (x:xs) = paraTodo1 (x:xs) even

-- b)
hayMultiplo :: Int -> [Int] -> Bool
hayMultiplo y xs =  existe1 xs (\ x -> (mod x y) == 0)

--c)
sumaCuadrados :: Int -> Int
sumaCuadrados 0 = 0
sumaCuadrados x = sumatoria1 [0..x-1] (^ 2)

--d)
factorial1 :: Int -> Int
factorial1 x = productoria [1..x]

--e)
par :: Int -> Int
par x | even x = x
      | otherwise = 1

multiplicaPares :: [Int] -> Int
multiplicaPares xs = productoria (map par xs)

--otras formas:
--multiplicaPares xs = productoria (filter even xs)
--multiplicaPares (x:xs) = productoria1 (x:xs) par


{- 7. Indaga en Hoogle sobre las funciones map y filter. Tambien podes consultar su tipo en
ghci con el comando :t.

¿Que hacen estas funciones?
--La funcion map aplica una funcion a cada elemento de una lista. La funcion filter
--verifica que cada elemento de una lista cumpla una condicion
¿A que equivale la expresion map succ [1, -4, 6, 2, -8], donde succ n = n+1?
--map succ [1,-4,6,2,-8] == [2,-3,7,3,-7]
¿Y la expresion filter esPositivo [1, -4, 6, 2, -8]? 
Esta exprecion equivale a [1,6,2]
-}

--8) a)
duplica :: [a] -> [a]
duplica [] = []
duplica (x:xs) = x: x : duplica xs

--b) 
duplica xs = map id xs

--9) a)
esPar :: [Int] -> [Int]
esPar [] = []
esPar (x:xs) | even x = x : esPar xs
             | otherwise = esPar xs

--b) 
esPar1 :: Integral a => [a] -> [a]
esPar1 xs = filter even xs

--c) Revisa tu definicion del ejercicio 6e. ¿Como podes mejorarla? 
--multiplicaPares xs = productoria (filter even xs)

--10) a)
primIgualesA :: Eq a => a -> [a] -> [a]
primIgualesA _ [] = []
primIgualesA y (x:xs) | y == x = x: primIgualesA y xs
                      | y /= x = []

--b) 
primIgualesA1 :: Eq a => a -> [a] -> [a]
primIgualesA1 y xs = takeWhile (==y) xs

--11) a)
primIguales :: Eq a => [a] -> [a]
primIguales [] = []
primIguales [x] = [x]
primIguales (x:xs) | x == head xs = x : primIguales xs
                   | x /= head xs = x : []
                   
--b) 
primIguales1 :: Eq a => [a] -> [a]
primIguales1 xs = primIgualesA (head xs) xs 
{- 12. (*) Para cada uno de los siguientes patrones, decidi si 
estan bien tipados, y en tal caso da los tipos de cada 
subexpresion. En caso de estar bien tipado, ¿el patron cubre
 todos los casos de definicion?
a) f :: (a, b) -> ...
f x = ...
Está bien tipado y cubre todos los casos de tuplas
b) f :: (a, b) -> ...
f (x , y) = ...
Sí está bien tipado y cubre todo los casos de tuplas
c) f :: [(a, b)] -> ...
f (a , b) = ...
No está bien tipado, la función toma una lista de tuplas mientras que el patron usa una sola tupla
d) f :: [(a, b)] -> ...
f (x:xs) = ...
Esta bien tipado. x toma el valor de la primer tupla de las lista pero si la lista es vacia no está definido
e) f :: [(a, b)] -> ...
f ((x, y) : ((a, b) : xs)) = ...
Está bien tipada ya que  el operador interno de las listas es :
Pero no cubre el caso de lista vacia y la lista con menos de dos elementos
f ) f :: [(Int, a)] -> ...
f [(0, a)] = ...

g) f :: [(Int, a)] -> ...
f ((x, 1) : xs) = ...
h) f :: [(Int, a)] -> ...
f ((1, x) : xs) = ...
i) f :: (Int -> Int) -> Int -> ...
f a b = ...
j) f :: (Int -> Int) -> Int -> ...
f a 3 = ...
k) f :: (Int -> Int) -> Int -> ...
f 0 1 2 = ...
l) f :: a -> (a -> a) -> ...
f a g = ...
13. (*) Para las siguientes declaraciones de funciones, da 
al menos una defincion cuando sea posible (que no sea la 
expresion undefined). ¿Podes dar alguna otra definicion 
alternativa a la que diste en cada caso?
Por ejemplo, si la declaracion es f :: (a, b) -> a,
la respuesta es: f (x,y) = x
a) f :: (a, b) -> b
b) f :: (a, b) -> c
c) f :: a -> b
d) f :: (a -> b) -> a -> b
e) f :: (a -> b) -> [a] -> [b]
f ) f :: (a -> b) -> a -> c
g) f :: (a -> b) -> (b -> c) -> a -> c -}
