main :: IO ()
main = do
    putStr "N1: "
    n1 <- getLine
    putStr "N2: "
    n2 <- getLine
    putStrLn $ "Soma: " ++ (show $ read n1 + read n2)