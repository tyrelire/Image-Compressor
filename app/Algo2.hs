{--
-- EPITECH PROJECT, 2024
-- Algo2.hs
-- File description:
-- Algo2.hs
--}

module Algo2 (parseVectorImage, extractRGB, sameRBG, searchPoint) where

searchPoint :: [[Int]] -> Int -> Int -> [Int]
searchPoint [] _ _ = error "Index out of bounds"
searchPoint (x:xs) pos cpt
  | cpt < pos = searchPoint xs pos (cpt + 1)
  | cpt > pos = error "Index out of bounds"
  | otherwise = x

extractRGB :: [Int] -> [Int]
extractRGB (_:_:r:g:b:_) = [r, g, b]

sameRBG :: [[Int]] -> [Int] -> Bool
sameRBG clusterCenter target = (extractRGB target) `elem`
    map extractRGB clusterCenter

parseVectorImage :: String -> [[Int]]
parseVectorImage s = map parseOneVector (lines s)
  where
    parseOneVector str = map read (words (replaceComma (removeParenthese str)))
    replaceComma str = map replaceCommaWithSpace str
    replaceCommaWithSpace c = if c == ',' then ' ' else c
    removeParenthese str = filter isNotParenthese str
    isNotParenthese c = c /= '(' && c /= ')'
