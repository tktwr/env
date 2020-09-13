#include <vector>
#include <cstdio>
#include "b.h"

using namespace std;

class A {
public:
    A() {}
    virtual ~A() {}

    void setValue(int v) { m_val = v; }
    int  getValue() const { return m_val; }

private:
    int m_val = 0;
};

int main(int argc, char *argv[]) {
    std::vector<int> vec;
    auto i = vec.begin();
    printf("");
    f_test();

    A a;
    a.getValue();

    B b;
    b.getValue();
    b.getValue(1);
    b.getValue(2);
    if (true) {
        statement;
    }

    return 0;
}

