{--
-- EPITECH PROJECT, 2024
-- Calcul.hs
-- File description:
-- Calcul.hs
--}

module Calcul (execFormule, updateBlueValue, updateGreenValue
    , updateRedValue, findClusterCenter) where

execFormule :: [Int] -> [Int] -> Float
execFormule first second = sqrt $ r ** 2 + g ** 2 + b ** 2
    where
        r = fromIntegral (first !! 2 - second !! 2)
        g = fromIntegral (first !! 3 - second !! 3)
        b = fromIntegral (first !! 4 - second !! 4)

updateValue :: Int -> [[Int]] -> [Int] -> Int -> Int -> Int
updateValue pos points indices res index = tmp pos points indices res index
    where
        tmp _ [] _ value _ = value
        tmp _ _ [] value _ = value
        tmp posTmp (x:xs) (y:ys) value index
            | y == posTmp = tmp posTmp xs ys (value + (x !! index)) index
            | otherwise = tmp posTmp xs ys value index

updateRedValue :: Int -> [[Int]] -> [Int] -> Int -> Int
updateRedValue pos points indices res = updateValue pos points indices res 2

updateGreenValue :: Int -> [[Int]] -> [Int] -> Int -> Int
updateGreenValue pos points indices res = updateValue pos points indices res 3

updateBlueValue :: Int -> [[Int]] -> [Int] -> Int -> Int
updateBlueValue pos points indices res = updateValue pos points indices res 4

calculateColor :: Int -> [[Int]] -> [Int] -> Int -> Int
calculateColor n points index colorIndex =
    let cpt = countIndex index n
        color = updateColorValue colorIndex n points index 0
    in color `div` cpt

findClusterCenter :: [[Int]] -> [[Int]] -> [Int] -> Int -> [[Int]]
findClusterCenter [] _ _ _ = []
findClusterCenter (x:xs) points index n =
    newClusterCenter : findClusterCenter xs points index (n + 1)
    where
        r = calculateColor n points index 0
        g = calculateColor n points index 1
        b = calculateColor n points index 2
        newClusterCenter = [0, 0, r, g, b]

updateColorValue :: Int -> Int -> [[Int]] -> [Int] -> Int -> Int
updateColorValue colorIndex = case colorIndex of
    0 -> updateRedValue
    1 -> updateGreenValue
    2 -> updateBlueValue

countIndex :: [Int] -> Int -> Int
countIndex xs n = cpt xs
    where
        cpt [] = 0
        cpt (x:rest) = (if x == n then 1 else 0) + cpt rest
