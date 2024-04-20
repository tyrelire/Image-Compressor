{-
-- EPITECH PROJECT, 2024
-- Value.hs
-- File description:
-- Haskell
-}

module Value (Value(..), defaultValue, upVal) where

data Value = Value {
    numberColors :: Int,
    convergenceLimit :: Float,
    filePath :: Maybe FilePath
} deriving (Show)

defaultValue :: Value
defaultValue = Value {
    numberColors = 0,
    convergenceLimit = 0.0,
    filePath = Nothing
}

upVal :: String -> String -> Value -> Value
upVal "number" newValue value   = case reads newValue :: [(Int, String)] of
    [(newIntValue, _)] -> value { numberColors = newIntValue }
    _                  -> value
upVal "limit" newValue value    = case reads newValue :: [(Float, String)] of
    [(newFloatValue, _)] -> value { convergenceLimit = newFloatValue }
    _                    -> value
upVal "filepath" newValue value = value { filePath = Just newValue }
upVal _ _ value                 = value
