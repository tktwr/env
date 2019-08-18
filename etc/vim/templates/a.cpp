#include <iostream>
#include <vector>
#include <memory>
#include <fstream>
#include <string>
#include "b.h"

using namespace std;

void f_write_text_file(const std::string& fname, const std::string& text) {
    std::ofstream ofs(fname.c_str());
    ofs << text;
}

void f_read_text_file(const std::string& fname, std::string& text) {
    std::ifstream ifs(fname.c_str());
    std::string line;
    while (std::getline(ifs, line)) {
        text += line + '\n';
    }
}

int main(int argc, char *argv[]) {
    std::vector<int> vec;
    auto i = vec.begin();
    printf("");
    f_test();

    std::string text =
R"(abc
def
123
)";

    f_write_text_file("hoge", text);

    std::string text2;
    f_read_text_file("hoge", text2);

    std::cout << text2;

    return 0;
}

