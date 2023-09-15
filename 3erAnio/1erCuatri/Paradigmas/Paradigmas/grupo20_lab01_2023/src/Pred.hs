module Pred
  ( Pred,
    cambiar,
    anyDib,
    allDib,
    orP,
    andP,
  )
where

import Dibujo (Dibujo, figura, figuras, foldDib, mapDib)
import Language.Haskell.TH (unidir)

type Pred a = a -> Bool

-- ejemplo de predicado (== Triangulo)
--data TriORect = Triangulo | Rectangulo deriving (Eq, Show)

-- Dado un predicado sobre figuras básicas,
-- cambiar todas las que satisfacen el predicado
-- por el resultado de llamar a la función indicada por el
-- segundo argumento con dicha figura.
-- Por ejemplo, `cambiar (== Triangulo) (\x -> Rotar (Figura x))` rota
-- todos los triángulos.

cambiar :: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
--          a->Bool
cambiar p f a = mapDib (\x -> if p x then f x else a) a

-- p a == p(a)
--false es neutro de || = false || a equiv a
-- true es neutro de && = true && a equiv a

-- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib p = foldDib p (False ||) (False ||) (False ||) (\_ _ a b -> a || b) (\_ _ a b -> a || b) (||)

-- Todas las básicas satisfacen el predicado.
allDib :: Pred a -> Dibujo a -> Bool
allDib p = foldDib p (True &&) (True &&) (True &&) (\_ _ a b -> a && b) (\_ _ a b -> a && b) (&&)

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> Pred a
andP p1 p2 a = p1 a && p2 a

-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> Pred a
orP p1 p2 a = p1 a || p2 a
