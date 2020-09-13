#pragma once

void f_test();

class B {
public:
    B() {}
    virtual ~B() {}

    void setValue(int v) { m_val = v; }
    int  getValue() const { return m_val; }
    int  getValue(int x) const;

private:
    int m_val = 0;
};

