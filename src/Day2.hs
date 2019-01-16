module Day2 where

import Data.Bifunctor (bimap)
import Control.Arrow ((&&&))
import Data.List (group, sort)

filterByLength n = filter ((==n) . length)

getOccurrences :: String -> (Int, Int)
getOccurrences = bimap (min 1 . length) (min 1 . length)
               . (filterByLength 2 &&& filterByLength 3)
               . group
               . sort

calcChecksum :: String -> Int
calcChecksum = uncurry (*)
             . ((sum . map fst) &&& (sum . map snd))
             . fmap getOccurrences
             . lines

solvePart1 :: FilePath -> IO Int
solvePart1 file = calcChecksum <$> readFile file
