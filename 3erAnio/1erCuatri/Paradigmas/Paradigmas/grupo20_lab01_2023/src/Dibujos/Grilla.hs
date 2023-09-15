module Dibujos.Grilla
  ( interpBas,
    grillaNumConf,
  )
where

import Data.List.NonEmpty (some1)
import Dibujo (Dibujo, figura)
import FloatingPic (FloatingPic, Output, half, zero)
import Graphics.Gloss (Picture (Pictures), line, pictures, polygon, scale, text, translate, white)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Graphics.Gloss.Interface.Environment (getScreenSize)
import Interp (Conf (..), interp)

type GrillaNum = ()

gridNum :: Dibujo GrillaNum
gridNum = figura ()

cuadrado :: FloatingPic
cuadrado a b c = line [a, a V.+ c, a V.+ b V.+ c, a V.+ b, a]

interpBas :: Output GrillaNum
interpBas () a b c = pictures [cuadradoGrilla a b c]
  where
    fontsize = fst b * 0.00022
    s1 = "(0,0)"
    cuadradoGrilla a b c = pictures [cuadrado a b c, numeritos (fst b) (snd c)]
      where
        --myaux :: Float -> Float -> Integer -> Integer -> Picture
        myaux x y a b =
          translate ((x * a / 8) + x * 0.027) ((y * b / 8) + x * 0.055) $
            scale fontsize fontsize $
              text $ show (round (7 - b), round a)
        numeritos x y =
          pictures $
            [myaux x y a b | a <- [0 .. 7], b <- [0 .. 7]]

grillaNumConf :: Conf
grillaNumConf =
  Conf
    { name = "Grilla",
      pic = interp interpBas gridNum
    }
