{-
-- EPITECH PROJECT, 2024
-- Main.hs
-- File description:
-- Haskell
-}

module Main (main) where

import System.Environment (getArgs)

import Lib (exitFailure)
import Value (Value(..), defaultValue)
import Parser (parseArgs, checkArgs)
import File (readAndDisplayFile)
import Algo (startAlgo)
import Algo2 (parseVectorImage)

main :: IO ()
main = getArgs >>= errorHandling

errorHandling :: [String] -> IO ()
errorHandling args
  | null args = putStrLn helpMsg >> exitFailure
  | length args /= 6 = exitFailure
  | not (checkArgs args) = exitFailure
  | otherwise = imageCompressor $ parseArgs defaultValue args

imageCompressor :: Maybe Value -> IO ()
imageCompressor Nothing = exitFailure
imageCompressor (Just value) = case filePath value of
  Nothing -> putStrLn "No file specified" >> exitFailure
  Just file -> do
    content <- readAndDisplayFile file
    startAlgo (numberColors value) (convergenceLimit value)
        [] (parseVectorImage content)

helpMsg :: String
helpMsg = "USAGE: ./imageCompressor -n N -l L -f F\n\n" ++
        "\tN\tnumber of colors in the final image\n" ++
        "\tL\tconvergence limit\n" ++
        "\tF\tpath to the file containing the colors of the pixels"
