module Dibujo
  ( Dibujo,
    figura,
    rotar90,
    espejar,
    rot45,
    apilar,
    juntar,
    encimar,
    r180,
    r270,
    (.-.),
    (///),
    (^^^),
    cuarteto,
    encimar4,
    ciclar,
    foldDib,
    mapDib,
    figuras,
    comp,
  )
where

{-
Gramática de las figuras:
<Fig> ::= Figura <Bas> | Rotar <Fig> | Espejar <Fig> | Rot45 <Fig>
    | Apilar <Float> <Float> <Fig> <Fig>
    | Juntar <Float> <Float> <Fig> <Fig>
    | Encimar <Fig> <Fig>
-}

data Dibujo base_dibujo
  = Figura base_dibujo
  | Rotar90 (Dibujo base_dibujo)
  | Espejar (Dibujo base_dibujo)
  | Rot45 (Dibujo base_dibujo)
  | Apilar Float Float (Dibujo base_dibujo) (Dibujo base_dibujo)
  | Juntar Float Float (Dibujo base_dibujo) (Dibujo base_dibujo)
  | Encimar (Dibujo base_dibujo) (Dibujo base_dibujo)
  deriving (Eq, Show)

-- Construcción de dibujo. Abstraen los constructores.
espejar :: Dibujo base_dibujo -> Dibujo base_dibujo
espejar = Espejar

-- rotar90
rotar90 :: Dibujo base_dibujo -> Dibujo base_dibujo
rotar90 = Rotar90

-- rot45
rot45 :: Dibujo base_dibujo -> Dibujo base_dibujo
rot45 = Rot45

-- Apilar
apilar :: Float -> Float -> Dibujo base_dibujo -> Dibujo base_dibujo -> Dibujo base_dibujo
apilar = Apilar

-- Juntar
juntar :: Float -> Float -> Dibujo base_dibujo -> Dibujo base_dibujo -> Dibujo base_dibujo
juntar = Juntar

-- Encimar
encimar :: Dibujo base_dibujo -> Dibujo base_dibujo -> Dibujo base_dibujo
encimar = Encimar

-- Composición n-veces de una función con sí misma. Componer 0 veces
-- es la función constante, componer 1 vez es aplicar la función 1 vez, etc.
-- Componer negativamente es un error!
comp :: (a -> a) -> Int -> a -> a
comp f 0 d = d
comp f 1 d = f d
comp f n d = f $ comp f (n -1) d

r180 :: Dibujo base_dibujo -> Dibujo base_dibujo
r180 = comp rotar90 2

r270 :: Dibujo base_dibujo -> Dibujo base_dibujo
r270 = comp rotar90 3

-- Pone una figura sobre la otra, ambas ocupan el mismo espacio. Apilar compartido
(.-.) :: Dibujo base_dibujo -> Dibujo base_dibujo -> Dibujo base_dibujo
(.-.) = apilar 1 1

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio. Encimar Compartido
(///) :: Dibujo base_dibujo -> Dibujo base_dibujo -> Dibujo base_dibujo
(///) = juntar 1 1

-- Superpone una figura con otra.
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) = encimar

-- Dadas cuatro figuras las ubica en los cuatro cuadrantes.
cuarteto :: Dibujo base_dibujo -> Dibujo base_dibujo -> Dibujo base_dibujo -> Dibujo base_dibujo -> Dibujo base_dibujo
cuarteto a b c d = (.-.) ((///) a b) ((///) c d)

-- Una figura repetida con las cuatro rotaciones, superpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 a = (^^^) ((^^^) a $ rotar90 a) ((^^^) (r180 a) (r270 a))

-- Cuadrado con la misma figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
ciclar a = (///) ((.-.) a $ rotar90 a) ((.-.) (r270 a) (r180 a))

figura :: base_dibujo -> Dibujo base_dibujo
figura = Figura

-- Demostrar que `mapDib figura = id`
mapDib :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
mapDib f construct = case construct of
  (Figura a) -> f a
  Espejar a -> Espejar (mapDib f a)
  Rotar90 a -> Rotar90 (mapDib f a)
  Rot45 a -> Rot45 (mapDib f a)
  Apilar x y a b -> Apilar x y (mapDib f a) (mapDib f b)
  Juntar x y a b -> Juntar x y (mapDib f a) (mapDib f b)
  Encimar a b -> Encimar (mapDib f a) (mapDib f b)

-- Estructura general para la semántica (a no asustarse). Ayuda:
-- pensar en foldr y las definiciones de Floatro a la lógica
foldDib ::
  (a -> b) -> -- Dibujo de figura
  (b -> b) -> -- espejar
  (b -> b) -> -- rotar90
  (b -> b) -> --  rotar45
  (Float -> Float -> b -> b -> b) -> -- apilar
  (Float -> Float -> b -> b -> b) -> -- juntar
  (b -> b -> b) -> -- encimar
  Dibujo a -> -- figura (caso base)
  b
foldDib fig esp rot90 rot45 apil junt encim construct = case construct of
  (Figura a) -> fig a
  (Espejar a) -> esp (foldDib fig esp rot90 rot45 apil junt encim a)
  (Rotar90 a) -> rot90 (foldDib fig esp rot90 rot45 apil junt encim a)
  (Rot45 a) -> rot45 (foldDib fig esp rot90 rot45 apil junt encim a)
  (Apilar fl1 fl2 a b) -> apil fl1 fl2 (foldDib fig esp rot90 rot45 apil junt encim a) (foldDib fig esp rot90 rot45 apil junt encim b)
  (Juntar fl1 fl2 a b) -> junt fl1 fl2 (foldDib fig esp rot90 rot45 apil junt encim a) (foldDib fig esp rot90 rot45 apil junt encim b)
  (Encimar a b) -> encim (foldDib fig esp rot90 rot45 apil junt encim a) (foldDib fig esp rot90 rot45 apil junt encim b)

-- Junta todas las figuras básicas de un dibujo.
figuras :: Dibujo a -> [a]
figuras construct = case construct of
  (Figura a) -> [a]
  (Espejar a) -> figuras a
  (Rotar90 a) -> figuras a
  (Rot45 a) -> figuras a
  (Apilar x y a b) -> figuras a ++ figuras b
  (Juntar x y a b) -> figuras a ++ figuras b
  (Encimar a b) -> figuras a ++ figuras b