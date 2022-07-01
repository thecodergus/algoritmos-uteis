#include <iostream>
#include <array>
#include <numeric>
#include <functional>
#include <algorithm>

using namespace std;

// Beecrowd: 1059
int main()
{
    array<int, 50> a;
    auto mult_2 = [](int *x)
    { (*x) * 2; };

    iota(a.begin(), a.end(), 1);

    auto mult = [](int a)
    {
        return a * 2;
    };

    // map
    transform(a.begin(), a.end(), a.begin(), mult);

    for (int i : a)
    {
        cout << i << endl;
    }
}