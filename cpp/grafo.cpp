#include <iostream>
#include <cstdio>
#include <string>
#include <vector>
#include <utility>
#include <algorithm>
#include <map>
#include <functional>
#include <numeric>
#include <set>
#include <bitset>
#include <cmath>
#include <array>

#define F(x) for(int i = 0; i < x; i++)
#define pb push_back
#define Feach(x) for(auto item : x)
#define mp make_pair

using namespace std;
const double PI = 3.14159265358979323846;

typedef unsigned int uint;
typedef vector<double> vd;
typedef vector<vector<double>> vvd;

const uint TAM = 50;
class Grafo{
	public:
		array<array<double, TAM>, TAM> matrix;
		uint tamanho{};
		bool bidirecional{};

	Grafo(uint tamanho, bool bidirecional = true){
		this->tamanho = tamanho;
		this->bidirecional = bidirecional;

		F(tamanho) matrix[i].fill(-1.0);
	}

	void add_aresta(uint a, uint b, double valor = 1.0){		
		this->matrix[a][b] = valor;

		if(this->bidirecional) this->matrix[b][a] = valor;
	}

	void remove_aresta(uint a, uint b){
		this->matrix[a][b] = -1.0;

		if(this->bidirecional) this->matrix[b][a] = -1.0;
	}

	set<uint> get_vizinhos_nodo(uint nodo){
		set<uint> vizinhos;

		F(this->tamanho) if(this->matrix[nodo][i] >= 0 || this->matrix[i][nodo] >= 0 && this->bidirecional) vizinhos.insert(i);

		return vizinhos;
	}

	set<pair<uint, double>> get_vizinhos_nodo_valores(uint nodo){
		set<pair<uint, double>> vizinhos;

		F(this->tamanho) if(this->matrix[nodo][i] >= 0 || this->matrix[i][nodo] >= 0 && this->bidirecional) vizinhos.insert(mp(i, this->matrix[nodo][i]));

		return vizinhos;
	}

	uint get_numero_vizinhos(uint nodo){
		uint numero{};

		F(this->tamanho) if(this->matrix[nodo][i] >= 0) numero++;

		return numero;
	}

	bool verificar_conexao(uint a, uint b){
		return this->matrix[a][b] >= 0;
	}

	bool verificar_ciclo(uint inicio){
		set<uint> visitados{};
		vector<uint> restantes{inicio};

		while(restantes.size() > 0) {
			uint atual{restantes.back()};
			restantes.pop_back();

			Feach(this->get_vizinhos_nodo(atual)){
				if(visitados.find(item) != visitados.end()){
					return true;
				}else{
					restantes.pb(item);
				}
			}
		}

		return false;
	}

	bool verificar_ciclo_grafo_todo(){
		F(this->tamanho) if(this->verificar_ciclo(i)) return true;

		return false;
	}

	
	
};

int main(){
    ios::sync_with_stdio(0);
    std::cin.tie(0);

	Grafo g(10);

	g.add_aresta(1, 2);

    return 0;
}