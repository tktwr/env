#include <iostream>
#include <string>
#include <tuple>
#include <vector>
#include <list>
#include <map>

using namespace std;

void func() {
    int* p                       = nullptr;
    bool bt                      = true;
    bool bf                      = false;
    int i                        = 1;
    float f                      = 1.5f;
    std::string s                = "hello";
    std::vector<int> v           = {0, 1, 2};
    std::list<int> l             = {0, 1, 2};
    std::tuple<int, int, int> t  = {0, 1, 2};
    std::map<std::string, int> m = {{"a", 0}, {"b", 1}};
    // ---------- [print] ----------
    std::cout << "p  = " << p << std::endl;
    std::cout << "bt = " << bt << std::endl;
    std::cout << "bf = " << bf << std::endl;
    std::cout << "i  = " << i << std::endl;
    std::cout << "f  = " << f << std::endl;
    std::cout << "s  = " << s << std::endl;
    auto [a, b, c] = t;
    std::cout << "t = " << a << " " << b << " " << c  << std::endl;
    // ---------- [if] ----------
    if (true && true) {}

    if (true || true) {}

    if (true) {
    } else if (true) {
    } else {
    }
    // ---------- [for] ----------
    for (int i = 0; i < 3; ++i) {
        std::cout << v[i] << " ";
    }
    std::cout << std::endl;
    // ---------- [for range] ----------
    for (auto&& x : v) {
        std::cout << x << " ";
    }
    std::cout << std::endl;
    // ---------- [for iterator] ----------
    for (auto&& itr = std::begin(v); itr != std::end(v); ++itr) {
        std::cout << *itr << " ";
    }
    std::cout << std::endl;

    return;
}

int main(int argc, char *argv[]) {
    func();
    return 0;
}
