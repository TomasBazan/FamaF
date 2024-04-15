--1)
--a)
data Carrera = Matematica | Astronomia | Fisica | Computacion deriving (Eq,Ord,Show)
--b)
titulo :: Carrera -> String
titulo Matematica = "Licenciatura en Matematica"
titulo Astronomia = "Licenciatura en Astronomia"
titulo Fisica = "Licenciatura en Fisica"
titulo Computacion = "Licenciatura en Ciencias de la Computacion"
--2)
--a)aplicar a Carrera Eq, Ord y Show para poder decidir min y <=
--3)
--a)
type Ingreso = Int
data Cargo = Titular | Asociado | Adjunto | Asistente | Auxiliar deriving (Eq,Show)
data Area = Administrativa | Ensenanza | Economica | Postgrado  deriving (Eq,Show)

data Persona = Decane | Docente Cargo | NoDocente Area | Estudiante Carrera Ingreso deriving (Eq,Show)
--la clase Show la traigo para ejercicios posteriores (5)
--b) El tipo del Constructor Docente es de tipo Persona y recibe un parametro de tipo Cargo
--c)
cuantos_doc :: [Persona] -> Cargo -> Int
cuantos_doc [] _ = 0
cuantos_doc ((Docente c):ps) cargo | c == cargo = 1 + cuantos_doc ps cargo
                                   | c /=cargo = cuantos_doc ps cargo
cuantos_doc(_:ps) cargo = cuantos_doc ps cargo
--d)
cuantos_doc' :: [Persona] -> Cargo -> Int
cuantos_doc' [] _ = 0  
cuantos_doc' ps cargo = length (filter (== Docente cargo) ps)
--4)
--a)
primerElemento :: [a] -> Maybe a
primerElemento [] = Nothing
primerElemento (x:_) = Just x
--5)
data Cola = VaciaC | Encola Persona Cola deriving (Show)
--a1)
--Lista de cola: (Encola Decane VaciaC)
--Lista de cola: (Encola (Docente Titular) VaciaC)
--Lista de cola:
colaDePersonas = (Encola Decane (Encola (Docente Titular)(Encola (NoDocente Administrativa) (Encola (Docente Auxiliar) VaciaC))))
atender :: Cola -> Maybe Cola
atender VaciaC = Nothing
atender (Encola _ cola) = Just cola
--a2)
encolar :: Persona -> Cola -> Cola
encolar persona VaciaC = Encola persona VaciaC
encolar persona (Encola p cola) = Encola p (encolar persona cola )
--a3)
busca :: Cola -> Cargo -> Maybe Persona
busca VaciaC _ = Nothing
busca (Encola persona cola) cargo | persona == Docente cargo = Just (Docente cargo)
                                  |otherwise = busca cola cargo
--b)listas ponele
--6)
data ListaAsoc a b = Vacia | Nodo a b (ListaAsoc a b) deriving (Show)
--a)
type GuiaTelefonica = ListaAsoc String Int
--b)
--b.1)
--Lista de Asociaciones de Prueba:
listaDeTelefonos1 = Nodo "Mauricio" 666 (Nodo "Juan" 124(Nodo "Tomas" 123 Vacia))
listaDeTelefonos2 = Nodo "Ruben" 412 (Nodo "Cristina" 5343(Nodo "Joaquin" 2212 Vacia))

la_long :: ListaAsoc a b -> Int
la_long Vacia = 0
la_long (Nodo _ _ lista) = 1 + la_long lista
--b.2)
la_concat :: ListaAsoc a b -> ListaAsoc a b -> ListaAsoc a b
la_concat Vacia l2 = l2
la_concat l1 Vacia = l1
la_concat (Nodo a b lista) l2 = Nodo a b (la_concat lista l2)
--b.3)
la_pares :: ListaAsoc a b -> [(a, b)]
la_pares Vacia = []
la_pares (Nodo a b lista) = (a,b) : la_pares lista
--b.4)
la_busca :: Eq a => ListaAsoc a b -> a -> Maybe b
la_busca Vacia _ = Nothing
la_busca (Nodo a b lista) a' | a == a' = Just b
                             | a /= a' = la_busca lista a'
la_busca (Nodo _ _ _ ) _ = Nothing
--b.5)
la_borrar :: Eq a => a -> ListaAsoc a b -> ListaAsoc a b
la_borrar _ Vacia = Vacia
la_borrar a' (Nodo a b lista) | a' /= a = Nodo a b (la_borrar a' lista)
                              | a' == a = lista
la_borrar _ (Nodo _ _ _) = Vacia
--7)
data Arbol a = Hoja | Rama( Arbol a) a (Arbol a) deriving (Show)
--Lista de Prueba de Arbol binario:
--arbolTest1 == can
--             /   \
--            a     t
--           /  \   / \
--         rio  s  ar  o
arbolTest :: Arbol String
arbolTest = Rama (Rama(Rama(Hoja)"rio"(Hoja))"a"(Rama(Hoja)"s"(Hoja))) "can" (Rama(Rama(Hoja)"ar"(Hoja))"t"(Rama(Hoja)"o"(Hoja)))
arbolTestNum :: Arbol Int
arbolTestNum = Rama(Rama(Rama(Hoja)1(Hoja))3(Rama(Hoja)4(Hoja))) 5 (Rama(Rama(Hoja)6(Hoja))8(Rama(Hoja)9(Hoja)))
--a)
a_long :: Arbol a -> Int
a_long Hoja = 0
a_long (Rama x1 _ x2) = 1 + a_long x1 + a_long x2
--b)
a_hojas :: Arbol a -> Int
a_hojas Hoja = 1
a_hojas (Rama x1 _ x2) = a_hojas x1 + a_hojas x2
--c)
a_inc :: Num a => Arbol a -> Arbol a
a_inc Hoja = Hoja
a_inc (Rama x1 x x2) = (Rama(a_inc x1) (x+1) (a_inc x2))
--d)
a_map :: (a -> b) -> Arbol a -> Arbol b
a_map _ Hoja = Hoja
a_map t (Rama x1 x x2) = Rama(a_map t x1) (t x) (a_map t x2)

a_inc' :: Num a => Arbol a -> Arbol a
a_inc' x = a_map (+1) x