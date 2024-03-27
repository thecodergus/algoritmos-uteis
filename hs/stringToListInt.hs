stringToListInt :: String -> [Int]
stringToListInt x = map read (words x) :: [Int]