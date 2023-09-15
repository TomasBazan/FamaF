module Interp
  ( interp,
    Conf (..),
    interpConf,
    initial,
    basica,
    espejarPic,
    rotar90Pic,
    rot45Pic,
    juntarPic,
    apilarPic,
    encimarPic,
  )
where

import Dibujo (Dibujo, apilar, encimar, figura, foldDib, juntar, r180, r270, rot45, rotar90)
import FloatingPic (FloatingPic, Output, grid, half, vacia, zero)
import GHC.IO.Handle.Lock (FileLockingNotSupported)
import Graphics.Gloss (Display (InWindow), Picture, color, display, makeColorI, pictures, translate, white)
import Graphics.Gloss.Data.Picture (Picture, blank, rotate)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Graphics.Gloss.Data.Vector (Vector)
import Language.Haskell.TH (Role)

basica :: FloatingPic -> FloatingPic
basica pic = pic

espejarPic :: FloatingPic -> FloatingPic
espejarPic pic v1 v2 = pic (v1 V.+ v2) (V.negate v2)

rotar90Pic :: FloatingPic -> FloatingPic
rotar90Pic pic v1 v2 v3 = pic (v1 V.+ v2) v3 (V.negate v2)

rot45Pic :: FloatingPic -> FloatingPic
-- If we change half for the second and third vector to .45 the dibujoU stays inside the grid
rot45Pic pic v1 v2 v3 = pic (v1 V.+ half (v2 V.+ v3)) (half (v2 V.+ v3)) (half (v3 V.- v2))

juntarPic :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
juntarPic fl1 fl2 pic1 pic2 v1 v2 v3 = pictures [pic1 v1 v2' v3, pic2 (v1 V.+ v2') (r' V.* v2) v3]
  where
    (r, r', v2') = calcValues fl1 fl2 v2

apilarPic :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
apilarPic fl1 fl2 pic1 pic2 v1 v2 v3 = pictures [pic1 (v1 V.+ v3') v2 (r V.* v3), pic2 v1 v2 v3']
  where
    (r, r', v2') = calcValues fl1 fl2 v2
    v3' = r' V.* v3

calcValues :: Float -> Float -> Vector -> (Float, Float, Vector)
calcValues fl1 fl2 v2 =
  let r = fl1 / (fl1 + fl2)
      r' = fl2 / (fl1 + fl2)
      v2' = r V.* v2
   in (r, r', v2')

-- Modify the vector oen by one

encimarPic :: FloatingPic -> FloatingPic -> FloatingPic
encimarPic f1 f2 x y z = pictures [f1 x y z, f2 x y z]

--basica seria cualquier interpretacion de un figura basica (triangulo, cuadrado, etc)
interp :: Output a -> Output (Dibujo a)
interp basica a = foldDib basica espejarPic rotar90Pic rot45Pic apilarPic juntarPic encimarPic a

-- Configuración de la interpretación
data Conf = Conf
  { name :: String,
    pic :: FloatingPic
  }

interpConf :: Conf -> Float -> Float -> Picture
interpConf (Conf _ p) x y = p (0, 0) (x, 0) (0, y)

initial :: Conf -> Float -> IO ()
initial cfg size = do
  let n = name cfg
      win = InWindow n (ceiling size, ceiling size) (0, 0)
  display win white $ withGrid (interpConf cfg size size) size size
  where
    withGrid p x y = translate (- size / 2) (- size / 2) $ pictures [p, color grey $ grid (ceiling $ size / 10) (0, 0) x 10]
    grey = makeColorI 120 120 120 120