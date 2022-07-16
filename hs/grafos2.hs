import Data.Graph

grafo = buildG(1, 4) [(1,2), (2, 3), (3, 1), (4, 1)]

main = do
    print $ dfs grafo [1]