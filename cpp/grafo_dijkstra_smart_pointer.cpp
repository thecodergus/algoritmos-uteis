#include <algorithm>
#include <iostream>
#include <memory>
#include <queue>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

#define INFINITY 9e8

class Vertice {
 public:
  Vertice(const std::string& nome) : nome(nome) {}
  std::string nome;
  std::vector<std::shared_ptr<Vertice>> vizinhos;
};

std::vector<std::string> dijsktra(std::unordered_map<std::string, std::shared_ptr<Vertice>>& vertices, const std::string& inicio,
                                  const std::string& fim) {
  std::vector<std::string> caminho;
  std::unordered_set<std::string> visitados;
  std::unordered_map<std::string, std::string> anteriores;
  std::unordered_map<std::string, int> distancias;
  std::priority_queue<std::pair<int, std::string>> fila;

  for (const auto& [nome, vertice] : vertices) {
    distancias[nome] = INFINITY;
  }

  distancias[inicio] = 0;
  fila.push({0, inicio});

  while (!fila.empty()) {
    auto [distancia, nome] = fila.top();
    fila.pop();

    if (visitados.find(nome) != visitados.end()) {
      continue;
    }

    visitados.insert(nome);

    for (const auto& vizinho : vertices[nome]->vizinhos) {
      if (visitados.find(vizinho->nome) != visitados.end()) {
        continue;
      }

      int nova_distancia = distancia + 1;
      if (nova_distancia < distancias[vizinho->nome]) {
        distancias[vizinho->nome] = nova_distancia;
        anteriores[vizinho->nome] = nome;
        fila.push({-nova_distancia, vizinho->nome});
      }
    }
  }

  std::string atual = fim;
  while (atual != inicio) {
    caminho.push_back(atual);
    atual = anteriores[atual];
  }
  caminho.push_back(inicio);

  std::reverse(caminho.begin(), caminho.end());

  return caminho;
}

int main() {
  int pontos{}, ligacoes{};
  std::unordered_map<std::string, std::shared_ptr<Vertice>> vertices;
  std::string nome1, nome2;
  std::cin >> pontos >> ligacoes;

  for (int i{}; i < ligacoes; i++) {
    std::cin >> nome1 >> nome2;
    if (vertices.find(nome1) == vertices.end()) {
      vertices[nome1] = std::make_shared<Vertice>(nome1);
    }

    if (vertices.find(nome2) == vertices.end()) {
      vertices[nome2] = std::make_shared<Vertice>(nome2);
    }

    vertices[nome1]->vizinhos.push_back(vertices[nome2]);
    vertices[nome2]->vizinhos.push_back(vertices[nome1]);
  }

  auto caminho_ate_queijo = dijsktra(vertices, "Entrada", "*");

  auto caminho_ate_saida = dijsktra(vertices, "*", "Saida");

  std::cout << caminho_ate_queijo.size() - 1 + caminho_ate_saida.size() - 1 << std::endl;

  return 0;
}