class Grafo:
    def __init__(self, nomeArquivo = "exemplo_grafo.txt"):
        self.nomeArquivo = nomeArquivo
        self.vertices = self.organizarVertices()
        self.numeroVertices = self.getNumeroVertices()
        self.matrizGrafo = self.novaMatriz()
        self.arestas = self.getArestas()

    def putNomeArquivo(self, nome):
        pass

    def getNumeroVertices(self):
        return sum(1 for line in open(self.nomeArquivo, "r"))

    def novaMatriz(self):
        return [[0 for i in range(self.numeroVertices)] for j in range(self.numeroVertices)]

    def organizarVertices(self):
        resultado = {}

        for linha in open(self.nomeArquivo, "r"):
            linha = linha.replace(":", "").replace("\n", "").split(" ")
            verticeOrigem, *arestas = linha
            verticeOrigem = verticeOrigem
            resultado[verticeOrigem] = {}


            for aresta in arestas:
                if(aresta.find("@") < 0):
                    valor = 1
                else:
                    aresta, valor = aresta.split("@")
                    valor = int(valor)

                resultado[verticeOrigem][aresta] = valor

        return resultado

    def getArestas(self):
        resultado = []

        for vertice in self.getVertices():
            for vizinho in self.getVizinhos(vertice):
                resultado.append((vertice, vizinho, self.vertices[vertice][vizinho]))

        return resultado


    def getGrauVertice(self, vertice):
        return len(self.vertices[vertice])

    def getVertices(self):
        return self.vertices.keys()

    def getVizinhos(self, vertice):
        return self.vertices[vertice].keys()

    def grafoIncidente(self):
        for i in range(self.numeroVertices):
            for j in range(self.numeroVertices):
                self.matrizGrafo[i][j] = 1 # Saida do Vertice
                self.matrizGrafo[j][i] = -1 # Entrada no Vertice

    def grafoAdjacente(self):
        for i in range(self.numeroVertices):
            for j in range(self.numeroVertices):
                self.matrizGrafo[i][j] = 1

    def getMatriz(self):
        return self.matrizGrafo

    def bfs(self, comeco = '0', fim = None):
        faca = [(comeco, [comeco])]
        while faca:
            folha, caminho = faca.pop(0)

            for proximaFolha in self.getVizinhos(folha):
                if proximaFolha in caminho:
                    continue
                elif proximaFolha == fim:
                    return caminho + [proximaFolha]
                else:
                    faca.append((proximaFolha, caminho + [proximaFolha]))

        return caminho

    def dfs(self, comeco = '0'):
        pilha, caminho = [comeco], []
        while pilha:
            vertice = pilha.pop()
            if vertice not in caminho:
                caminho += [vertice]
                pilha += self.getVizinhos(vertice)
        return caminho

    def verificarCiclo(self, comeco):
        visitados, restantes = [], [comeco]

        while restantes:
            atual = restantes.pop()
            visitados.append(atual)

            for vizinho in self.getVizinhos(atual):
                if vizinho in visitados:
                    return True
                else:
                    restantes.append(vizinho)

        return False

    def fleury(self, comeco):
        if not self.verificarCiclo(comeco):
            return False

        contador = 0
        for folha in self.vertices:
            if self.getGrauVertice(folha) %  2 != 0:
                contador += 1

            if contador > 1:
                return False

        return True

    def dijkstra(self, comeco, fim):
        inf = float('infinity')

        menorCaminho = {comeco: (None, 0)}
        verticeAtual = comeco
        visitado = set()
    
        while verticeAtual != fim:
            visitado.add(verticeAtual)
            destinos = self.getVizinhos(verticeAtual)
            valorVerticeAtual = menorCaminho[verticeAtual][1]

            for proximoVertice in destinos:
                valor = self.vertices[verticeAtual][proximoVertice] + valorVerticeAtual
                if proximoVertice not in menorCaminho:
                    menorCaminho[proximoVertice] = (verticeAtual, valor)
                else:
                    menorValorAtual = menorCaminho[proximoVertice][1]
                    if menorValorAtual > valor and valor >= 0:
                        menorCaminho[proximoVertice] = (verticeAtual, valor)

            novoDestino = {vertice: menorCaminho[verticeAtual] for vertice in menorCaminho if vertice not in visitado}

            if not novoDestino:
                return ['Rota não possivel']

            verticeAtual = min(novoDestino, key = lambda x: novoDestino[x][1])

        caminho = []
        while verticeAtual is not None:
            caminho.append(verticeAtual)
            proximoVertice = menorCaminho[verticeAtual][0]
            verticeAtual = proximoVertice

        caminho = caminho[::-1]

        return caminho

    def bellmanFord(self, comeco):
        distancia = {vertice: float('inf') for vertice in self.getVertices()}
        distancia[comeco] = 0

        for _ in range(self.numeroVertices):
            for u, v, w in self.arestas:
                if distancia[u] != float('inf') and distancia[u] + w < distancia[v]:
                    distancia[v] = distancia[u] + w

        for u, v, w in self.arestas:
            if distancia[u] != float('inf') and distancia[u] + w < distancia[v]:
                return []

        return distancia