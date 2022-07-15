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
    ((4, 3), 1)]

adjacentes :: Grafo -> Vertice -> [Vertice]
adjacentes [] _ = []
adjacentes (((a, b), _):c) v 
                        | (a == v) = b : (adjacentes c v)
                        | (a == v) = a : (adjacentes c v)
                        | otherwise = adjacentes c v 