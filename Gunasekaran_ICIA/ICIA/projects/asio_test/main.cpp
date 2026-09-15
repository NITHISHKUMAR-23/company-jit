#include <asio.hpp>
#include <iostream>

int main() {
    asio::io_context io;
    std::cout << "ASIO is working on Raspberry Pi!" << std::endl;
    return 0;
}
