module Main (main) where

import Data.Maybe (fromMaybe)
import Dibujos.Cadenas (cadenasConf)
import Dibujos.Ejemplo (ejemploConf)
import Dibujos.Escher (escherConf)
import Dibujos.Feo (feoConf)
import Dibujos.Grilla (grillaNumConf)
import Distribution.Compat.Newtype (pack')
import Interp (Conf (name), initial)
import System.Console.GetOpt (ArgDescr (..), ArgOrder (..), OptDescr (..), getOpt)
import System.Environment (getArgs)
import Text.Read (readMaybe)
import Text.XHtml (selected)

-- Lista de configuraciones de los dibujos
configs :: [Conf]
configs = [ejemploConf, grillaNumConf, feoConf, escherConf, cadenasConf]

-- Dibuja el dibujo n
initial' :: [Conf] -> String -> IO ()
initial' [] n = do
  putStrLn $ "No hay un dibujo llamado " ++ n
initial' (win_name : cs) n =
  if n == name win_name
    then -- create a windows with size 900x900 and name "c"
      initial win_name 900
    else initial' cs n

main :: IO ()
main = do
  args <- getArgs --desde STDIN
  if head args == "--listar"
    then do
      putStrLn $ unlines $ map name configs
      putStrLn "¿que configuracion desea elegir?"
      selected <- getLine
      initial' configs selected
    else initial' configs $ head args
