#pragma once

void f_test();

class B {
public:
    B() {}
    virtual ~B() {}

    void setValueB(int v) { m_val = v; }
    int  getValueB() const { return m_val; }

private:
    int m_val = 0;
};

