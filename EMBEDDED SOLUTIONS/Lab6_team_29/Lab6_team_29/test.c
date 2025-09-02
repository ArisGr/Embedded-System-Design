#include <unistd.h>
#include <sys/syscall.h>
#include <stdio.h>
#define SYS_new 386

int main(void) {
    printf("Testing System Call :\n");
    long sc = syscall(SYS_new);
    printf("Return Value = %ld\n", sc);
    return 0;
}
