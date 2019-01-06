module Day1 where

import Control.Monad (join)
import Data.Monoid   (mappend, Sum(..), getSum)

import qualified Data.Set as Set

toNum :: String -> Integer
toNum str@(s:ss) = if s == '+' then read ss else read str

calibrate :: String -> Integer
calibrate = getSum
          . foldMap (Sum . toNum)
          . lines

buildSequence :: String -> [Integer]
buildSequence = scanl (+) 0
           . join
           . repeat
           . fmap toNum
           . lines

findRep :: String -> Maybe Integer
findRep xs = go (buildSequence xs) (Set.fromList [])
    where
        go :: [Integer] -> Set.Set Integer -> Maybe Integer
        go [] _     = Nothing
        go (x:xs) s = if x `Set.member` s 
                         then Just x 
                         else go xs (Set.insert x s)

solvePart1 :: FilePath -> IO Integer
solvePart1 file = calibrate <$> readFile file

solvePart2 :: FilePath -> IO (Maybe Integer)
solvePart2 file = findRep <$> readFile file
