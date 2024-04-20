{-
-- EPITECH PROJECT, 2024
-- Parser.hs
-- File description:
-- Haskell
-}

module Parser (parseArgs, checkArgs) where

import Value (Value, upVal)
import Lib (isFloat)

import Data.Char (isDigit)

parseArgs :: Value -> [String] -> Maybe Value
parseArgs value args = parseArgs2 value args

parseArgs2 :: Value -> [String] -> Maybe Value
parseArgs2 value args = case args of
    [] -> Just value
    ("-n":x:xs) -> case reads x :: [(Int, String)] of
        [(newValue, _)] -> parseArgs2 (upVal "number" (show newValue) value) xs
        _               -> Nothing
    ("-l":x:xs) -> case reads x :: [(Float, String)] of
        [(newValue, _)] -> parseArgs2 (upVal "limit" (show newValue) value) xs
        _               -> Nothing
    ("-f":x:xs) -> parseArgs2 (upVal "filepath" x value) xs
    _ -> Nothing

checkArgs :: [String] -> Bool
checkArgs [] = True
checkArgs ("-n":x:xs) = isValidValue x && checkArgs xs
checkArgs ("-l":x:xs) = isValidFloat x && checkArgs xs
checkArgs ("-f":x:xs) = checkArgs xs
checkArgs _ = False

isValidFloat :: String -> Bool
isValidFloat = all isFloat

isValidValue :: String -> Bool
isValidValue = all isDigit
