mult_maybe :: Maybe Integer -> Maybe Integer -> Maybe Integer
mult_maybe _ Nothing = Nothing
mult_maybe Nothing _ = Nothing
mult_maybe (Just a) (Just b) = Just $ a * b

fat :: Integer -> Maybe Integer
fat n 
    | n == 0 = Just 1
    | n < 0 = Nothing
    | otherwise = do
                    mult_maybe (Just n) (fat(n - 1))