import Data.List
import Text.Read

getUserInputs :: IO [Int]
getUserInputs = do
    input <- getLine
    case parseInput input of 
        Nothing -> return []
        Just anInt -> do
            moreInputs <- getUserInputs
            return (anInt : moreInputs)

parseInput :: String -> Maybe Int
parseInput input = if input == "exit" then Nothing else (readMaybe input):: Maybe Int
        
main :: IO ()
main = do
    a <- getUserInputs
    print $ a