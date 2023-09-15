module Dibujos.Escher
  ( escherConf,
    interpEscher,
    escher,
  )
where

import Dibujo (Dibujo, apilar, ciclar, cuarteto, encimar, encimar4, espejar, figura, juntar, r180, r270, rot45, rotar90, (.-.), (///), (^^^))
import FloatingPic (FloatingPic, Output, half, zero)
import Graphics.Gloss (Picture (Text), blank, dark, line, pictures, polygon, scale, text, white)
import Graphics.Gloss.Data.Picture (Picture)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Interp (Conf (..), apilarPic, encimarPic, espejarPic, interp, juntarPic, rot45Pic, rotar90Pic)

data Basica
  = TrianguloRectangulo
  | TrianguloConNegrito
  | TrianguloEscaleno
  | Cuadrado
  | Vacio
  | L

type Escher = Basica

-- w: alto y y: ancho
interpEscher :: Output Basica
interpEscher TrianguloRectangulo x y w = line $ map (x V.+) [zero, w, y, zero] -- forma del triangulo : |\
interpEscher TrianguloConNegrito x y w = pictures [otro, otro1] -- triangulo rectangulo con un triangulo equilatero negro dentro
  where
    otro = polygon $ map (x V.+) [half y, half y V.+ half (half y) V.+ half (half w), y]
    otro1 = line $ map (x V.+) [zero, w, y, zero]
interpEscher TrianguloEscaleno x y w = line $ map (x V.+) [zero, half (half y) V.+ w, y, zero] -- forma del triangulo : |\ (pero el primer pike torcido a la derecha)
interpEscher Cuadrado x y w = line $ map (x V.+) [zero, w, w V.+ y, y, zero]
interpEscher Vacio x y w = blank -- hoja en blanco
interpEscher L x y w =
  line $
    map (x V.+ ((1 / 8) V.* y) V.+ ((1 / 8) V.* w) V.+) $
      [ zero,
        x4,
        x4 V.+ uY,
        uX V.+ uY,
        uX V.+ 6 V.* uY,
        6 V.* uY,
        zero
      ]
  where
    x4 = 3 V.* uX
    uX = (1 / 8) V.* y
    uY = (1 / 8) V.* w

figuraT :: Dibujo Basica -> Dibujo Basica
figuraT f = encimar f (encimar f2 f3)
  where
    f2 = espejar (rot45 f)
    f3 = r270 f2

figuraU :: Dibujo Basica -> Dibujo Basica
figuraU f =
  encimar
    (encimar f2 (rotar90 f2))
    (encimar (r180 f2) (r270 f2))
  where
    f2 = espejar (rot45 f)

lado :: Int -> Basica -> Dibujo Basica
lado n f
  | n == 1 = cuarteto (figura Vacio) (figura Vacio) (rotar90 (figuraT (figura f))) (figuraT (figura f))
  | n > 1 = cuarteto (lado (n -1) f) (lado (n -1) f) (rotar90 (figuraT (figura f))) (figuraT (figura f))

esquina :: Int -> Basica -> Dibujo Basica
esquina n f
  | n == 1 = cuarteto (figura Vacio) (figura Vacio) (figura Vacio) (figuraU (figura f))
  | n > 1 = cuarteto (esquina (n -1) f) (lado (n -1) f) (rotar90 (lado (n -1) f)) (figuraU (figura f))

noneto p q r s t u v w x =
  apilar
    1
    2
    (juntar 1 2 p (juntar 1 1 q r))
    ( apilar
        1
        1
        (juntar 1 2 s (juntar 1 1 t u))
        (juntar 1 2 v (juntar 1 1 w x))
    )

escher :: Int -> Basica -> Dibujo Basica
escher n f =
  noneto
    (esquina n f)
    (lado n f)
    (r270 (esquina n f))
    (rotar90 (lado n f))
    (figuraU (figura f))
    (r270 (lado n f))
    (rotar90 (esquina n f))
    (r180 (lado n f))
    (r180 (esquina n f))

escherConf :: Conf
escherConf =
  Conf
    { name = "Escher",
      pic = interp interpEscher (escher 10 TrianguloConNegrito)
    }
