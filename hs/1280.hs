problema :: Int -> Int -> Int
problema m n | m == 0 = n + 1
             | m >= 1 && n == 0 = problema (m - 1) 1
             | m > 0  && n > 0 = problema (m - 1) (problema m (n - 1))
             | m > 1 && m <= 3 = problema m 200
             | m == 4 = problema m 2