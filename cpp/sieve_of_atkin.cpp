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

	bitset<1> sieve(limit + 1);

	T x{1}, y{}, n{};

	while((T)pow(x, 2) <= limit){
		y = 1;
		while((T)pow(y, 2) <= limit){
			n = (4 * pow(x, 2)) + pow(y, 2);
			if(n <= limit && (n % 12 == 1 || n % 12 == 5)) sieve[n] = true;
	
			n = (3 * pow(x, 2)) + pow(y, 2);
			if(n <= limit && n % 12 == 7) sieve[n] = true;
	
			n = (3 * pow(x, 2)) - pow(y, 2);
			if(x > y && n <= limit && n % 12 == 11) sieve[n] = true;
	
			y++;
		}
		x++;
	}

	T r{5};

	while((T)pow(r, 2) <= limit){
		if(sieve[r]) for(int i{(int)pow(r, 2)}; (T)i <= limit; i += (int)pow(r, 2)) sieve[i] = false;
		r++;
	}

	for(int i{5}; (T)i <= limit; i++) if(sieve[i]) numbers.push_back(i);
	

	return numbers;
}