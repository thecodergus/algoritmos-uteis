class Grafo:
    def __init__(self, nomeArquivo = "exemplo_grafo.txt"):
        self.nomeArquivo = nomeArquivo
        self.grafo = self.digitalizarGrafo()

    # retorna o grafo
    def getGrafo(self):
        return self.grafo

    # retorna o numero de nos que o grafo tem
    def getNumeroNos(self):
        return len(self.getNos())

    # pega o arquivo .txt e retorna um grafo, é a partir desta função que todas as outras funcionam
    def digitalizarGrafo(self):
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

    # retorna todas as arestas pertecentes ao grafo
    def getArestas(self):
        resultado = []

        for vertice in self.getNos():
            for vizinho in self.getVizinhosNo(vertice):
                if vizinho != "":
                    resultado.append((vertice, vizinho, self.grafo[vertice][vizinho]))

        return self.insertSortAdaptado(resultado)

    # MergeSort adaptado para a atual aplicação, onde ele organização em ordem crescente a lista de Arestas
    def insertSortAdaptado(self, vetor):
        for i in range(1, len(vetor)):
            chave = vetor[i]
            
            j = i - 1
            while j >= 0 and chave[2] < vetor[j][2]:
                vetor[j + 1] = vetor[j]
                j -= 1
            vetor[j + 1] = chave

        return vetor


    # retorna o grau do No indicado
    def getGrauVertice(self, vertice):
        return len(self.grafo[vertice])

    # retorna um vetor com todos os Nos do grafo
    def getNos(self):
        return [i for i in self.grafo.keys()]

    # retorna um vetor com todos os Nos vizinhos ao No fornecido
    def getVizinhosNo(self, no):
        if no == "":
            return []
        return [i for i in self.grafo[no].keys()]

    # calcula o valor de um caminho dentro de um grafo com base no vetor fornecido. Ex: ["A", "B", "C", "A"]
    def getValorCaminho(self, caminho):
        distancia = 0
        for i in range(len(caminho)):
            if i < len(caminho) - 1:
                distancia += self.grafo[caminho[i]][caminho[i + 1]]

        distancia += self.grafo[caminho[i - 2]][caminho[i - 1]]

        return distancia
    
    # verifica se o caminho é valido dentro do grafo
    def verificarIntegridadeCaminho(self, caminho):
        temp = caminho[0]
        for i in range(1, len(caminho)):
            if caminho[i] in self.getVizinhosNo(temp):
                temp = caminho[i]
            else:
                return False

        return True

    # retorna um vetor com um caminho minimo baseado no inicial, com base na metodologia de sempre ir para o proximo vertice da arestas que tem o menor valor
    def getMinimosSucessivos(self, noInicial):
        if noInicial == None and noInicial not in self.getNos():
            return None
        
        nosFila = self.getNos()
        nosFila.remove(noInicial)
        caminho = [noInicial]

        noPasso = noInicial
        while len(nosFila) > 0:
            menor = self.__menorCaminho(noPasso, nosFila)
            caminho.append(menor)
            nosFila.remove(menor)
            noPasso = menor
        
        caminho.append(noInicial)
        return caminho, self.getValorCaminho(caminho)

    # define qual aresta é a menor dentre ao conjunto de aresta daquele No
    def __menorCaminho(self, ponto, nosFila):
        fila = nosFila[:]  # nosFila[:] e igual a nosFila.copy()
        destino = fila.pop()
        menorDistancia = self.grafo[ponto][destino]

        for possivelDestino in fila:
            if self.grafo[ponto][possivelDestino] < menorDistancia:
                destino = possivelDestino
                menorDistancia = self.grafo[ponto][possivelDestino]
            
        return destino

    # encontra todos os caminhos no grafo entre dois pontos, algoritmo recusivo adaptado para fazer o retorno apenas quando passar por todos os Nos do grafo
    def getTodosCaminhos(self, comeco, fim, caminho = []):
        caminho = caminho + [comeco]

        if comeco == fim and self.verificarPassaTodosNos(caminho):
            return [caminho]

        if comeco not in self.getNos():
            return []

        caminhos = []

        for no in self.getVizinhosNo(comeco):
            if no not in caminho and no != comeco:
                novosCaminhos = self.getTodosCaminhos(no, fim, caminho)
                for novoCaminho in novosCaminhos:
                    caminhos.append(novoCaminho)

        return caminhos

    # verifica se o caminho passa por todos os nos do grafo
    def verificarPassaTodosNos(self, caminho):
        for i in self.getNos():
            if i not in caminho:
                return False

        return True

    # Avore de busca, gera uma vetor de todos os caminhos possiveis no grafo a partir de certo No referenciado
    def arvore(self, no):
        if no not in self.getNos():
            return None

        resultado = []
        for i in self.getVizinhosNo(no):
            resultado += self.getTodosCaminhos(no, i)

        for i in resultado:
            i += [no]

        return resultado

    # Funcao inicial e final para o sistema de busca em arvores, faz as chamadas de funcao dos algoritmos de arvore e descobri qual caminho entre os caminhos traçados tem menor valor
    def getArvore(self, no):
        if no not in self.getNos():
            return None

        caminhos = self.arvore(no)
        menorCaminho = caminhos.pop()
        menorDistancia = self.getValorCaminho(menorCaminho)

        for i in caminhos:
            temp = self.getValorCaminho(i)
            if temp < menorDistancia:
                menorCaminho, menorDistancia = i, temp

        return menorCaminho, menorDistancia

    # cria um caminho com base nas arestas de menor valor
    def ordenacaoPesosArestas(self, noInicial):
        arestas = self.getArestas()
        resultado = []
        origens = []
        destinos = []
        noAtual = noInicial
        origem, destino = None, None
        repeticao = True

        while repeticao:
            for aresta in arestas:
                origem, destino, valor =  aresta

                if origem == noAtual and destino not in origens:
                    resultado.append(aresta)
                    noAtual = destino
                    origens.append(origem)
                    destinos.append(destino)
                    break

            if aresta == arestas.pop():
                repeticao = False

        destino = destinos.pop()
        for aresta in arestas:
            if destino == aresta[0] and noInicial == aresta[1]:
                resultado.append(aresta)
        
        return resultado

    # retorna o menor caminho dentro com base no algoritmo de organização de arestas
    def getOrdenacaoPesosAresta(self, noInicial):
        caminho = self.ordenacaoPesosArestas(noInicial)
        resultado = []
        

        for aresta in caminho:
            origem, destino, calor = aresta
            if resultado == []:
                resultado.append(origem)
                resultado.append(destino)
            else:
                resultado.append(destino)

        return resultado, self.getValorCaminho(resultado)
