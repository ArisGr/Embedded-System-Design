#include <linux/kernel.h>

asmlinkage long sys_hello(void)
{
        printk(KERN_ALERT "Greeting from kernel and team 29!\n");
        return 0;
}
