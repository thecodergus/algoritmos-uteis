input :: Int -> IO [String]
input 0 = return []
input n = do
    x <- getLine
    xs <- input (n-1)
    return (x:xs)