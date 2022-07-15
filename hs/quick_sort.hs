quick_sort :: Ord a => [a] -> [a]
quick_sort [] = []
quick_sort (x:xs) = quick_sort esquerda_x ++ [x] ++ quick_sort direita_x
                    where
                        esquerda_x = [i | i <- xs, i < x]
                        direita_x = [i | i <- xs, i >= x]