mult :: Maybe Integer -> Maybe Integer -> Maybe Integer
mult _ Nothing = Nothing
mult Nothing _ = Nothing
mult (Just a) (Just b) = Just $ a * b

fat :: Integer -> Maybe Integer
fat n 
    | n == 0 = Just 1
    | n < 0 = Nothing
    | otherwise = do
                    mult (Just n) (fat(n - 1))