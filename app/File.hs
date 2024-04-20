{-
-- EPITECH PROJECT, 2024
-- File.hs
-- File description:
-- Haskell
-}

module File (readAndDisplayFile) where

import System.IO

readAndDisplayFile :: String -> IO String
readAndDisplayFile filepath = do
    fd <- openFile filepath ReadMode
    buffer <- hGetContents fd
    return buffer
