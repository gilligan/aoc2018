module Day2 where

import Data.Bifunctor (bimap)
import Control.Arrow ((&&&))
import Data.Monoid (Sum(..))
import Data.List (group, sort, find)

--- Part One

ofLength n = filter ((==n) . length)

toNum x = if x then 1 else 0
sumUp (f, s) (x, y) = (x + toNum f, y + toNum s)

getOccurrences :: String -> (Bool, Bool)
getOccurrences = bimap (not . null) (not . null)
               . (ofLength 2 &&& ofLength 3)
               . group
               . sort


calcChecksum :: String -> Int
calcChecksum = uncurry (*)
             . foldr sumUp (0,0)
             . fmap getOccurrences
             . lines

solvePart1 :: FilePath -> IO Int
solvePart1 file = calcChecksum <$> readFile file

--- Part Two

getCombinations :: [b] -> [(b, b)]
getCombinations xs = [(x,y) | x <- xs, y <- xs]

dropEq :: String -> String -> String
dropEq [] _ = []
dropEq (x:xs) (y:ys) = if x == y then x : dropEq xs ys else dropEq xs ys

strDist :: String -> String -> Int
strDist [] _ = 0
strDist (x:xs) (y:ys) = if x == y then strDist xs ys else 1 + strDist xs ys

findPair :: String -> Maybe String 
findPair = fmap (uncurry dropEq)
         . find ((==1) . uncurry strDist)
         . getCombinations
         . lines

solvePart2 :: FilePath -> IO (Maybe String)
solvePart2 file = findPair <$> readFile file
