eh_primo :: Integer -> Bool
eh_primo n  | n == 1 = False
            | n == 2 = True
            | (length [x | x <- [2..(n - 1)], n `mod` x == 0]) > 0 = False
            | otherwise = True