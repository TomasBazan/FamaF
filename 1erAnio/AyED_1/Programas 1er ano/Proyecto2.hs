
--1 a)
data Carrera = Matematica | Fisica | Computacion | Astronomia deriving (Eq, Ord, Show)

--b) 
titulo :: Carrera -> String
titulo Matematica = "Lincenciatura en Matematica"
titulo Fisica = "Lincenciatura en Fisica"
titulo Computacion = "Lincenciatura en Ciencias de la Computacion"
titulo Astronomia = "Lincenciatura en Atronomia"

{-
2. Clases de tipos. En Haskell usamos el operador (==) para comparar valores del mismo tipo:
a) Completar la definicion del tipo Carrera para que las expresiones
$> Matematica <= Computacion
$> Matematica ‘min‘ Computacion
En las definiciones de los ejercicios siguientes, deben agregar deriving solo cuando sea
estrictamente necesario.
-}

--3.
--a) Implementa los tipos Ingreso, Cargo, Area y Persona como est´an definidos arriba.
data Cargo = Titular  | Asociado  | Adjunto | Asistente | Auxiliar deriving Show
data Area = Administrativa | Ensenanza | Economica | Postgrado deriving Show
type Ingreso = Int
type LimiteTiempo = Int
data Persona = Decane
            |Docente Cargo LimiteTiempo
            |NoDocente Area
            |Estudiante Carrera Ingreso
            deriving Show
anoIngreso :: Persona -> Ingreso 
anoIngreso (Estudiante Matematica ing) = ing

limiteTiempo :: Persona -> LimiteTiempo
limiteTiempo (Docente cargo lim) = lim
limiteTiempo _ = 0

{-
--b) ¿Cual es el tipo del constructor Docente?
--El constructor Docente tiene tipo Docente :: Cargo -> Persona 
--c) Programa la funcion cuantos_doc :: [Persona] -> Cargo -> Int que dada una
--lista de personas xs, y un cargo c, devuelve la cantidad de docentes incluidos en xs
--que poseen el cargo c.

igualCargo :: Cargo -> Cargo -> Bool
igualCargo Titular Titular = True
igualCargo Asociado Asociado = True
igualCargo Adjunto Adjunto = True
igualCargo Asistente Asistente = True
igualCargo Auxiliar Auxiliar = True
igualCargo _ _ = False


cuantos_doc :: [Persona] -> Cargo -> Int
cuantos_doc [] c = 0
cuantos_doc (Docente c1:xs) c2  | igualCargo c1 c2 = 1 + cuantos_doc xs c2
                                | not (igualCargo c1 c2) = cuantos_doc xs c2
cuantos_doc (_:xs) c2 = cuantos_doc xs c2

-- [Docente Titular, Docente Asociado, Docente Asociado, Docente Asistente]
--d) ¿La función anterior usa filter? Si no es ası́, reprogramala para usarla.

comparaCargo :: Cargo -> Persona -> Bool
comparaCargo  c4 (Docente c3) = igualCargo c3 c4
comparaCargo  _ _ = False

cuantos_doc1 :: [Persona] -> Cargo -> Int
cuantos_doc1 xs c2 = length (filter (comparaCargo c2) xs)

--4.a) Definir la funcion primerElemento que devuelve el primer elemento 
--de una lista no vacia, o Nothing si la lista es vacia.

primerElemento1 :: [a] -> Maybe a
primerElemento1 [] = Nothing 
primerElemento1 (x:xs) = Just x 

--5. ---------------------------------------------------------

data Cola = VaciaC | Encolada Persona Cola deriving Show

--a) Programa las siguientes funciones:
--1)
atender :: Cola -> Maybe Cola
atender (Encolada persona cola) = Just cola  
atender VaciaC = Nothing

{- tests
  atender (Encolada (Docente Titular) (Encolada (Docente Asociado) (Encolada (Docente Asistente) (Encolada Decane VaciaC))))
  atender (Encolada (Docente Asociado) (Encolada Decane (Encolada (Docente Titular) (Encolada (Docente Asociado)VaciaC))))
  VaciaC
-}

--2) encolar :: Persona -> Cola -> Cola, que agrega una persona a una cola de
--personas, en la ultima posicion.
encolar :: Persona -> Cola -> Cola
encolar personaN VaciaC = Encolada personaN VaciaC
encolar personaN (Encolada p c) = Encolada p  (encolar personaN c)
--encolar personaN (Encolada p c) = Encolada p  $ encolar personaN c

--3) busca :: Cola -> Cargo -> Maybe Persona, que devuelve el primer docente
--dentro de la cola que tiene un cargo que se corresponde con el segundo parametro.
--Si esa persona no existe, devuelve Nothing.

busca :: Cola -> Cargo -> Maybe Persona
busca (Encolada (Docente cargo1) cola) cargo2| igualCargo cargo1 cargo2 = Just (Docente cargo1)
                                             | otherwise = busca cola cargo2
busca _ _ = Nothing

--b) ¿A que otro tipo se parece Cola?.

 
--6.
data ListaAsoc a b = Vacia | Nodo a b ( ListaAsoc a b ) deriving Show
type Diccionario = ListaAsoc String String
type Padron = ListaAsoc Int String
 
--a) ¿

type GuiaTelefonica = ListaAsoc String Int
telefonica = Nodo "Mili" 123(Nodo "Tomi" 432(Nodo "Chino" 007(Nodo "Nacho" 543 (Nodo "cande" 232 Vacia ))))
telefonica2 = Nodo "Agus" 222(Nodo "Alfred" 111 (Nodo "Cris" 555(Nodo "Adibas" 777 (Nodo "motorola" 666 Vacia ))))
--b) 
--1) Programar la funcion la_long :: ListaAsoc a b -> Int
--que devuelve la cantidad de datos en una lista.

la_long :: ListaAsoc a b -> Int 
la_long (Vacia) = 0
la_long (Nodo a b lis)= 1+ la_long lis

--2)la_concat :: ListaAsoc a b -> ListaAsoc a b -> ListaAsoc a b 
--que devuelve la concatenacion de dos listas de asociacion.

la_concat :: ListaAsoc a b -> ListaAsoc a b -> ListaAsoc a b 
la_concat Vacia Vacia = Vacia
la_concat Vacia list2 = list2
la_concat list1 Vacia = list1
la_concat (Nodo a b list1) list2 = Nodo a b (la_concat list1 list2)

--3) la_pares :: ListaAsoc a b -> [(a, b)] 
--que transforma una lista de asociacion en una lista de pares clave-dato.
la_pares :: ListaAsoc a b -> [(a, b)] 
la_pares Vacia = []
la_pares (Nodo a b lista) = (a, b) : la_pares lista
--4) la_busca :: Eq a => ListaAsoc a b -> a -> Maybe b 
--que dada una lista y una clave devuelve el dato asociado, si es que existe.
--En caso contrario devuelve Nothing.
la_busca :: Eq a => ListaAsoc a b -> a -> Maybe b 
la_busca Vacia _ = Nothing
la_busca (Nodo a1 b lista) a2 |a2 == a1 = Just b
                              |a2 /= a1 = la_busca lista a2
                              
--5) la_borrar :: Eq a => a -> ListaAsoc a b -> ListaAsoc a b que dada
--una clave a elimina la entrada en la lista.
la_borrar :: Eq a => a -> ListaAsoc a b -> ListaAsoc a b
la_borrar _ Vacia = Vacia
la_borrar a1 (Nodo a2 b lista)  |a1 /= a2 = (Nodo a2 b) (la_borrar a1 lista)
                                |a1 == a2 = lista 


--7*. 
data Arbol a = Hoja | Rama (Arbol a) a (Arbol a) deriving Show

type Prefijos = Arbol String
can , cana , canario , canas , cant , cantar , canto :: Prefijos
can = Rama cana "can" cant
cana = Rama canario "a" canas
canario = Rama Hoja "rio" Hoja
canas = Rama Hoja "s" Hoja
cant = Rama cantar "t" canto
cantar = Rama Hoja "ar" Hoja
canto = Rama Hoja "o" Hoja

arbolprueba :: Arbol String
arbolprueba = Rama (Rama (Rama Hoja "rio" Hoja) "a" (Rama Hoja "s" Hoja)) "can" (Rama (Rama Hoja"ar" Hoja) "t" (Rama Hoja "o" Hoja)) 
arbolPruebanNum :: Arbol Int
arbolPruebanNum = Rama (Rama (Rama Hoja 7 Hoja) 8 (Rama Hoja 9 Hoja)) 1 (Rama (Rama Hoja 2 Hoja) 3 (Rama Hoja 4 Hoja))
--Programa las siguientes funciones:
--a) a_long :: Arbol a -> Int que dado un arbol devuelve la cantidad de datos almacenados.

a_long :: Arbol a -> Int
a_long Hoja = 0
a_long (Rama x a y) = 1 + a_long x + a_long y

--b) a_hojas :: Arbol a -> Int que dado un arbol devuelve la cantidad de hojas.
a_hojas :: Arbol a -> Int
a_hojas Hoja = 1 
a_hojas (Rama x a y) = a_hojas x + a_hojas y

--c) a_inc :: Num a => Arbol a -> Arbol a que dado un arbol que contiene numeros,
--los incrementa en uno.

a_inc :: Num a => Arbol a -> Arbol a
a_inc Hoja = Hoja
a_inc (Rama x a y) = Rama (a_inc x) (a+1) (a_inc y)

--d) a_map :: (a -> b) -> Arbol a -> Arbol b que dada una funcion y un arbol,
--devuele el arbol con la misma estructura, que resulta de aplicar la funcion a cada uno
--de los elementos del arbol. Revisa la defincion de la funcion anterior y reprogramala
--usando a_map. 

a_map :: (a -> b) -> Arbol a -> Arbol b
a_map f Hoja = Hoja
a_map f (Rama x a y) = Rama (a_map f x) (f a) (a_map f y) 


estaEnDNI :: Int -> Bool
estaEnDNI x = (x == 4) || (x == 8) || (x == 0) || (x == 5) || (x == 2)

cuentaDNI :: [Int] -> Int 
cuentaDNI [] = 0
cuentaDNI (x:xs) | estaEnDNI x = 1 + cuentaDNI xs
                 | otherwise = 0 + cuentaDNI xs
                 
cuentaNoDNI :: [Int] -> Int 
cuentaNoDNI [] = 0
cuentaNoDNI (x:xs) | estaEnDNI x = cuentaNoDNI xs
                   | otherwise = 1 + cuentaNoDNI xs
-}
