module Tests.Test_Dibujo where

import Dibujo (Dibujo, apilar, comp, cuarteto, encimar, espejar, figura, foldDib, juntar, mapDib, r180, rot45, rotar90, (.-.), (///), (^^^))
import FloatingPic (Output, half, zero)
import Graphics.Gloss (Picture, blue, color, line, pictures, polygon, red, text, white)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Interp (Conf (..), apilarPic, basica, encimarPic, espejarPic, interp, juntarPic, rot45Pic, rotar90Pic)

type Basica = ()

ejemplo :: Dibujo Basica
ejemplo = figura ()

ejemploFold :: Dibujo Basica
ejemploFold = rot45 (rotar90 (espejar (figura ())))

ejemploMap :: Dibujo Basica
ejemploMap = rot45 (rotar90 (espejar (figura ())))

test_comp_ok :: IO ()
test_comp_ok = do
  let expected = r180 (figura ejemplo)
  let actual = comp rotar90 2 (figura ejemplo)
  if actual == expected
    then putStrLn "comp OK"
    else putStrLn $ "comp test failed: expected " ++ show expected ++ ", but got " ++ show actual

test_shared_apilar_ok :: IO ()
test_shared_apilar_ok = do
  let expected = apilar 1 1 (figura ejemplo) (figura ejemplo)
  let actual = (.-.) (figura ejemplo) (figura ejemplo)
  if actual == expected
    then putStrLn "apilar OK"
    else putStrLn $ "cuarteto test failed: expected " ++ show expected ++ ", but got " ++ show actual

test_cuarteto_ok :: IO ()
test_cuarteto_ok = do
  let expected = (.-.) ((///) (figura ejemplo) (figura ejemplo)) ((///) (figura ejemplo) (figura ejemplo))
  let actual = cuarteto (figura ejemplo) (figura ejemplo) (figura ejemplo) (figura ejemplo)
  if actual == expected
    then putStrLn "cuarteto OK"
    else putStrLn $ "cuarteto test failed: expected " ++ show expected ++ ", but got " ++ show actual

test_superponer_ok :: IO ()
test_superponer_ok = do
  let expected = encimar (figura ejemplo) (figura ejemplo)
  let actual = (^^^) (figura ejemplo) (figura ejemplo)
  if actual == expected
    then putStrLn "^^^ OK"
    else putStrLn $ "superponer test failed: expected " ++ show expected ++ ", but got " ++ show actual

test_foldDib_wrong :: IO ()
test_foldDib_wrong = do
  let expected = ejemploFold
  let actual = foldDib figura espejar rot45 rotar90 apilar juntar encimar ejemploFold
  if actual == expected
    then putStrLn $ "foldDib test failed: expected " ++ show expected ++ ", but got " ++ show actual
    else putStrLn "foldDib OK"

test_mapDib_ok :: IO ()
test_mapDib_ok = do
  let expected = rotar90 (espejar (figura ()))
  let actual = mapDib rotar90 (figura (espejar (figura ())))
  if actual == expected
    then putStrLn "mapDib OK"
    else putStrLn $ "mapDib test failed: expected " ++ show expected ++ ", but got " ++ show actual