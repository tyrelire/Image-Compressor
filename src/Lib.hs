{-
-- EPITECH PROJECT, 2024
-- Lib.hs
-- File description:
-- Haskell
-}

module Lib (someFunc, exitFailure, isFloat) where

import System.Exit (exitWith, ExitCode (ExitFailure))

someFunc :: IO ()
someFunc = putStrLn "someFunc"

exitFailure :: IO ()
exitFailure = exitWith (ExitFailure 84)

isFloat :: Char -> Bool
isFloat c = c >= '0' && c <= '9' || c == '.'
