{-
-- EPITECH PROJECT, 2024
-- Print.hs
-- File description:
-- Print.hs
-}

module Print (printCoord, printList, printAllList) where
import Algo2 (searchPoint)

printElement :: Int -> Int -> IO ()
printElement x n
  | n >= 2 && n <= 4 = putStr $ show x ++ if n < 4 then "," else ""
  | otherwise = return ()

printList :: [Int] -> Int -> IO ()
printList [] _ = return ()
printList (x:xs) n = printElement x n >> printList xs (n + 1)

printRGBValue :: [Int] -> Int -> IO ()
printRGBValue point cpt =
    putStr "(" >>
    putStr (show (point !! 0)) >>
    putStr "," >>
    putStr (show (point !! 1)) >>
    putStr ") " >>
    putStr "(" >>
    printList point 0 >>
    putStrLn ")"

printCoord :: [Int] -> [[Int]] -> Int -> Int -> IO ()
printCoord [] _ _ _ = return ()
printCoord (x:xs) listPoints n cpt
    | x == n = printRGBValue (searchPoint listPoints cpt 0) cpt
        >> printCoord xs listPoints n (cpt + 1)
    | otherwise = printCoord xs listPoints n (cpt + 1)

printAllListDeux :: [Int] -> [Int] -> [[Int]] -> Int -> IO ()
printAllListDeux x coord listPoints n =
  putStr "--\n(" >>
  printList x 0 >>
  putStrLn ")\n-" >>
  printCoord coord listPoints n 0

printAllList :: [[Int]] -> [Int] -> [[Int]] -> Int -> IO ()
printAllList [] _ _ _ = return ()
printAllList (x:xs) coord listPoints n =
    printAllListDeux x coord listPoints n >>
        printAllList xs coord listPoints (n + 1)
