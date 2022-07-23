--a)
data Moneda = Uno | Dos | Cinco | Diez deriving (Show, Enum)
type Cantidad = Int

titulo :: Moneda -> String
titulo Uno = "Un peso"
titulo Dos = "Dos pesos"
titulo Cinco = "Cinco pesos"
titulo Diez = "Diez pesos"

--2)a)
data ContadoraMonedas = SinPlata | Agregar Moneda ContadoraMonedas

--b)
monedasIguales Uno Uno = True 
monedasIguales Dos Dos = True
monedasIguales Cinco Cinco = True
monedasIguales Diez Diez = True
monedasIguales _ _ = False


entregar_monedas :: ContadoraMonedas -> Moneda -> [Moneda]
entregar_monedas SinPlata _ = []
entregar_monedas (Agregar m1 cm) m2 | monedasIguales m1 m2 = m2 : entregar_monedas cm m2
                                    | otherwise = entregar_monedas cm m2

monederoprueba :: ContadoraMonedas
monederoprueba = Agregar Uno $ Agregar Cinco $ Agregar Diez $ Agregar Uno SinPlata


--1)a)

data Medalla = Bronce | Plata | Oro deriving (Show , Enum)
type Medallero = [Medalla]

--b)
valor_medalla :: Medalla -> Int
valor_medalla Bronce = 1
valor_medalla Plata = 2
valor_medalla Oro = 4

--2)a)
data Disciplina = Boxeo | Judo | Vela | Jockey | Tenis
data Resultado = Res Disciplina Medalla

medallero_vela :: [Resultado] -> Medallero
medallero_vela [] = []
medallero_vela ((Res Vela m) : xs) = m : medallero_vela xs   
medallero_vela ((Res _ m) : xs) = medallero_vela xs   

listaRes = [Res Vela Oro, Res Judo Plata, Res Boxeo Bronce, Res Vela Plata]


--a)

data ListaAsoc a b = Vacia | Nodo a b ( ListaAsoc a b ) deriving (Show, Eq)
type Diccionario = ListaAsoc String String
type Padron = ListaAsoc Int String


la_existe :: Eq a => ListaAsoc a b -> a -> Bool 
la_existe  Vacia _ = False
la_existe (Nodo a1 b list) a2 = a1 == a2 || la_existe list a2

guiaprueba = (Nodo "Jorge" 4582(Nodo "Marta" 3256( Nodo "Pepe" 4521 (Nodo "Alex" 4512 Vacia))))

--b)

la_busca :: Eq a => ListaAsoc a b -> a -> Maybe b 
la_busca Vacia _ = Nothing
la_busca (Nodo a1 b lista) a2 |a2 == a1 = Just b
                              |a2 /= a1 = la_busca lista a2
                              
la_existe1 :: Eq a => ListaAsoc a b -> a -> Bool
la_existe1 Vacia _ = False
la_existe1 (Nodo a1 b list) a2 = case la_busca (Nodo a1 b list) a2 of
                                Just b-> True
                                Nothing -> False

--1)
estaEnDNI:: Int -> Bool
estaEnDNI 4 = True
estaEnDNI 0 = True
estaEnDNI 9 = True
estaEnDNI 7 = True
estaEnDNI 3 = True
estaEnDNI 5 = True
estaEnDNI _ = False

--2)
sumaDni :: [Int] -> Int
sumaDni [] = 0
sumaDni (x:xs)  | estaEnDNI x = x + sumaDni xs
                | otherwise = sumaDni xs

--3)
sumatoria1 :: [a] -> (a -> Int) -> Int
sumatoria1 [] t = 0
sumatoria1 (x:xs) t = (t x) + sumatoria1 xs t

verificacion :: Int -> Int
verificacion n  | estaEnDNI n = n 
                | estaEnDNI n == False = 0

sumaDni1 :: [Int] -> Int
sumaDni1 xs = sumatoria1 xs verificacion

--4)


reducir :: [a] -> (a -> a -> a) -> a 
reducir [x] op = x
reducir [x,y] op = op x y
reducir (x:y:xs) op = op x (op y (reducir xs op))

--Tema D 1)a)
data NotaMusical = Do | Re | Mi | Fa | Sol | La | Si deriving (Show, Enum)
type Melodia = [NotaMusical]

--b)
cifrado_americano :: NotaMusical -> Char
cifrado_americano Do = 'C'
cifrado_americano Re = 'D'
cifrado_americano Mi = 'E'
cifrado_americano Fa = 'F'
cifrado_americano Sol = 'G'
cifrado_americano La = 'A'
cifrado_americano Si = 'B'

--2)a)
