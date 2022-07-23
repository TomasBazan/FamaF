--1)
data LugarALimpiar = Cocina | Habitacion | Comedor | Bano 
type Fiaca = Int

cantidadDeFiaca :: LugarALimpiar -> Fiaca
cantidadDeFiaca Cocina = 3
cantidadDeFiaca Habitacion = 5
cantidadDeFiaca Comedor = 4
cantidadDeFiaca Bano = 1

{- ejemplo de ejecucion
input: cantidadDeFiaca Habitacion
output: 5 
input: cantidadDeFiaca Comedor
output: 4
-}

--2)

data LugarALimpiar1 = Cocina1 | Habitacion1 | Comedor1 | Bano1 deriving (Show, Eq)

data HayQueLimpiar = Ninguna | AgregaTarea LugarALimpiar1 NombrePersona HayQueLimpiar  
type NombrePersona = String

tocaLimpiar :: HayQueLimpiar -> LugarALimpiar1 -> NombrePersona -> Bool 
tocaLimpiar Ninguna _ _ = False
tocaLimpiar (AgregaTarea lugar1 nom1 list) lugar2 nom2      | nom1 == nom2 && lugar1 == lugar2 = True
                                                            |otherwise = False

--input
listaPrueba = (AgregaTarea Habitacion1 "Tomas" (AgregaTarea Habitacion1 "Carlos"( AgregaTarea Bano1 "Juan" Ninguna))) --Habitacion1 "Tomas"
--output: True

listaprueb2 = (Nodo Cocina1 5 (Nodo Habitacion1 5 (Nodo Bano1 4 Vacia)))
--3)
data ListaAsoc a b = Vacia | Nodo a b ( ListaAsoc a b ) deriving (Show, Eq)

type Tiempo = Integer

lugaresIguales Cocina1 Cocina1 = True 
lugaresIguales Habitacion1 Habitacion1 = True 
lugaresIguales Comedor1 Comedor1 = True 
lugaresIguales Bano1 Bano1 = True 
lugaresIguales _ _  = False 

agregarLA :: ListaAsoc LugarALimpiar1 Tiempo -> LugarALimpiar1 -> Tiempo -> ListaAsoc LugarALimpiar1 Tiempo 
{- agregarLA Vacia _ _ = Vacia -}
{- agregarLA (Nodo a1 b1 list) a2 b2 | lugaresIguales a1 a2 = (Nodo a1 b2 list) 
                                  | otherwise = agregarLA list a2 b2

listaPrueba2 = (Nodo Cocina1 30 (Nodo Habitacion1 15( Nodo Bano1 45 Vacia)))
  -}
agregarLA list a2 b2 = Nodo a2 b2 list