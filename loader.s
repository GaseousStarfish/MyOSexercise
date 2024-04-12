.set MAGIC, 0x1badb002      # 设置魔数，使加载引导程序知道这是一个内核程序
.set FLAGS, (1<<0 | 1<<1)
.set CHECKSUM, -(MAGIC + FLAGS)

.section .multiboot         # multiboot是一个为了使得多种操作系统能够在一个计算机上共存而设计的启动规范。
                            # 规范定义了一个操作系统映像应该具有的格式，包括一个称为Multiboot头的特殊头部
                            # 包括魔数（magic number）、标志（flags）、校验和(cheksum)等，这些信息帮助引导程序正确地加载操作系统。
    .long MAGIC
    .long FLAGS
    .long CHECKSUM

.section .text              # 以下代码放入代码段(text segment 存放可执行文件的操作指令)
.extern kernelMain          # 声明kernelMain为外部函数，链接时从其他文件寻找该函数
.extern callConstructors
.global loader              # 定义loader为全局可访问，链接器可从其他文件找到它

loader:
    mov $kernel_stack, %esp # 将kernel_stack的地址加载到esp寄存器（esp寄存器存储当前线程栈的栈顶指针）
    call callConstructors   # 调用若干kernel运行前的构造函数

    push %eax               # 教程中说引导加载程序会在ax中存储指向multiboot头的地址，以及在bx寄存器中放置魔数
    push %ebx               # 所以这里之间将ax、bx入栈

    call kernelMain         # 调用内核程序

_stop :
    cli                     # 清除中断标志
    hlt                     # 使cpu进入暂停状态
    jmp _stop

.section .bss               # 以下代码放入bss区（bss区用于存放未初始化的全局变量和静态变量的内存区域
.space 2*1024*1024          # 空出 bss区中 2 MiB空间作为内核栈
kernel_stack:               # 设置kernel_stack地址
