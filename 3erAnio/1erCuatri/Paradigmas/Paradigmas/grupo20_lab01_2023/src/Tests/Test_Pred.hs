module Tests.Test_Pred where

import Dibujo (Dibujo, apilar, encimar, figura, r180, rotar90)
import Pred (allDib, andP, anyDib, cambiar, orP)

type Basica = ()

ejemplo :: Dibujo Basica
ejemplo = figura ()

test_cambiar_ok :: IO ()
test_cambiar_ok = do
  let expected = rotar90 (figura ejemplo)
  let actual = cambiar (== figura ()) (\_ -> rotar90 (figura ejemplo)) (figura ejemplo)
  if actual == expected
    then putStrLn "cambiar OK"
    else putStrLn $ "cambiar test failed: expected " ++ show expected ++ ", but got " ++ show actual

test_anyDib_ok :: IO ()
test_anyDib_ok = do
  let expected = True
  let actual = anyDib (== figura ()) (rotar90 (rotar90 (figura ejemplo)))
  if actual == expected
    then putStrLn "anyDib OK"
    else putStrLn $ "aniDib test failed: expected " ++ show expected ++ ", but got " ++ show actual

test_allDib_ok :: IO ()
test_allDib_ok = do
  let expected = True
  let actual = anyDib (== figura ()) (rotar90 (figura ejemplo))
  if actual == expected
    then putStrLn "allDib OK"
    else putStrLn $ "allDib test failed: expected " ++ show expected ++ ", but got " ++ show actual

test_orP_ok :: IO ()
test_orP_ok = do
  let expected = True
  let actual = orP (== rotar90 ejemplo) (== ejemplo) (rotar90 ejemplo)
  if actual
    then putStrLn "orP OK"
    else putStrLn $ "orP test failed: expected " ++ show expected ++ ", but got " ++ show actual

test_andP_ok :: IO ()
test_andP_ok = do
  let expected = False
  let actual = andP (== rotar90 ejemplo) (== rotar90 ejemplo) (rotar90 ejemplo)
  if actual
    then putStrLn "andP OK"
    else putStrLn $ "andP test failed: expected " ++ show expected ++ ", but got " ++ show actual

test_anyDib_wrong :: IO ()
test_anyDib_wrong = do
  let expected = False
  let actual = anyDib (== (r180 $ figura ())) (rotar90 (rotar90 (figura ejemplo)))
  if actual == expected
    then putStrLn "wrong anyDib OK"
    else putStrLn $ "anyDib test failed: expected " ++ show expected ++ ", but got " ++ show actual

test_allDib_wrong :: IO ()
test_allDib_wrong = do
  let expected = False
  let actual = anyDib (== (r180 $ figura ())) (rotar90 (figura ejemplo))
  if actual == expected
    then putStrLn "wrong allDib OK"
    else putStrLn $ "wrong allDib test failed: expected " ++ show expected ++ ", but got " ++ show actual

test_orP_wrong :: IO ()
test_orP_wrong = do
  let expected = False
  let actual = orP (== r180 ejemplo) (== ejemplo) (rotar90 ejemplo)
  if actual == expected
    then putStrLn "wrong orP OK"
    else putStrLn $ "wrong orP test failed: expected " ++ show expected ++ ", but got " ++ show actual

test_andP_wrong :: IO ()
test_andP_wrong = do
  let expected = False
  let actual = andP (== rotar90 ejemplo) (== rotar90 ejemplo) ejemplo
  if actual == expected
    then putStrLn "wrong andP OK"
    else putStrLn $ "wrong andP test failed: expected " ++ show expected ++ ", but got " ++ show actual