#include <iostream>
#include <cstdio>
#include <string>
#include <vector>
#include <array>
#include <queue>
#include <utility>
#include <algorithm>
#include <map>
#include <functional>
#include <tuple>
#include <numeric>
#include <set>
#include <bitset>
#include <cmath>

#define F(x) for(int i = 0; i < x; i++)
#define pb push_back
#define Feach(x) for(auto item : x)
#define mp make_pair
#define mt make_tuple

using namespace std;
const double PI = 3.14159265358979323846;

typedef long long ll;
typedef unsigned long long ull;
typedef long long int lli;
typedef long double ld;
typedef unsigned int uint;
typedef vector<int> vi;

template <typename T>
vector<T> sieve_of_atkin(T limit);

int main(){
    ios::sync_with_stdio(0);
    std::cin.tie(0);

	auto a{sieve_of_atkin<ull>(20)};

	Feach(a) cout << item << endl;


    return 0;
}

template <typename T>
vector<T> sieve_of_atkin(T limit){
	vector<T> numbers;

	if(limit > 2) numbers.push_back(2);
	if(limit > 3) numbers.push_back(3);

	vector<char> sieve(limit + 1, '0');
	
	for(T x{1}; x * x <= limit; x++){
		for(T y{1}; y * y <= limit; y++){
			
			T n = (4 * x * x) + (y * y);
			if(n <= limit && (n % 12 == 1 || n % 12 == 5)) sieve[n] = '1';
	
			n = (3 * x * x) + (y * y);
			if(n <= limit && n % 12 == 7) sieve[n] = '1';
	
			n = (3 * x * x) - (y * y);
			if(x > y && n <= limit && n % 12 == 11) sieve[n] = '1';
		}
	}

	for(T r{5}; r * r <= limit; r++) if(sieve[r] == '1') for(T i{r * r}; i <= limit; i += r * r) sieve[i] = '0';

	for(int i{5}; (T)i <= limit; i++) if(sieve[i] == '1') numbers.push_back(i);
	

	return numbers;
}
