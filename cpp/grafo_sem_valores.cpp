#include <iostream>
#include <cstdio>
#include <string>
#include <vector>
#include <array>
#include <utility>
#include <algorithm>
#include <map>
#include <functional>
#include <numeric>
#include <set>
#include <bitset>
#include <cmath>

#define F(x) for (int i = 0; i < x; i++)
#define pb push_back
#define Feach(x) for (auto item : x)
#define mp make_pair

using namespace std;
const double PI = 3.14159265358979323846;

typedef long long ll;
typedef unsigned long long ull;
typedef long long int lli;
typedef long double ld;
typedef unsigned int uint;
typedef vector<int> vi;

const uint TAM = 30;
class Grafo
{
public:
    array<array<bool, TAM>, TAM> matrix{};
    uint tamanho{};
    bool bidirecional{};

    Grafo(uint tamanho, bool bidirecional = true)
    {
        this->tamanho = tamanho;
        this->bidirecional = bidirecional;
    }

    void add_aresta(uint a, uint b)
    {
        this->matrix[a][b] = true;

        if (this->bidirecional)
            this->matrix[b][a] = true;
    }

    void remove_aresta(uint a, uint b)
    {
        this->matrix[a][b] = false;

        if (this->bidirecional)
            this->matrix[b][a] = false;
    }

    set<uint> get_vizinhos_nodo(uint nodo)
    {
        set<uint> vizinhos;

        F(this->tamanho)
        if (this->matrix[nodo][i] || this->matrix[i][nodo] && this->bidirecional) vizinhos.insert(i);

        return vizinhos;
    }

    uint get_numero_vizinhos(uint nodo)
    {
        uint numero{};

        F(this->tamanho)
        if (this->matrix[nodo][i]) numero++;

        return numero;
    }

    bool verificar_conexao(uint a, uint b)
    {
        return this->matrix[a][b];
    }

    bool verificar_ciclo(uint inicio)
    {
        set<uint> visitados{};
        vector<uint> restantes{inicio};

        while (restantes.size() > 0)
        {
            uint atual{restantes.back()};
            restantes.pop_back();

            Feach(this->get_vizinhos_nodo(atual))
            {
                if (visitados.find(item) != visitados.end())
                {
                    return true;
                }
                else
                {
                    restantes.pb(item);
                }
            }
        }

        return false;
    }

    bool verificar_ciclo_grafo_todo()
    {
        F(this->tamanho)
        if (this->verificar_ciclo(i)) return true;

        return false;
    }
};

int main() {

    return 0;
}