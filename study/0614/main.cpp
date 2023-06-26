#include <iostream>

// C++ 에서 C calling convention 규약으로 함수를 로드하기 위한 키워드
// C언어를 쓸 경우엔 상관 없음.
// - https://learn.microsoft.com/ko-kr/cpp/cpp/extern-cpp?view=msvc-170
extern "C" {
    int sum(int lhs, int rhs);
}

int main(void) {
    std::cout << sum() << std::endl;
}
