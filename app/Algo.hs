{--
-- EPITECH PROJECT, 2024
-- Algo.hs
-- File description:
-- Algo.hs
--}

module Algo (nearPoint, nextNearPoint, sameRBG
    , setClusterCenters, bothClusterCenters
    , verifLimit, startAlgo) where

import Algo2 (searchPoint, extractRGB, sameRBG)
import Print (printCoord, printList, printAllList)
import Lib (exitFailure)
import Calcul (execFormule, updateBlueValue, updateGreenValue
    , updateRedValue, findClusterCenter)

import System.Random (randomRIO, newStdGen, RandomGen, randomR)

calculateDistance :: [Int] -> [Int] -> Float
calculateDistance point1 point2 = execFormule point1 point2

nearRGB :: [[Int]] -> [Int] -> Float -> Int -> Int -> Int
nearRGB [] _ _ temp _ = temp
nearRGB (x:xs) point smallestDistance temp cpt =
    let currentDistance = calculateDistance point x
    in if currentDistance < smallestDistance
        then nearRGB xs point currentDistance cpt (cpt + 1)
        else nearRGB xs point smallestDistance temp (cpt +1)

nearPoint :: [[Int]] -> [Int] -> Int
nearPoint clusterCenter point = nearRGB clusterCenter point 10000.0 0 0

nextNearPoint :: [[Int]] -> [[Int]] -> [Int]
nextNearPoint _ [] = []
nextNearPoint clusterCenter (x:xs) =
    let closestPoint = nearPoint clusterCenter x
    in closestPoint : nextNearPoint clusterCenter xs

isPointInClusterCenters :: [[Int]] -> [Int] -> Bool
isPointInClusterCenters clusterCenter point = sameRBG clusterCenter point

addPointToClusterCenters :: [[Int]] -> [Int] -> [[Int]]
addPointToClusterCenters clusterCenter point = clusterCenter ++ [point]

setClusterCenters :: Int -> Int -> [[Int]] -> [[Int]] -> IO [[Int]]
setClusterCenters k cpt points clusterCenter
    | cpt == k = return clusterCenter
    | otherwise = do
        rand <- randomRIO (0, length points - 1)
        let newPos = (rand + cpt) `mod` length points
        let point = points !! newPos
        if isPointInClusterCenters clusterCenter point then
            setClusterCenters k cpt points clusterCenter
        else let newClusterCenters=addPointToClusterCenters clusterCenter point
            in setClusterCenters k (cpt+1) points newClusterCenters

smallestDistance :: [Int] -> [Int] -> Float -> Bool
smallestDistance point1 point2 value =
    let distance = calculateDistance point1 point2
    in distance < value

bothClusterCenters :: [Int] -> [Int] -> Float -> Bool
bothClusterCenters old new convergence = smallestDistance
    old new convergence

sortedEveryElem :: (a -> a -> b -> Bool) -> [a] -> [a] -> b -> Bool
sortedEveryElem _ [] [] _ = True
sortedEveryElem condition (x:xs) (y:ys) value
    | not (condition x y value) = False
    | otherwise = sortedEveryElem condition xs ys value

verifLimit :: [[Int]] -> [[Int]] -> Float -> Bool
verifLimit oldClusterCenters newClusterCenters convergence =
    sortedEveryElem smallestDistance oldClusterCenters
        newClusterCenters convergence

startAlgo :: Int -> Float -> [[Int]] -> [[Int]] -> IO ()
startAlgo numberCluster averageLimit list listPoints = do
    clusterCenter <- setClusterCenters numberCluster 0 listPoints []
    startLoop averageLimit list listPoints clusterCenter

generateCluster :: Float -> [[Int]] -> [[Int]] -> [[Int]] -> IO [[Int]]
generateCluster averageLimit list listPoints old
    | verifLimit old new averageLimit =
        printAllList old next listPoints 0 >> return new
    | otherwise = generateCluster averageLimit list listPoints new
    where
        next = nextNearPoint old listPoints
        new = findClusterCenter old listPoints next 0

startLoop :: Float -> [[Int]] -> [[Int]] -> [[Int]] -> IO ()
startLoop averageLimit list listPoints clusterCenter = do
    _ <- generateCluster averageLimit list listPoints clusterCenter
    return ()
