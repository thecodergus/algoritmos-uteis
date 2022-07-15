type Vertice = Integer
type Peso = Integer
type Aresta = ((Vertice, Vertice), Peso)
type Grafo = [Aresta]

grafo :: Grafo
grafo = [
    ((1, 2), 1),
    ((2, 3), 1),
    ((3, 1), 1),
    ((1, 4), 1),
    ((4, 3), 1)
    ]

adjacentes :: Vertice -> Grafo  -> [Vertice]
adjacentes _ [] = []
adjacentes v (((a, b), _):c) 
                        | (a == v) = b : (adjacentes v c)
                        | (b == v) = a : (adjacentes v c)
                        | otherwise = adjacentes v c 