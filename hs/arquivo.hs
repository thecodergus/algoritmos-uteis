import System.IO

escrever :: IO ()
escrever = do
            -- arq <- openFile "arquivo.txt" WriteMode
            arq <- openFile "arquivo.txt" AppendMode
            hPutStrLn arq "Escrevi aqui"
            hFlush arq
            hClose arq