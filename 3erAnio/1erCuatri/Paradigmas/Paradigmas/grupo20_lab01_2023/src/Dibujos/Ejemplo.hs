module Dibujos.Ejemplo
  ( interpBas,
    ejemploConf,
  )
where

import Dibujo (Dibujo, encimar, espejar, figura, r180, r270, rot45, rotar90)
import FloatingPic (Output, half, zero)
import Graphics.Gloss (line, pictures, polygon, text, white)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Interp (Conf (..), interp)

type Basica = ()

ejemplo :: Dibujo Basica
ejemplo = encimar (rotar90 (figura ())) (figura ())

--como es output y de donde vine a b c
interpBas :: Output Basica
interpBas () a b c = pictures [escher a b c]
  where
    triangulo a b c = polygon $ map (half (half a) V.+) [zero, c, b, zero]
    triangulo1 a b c = polygon $ map (half (half a) V.+) [zero, b V.+ c, b, zero]
    triangulo2 a b c = polygon $ map (half (half a) V.+) [zero, half b V.+ c, b, zero]
    cuadrado a b c = line [a, a V.+ c, a V.+ b V.+ c, a V.+ b, a]
    escher a b c = pictures [triangulo a b c, triangulo1 a b c, triangulo2 a b c]

ejemploConf :: Conf
ejemploConf =
  Conf
    { name = "Ejemplo",
      pic = interp interpBas ejemplo
    }
