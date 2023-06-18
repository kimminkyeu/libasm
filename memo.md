
### General Purpose Registers
|           RAX                  |  --> 64bit
              |       EAX        |  -->  32bit
                       |   AX    |  -->  16bit
                       | AH | AL |  -->  8bit each

SI DI (Index register) : (source, destination)
SP BP (Pointer register) : (stack, base)

- FlAGS register (special register controlled by ALU)
  이 레지스터는 계산 결과, 함수 호출 상태를 알아낼 수 있음.
  zero, sign, ...


### Data Types
- https://www.tutorialspoint.com/assembly_programming/assembly_variables.htm

- byte   or db    : 1byte (db stands for "define bytes")
- word   or dw    : 2byte
- dword  or dd    : 4byte
- qword  or dq    : 8byte (including SIMD)
- tbyte           : 10byte

- real4    : 32bit float
- real8    : 64bit float
- real10   : 80bit float

and more...


## Calling Convection
-------------------------
CPU 아키텍쳐는 정해져 있다. 레지스터가 뭐가 있고, 스택 포인터가 뭐가 있고...
이 자원을 어떻게 활용할 것인지는 컴파일러 프로그래머 혹은 어셈블리 개발자의 책임이다.
아래 calling convection들이 여러 종류 있는 이유는
그것을 어떻게 활용해야 하는지 프로그래머가 선택할 수 있기 때문이다.

### x86 raw assembly Calling Convention


### x86 raw assembly Calling Convention



### x64 raw assembly Calling Convention



### C/C++ Calling Convention
표준화된 C/C++ compiler's calling convention 종류들
각 calling convention은 인자를 어떻게 호출하고, 어떤 식으로 매개변수를 넘기고,
리턴값은 뭘로 받을 것인지에 대한 규칙을 정의한다.
1. cdecl      : default 호출 규칙.
2. stdcall    :
3. fastcall   :
4. vectorcall :

### ASM Programming Syntax (Intel)
- https://www.tutorialspoint.com/assembly_programming/assembly_basic_syntax.htm

An assembly program can be divided into three sections
1. [ section .data ]  : constant data, initialized data
2. [ section .bss  ]  : delcare variable
3. [ section .text ]  : keeping the actual code


##### ? MacOS는 시스템 콜 숫자가 다른 이유
- http://dustin.schultz.io/mac-os-x-64-bit-assembly-system-calls.html
- https://opensource.apple.com/source/xnu/xnu-792.13.8/osfmk/mach/i386/syscall_sw.h

- MacOS 형식 : 0x[SyscallClass][SyscallNumber]
         ex : 0x02000004 = write syscall for UNIX class

### NASM Declaration Keyword
1. db, dw, dd, dq : 메모리 공간과 초기 값을 지정 (ex. "message db 1" : 1byte 크기 message변수를 1로 초기화)

2. resb, resw, resd, resq : 메모리 공간만을 정의 (초기화 x, .bss 세그먼트에서 사용)

### Arithmetic Instructions
- https://www.tutorialspoint.com/assembly_programming/assembly_arithmetic_instructions.htm
- add, sub, mul, imul, div, idiv ...
- mul  / div   : 부호없는 곱셈/나눗셈
- imul / idiv  : 부호있는 곱셈/나눗셈

### Logical Instructions (이 연산 결과는 FlAGS register에 저장됨)
- AND
- OR
- XOR
- TEST
- NOT

## 0617 찾은 학습자료
- https://courses.ics.hawaii.edu/ReviewICS312/morea/FirstProgram/ics312_nasm_first_program.pdf
- 깔끔한 PPT로 정리되어 있어서 보기 좋음.
- 이건 하던 것
- https://www.tutorialspoint.com/assembly_programming/assembly_logical_instructions.htm

### Local Label
- https://www.tortall.net/projects/yasm/manual/html/nasm-local-label.html
- some_local_label의 이름이 같아도, 이름충돌이 나지 않음.
my_label:
  .some_local_label:
  ; ...
my_label2:
  .some_local_label:
  ; ...

how to access.
  --> jmp my_label2.some_local_label

