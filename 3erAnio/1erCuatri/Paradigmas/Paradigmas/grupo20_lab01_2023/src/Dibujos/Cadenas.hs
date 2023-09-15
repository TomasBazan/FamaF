{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant bracket" #-}
module Dibujos.Cadenas
  ( cadenasBas,
    cadenasConf,
  )
where

import Dibujo (Dibujo, (.-.), ciclar, cuarteto, encimar, encimar4, espejar, figura, r180, r270, rot45, rotar90, juntar)
import FloatingPic (Output, half, zero)
import Graphics.Gloss (line, pictures, polygon, white,text, scale)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Interp (Conf (..), interp)
import Graphics.Gloss.Data.Picture (Picture)
type Basica = ()

cadenasBas :: Output Basica
cadenasBas () a b c = pictures [escher a b c]
  where
      triangulo a b c = line $ map (a V.+) [zero, b, c, zero]
      
      triangulo1 a b c =  polygon $ map (a V.+) [zero, b, 0.5 V.* c, zero]
      escher a b c = pictures [triangulo1 a b c]

patron :: Float -> Dibujo Basica
patron n

  | n <= 0 = figura ()
  | otherwise = ciclar (encimar (r270 $ patron (n-1)) ((rotar90 $ patron (n-1))))

         
patronCadenas :: Dibujo Basica
patronCadenas = patron 5


cadenasConf :: Conf
cadenasConf =
  Conf
    { name = "Cadenas",
      pic = interp cadenasBas patronCadenas
    }


