ENTRY(loader)                       /* 指定loader为入口点 */
OUTPUT_FORMAT(elf32-i386)           /* 指定输出文件的格式为32位的ELF格式,特定于x86架构,有良好的扩展性 */
OUTPUT_ARCH(i386:i386)              /* 指定目标架构和机器类型，冒号后一般为细化或子类型，这里为重复*/

SECTIONS
{
    . = 0x01000000;                 /*定义位置计数器.为0x01000000*/
    .text :                         /*定义一个.text段*/
    {                               
        *(.multiboot)               /*multiboot头*/
        *(.text*)                   /*所有目标文件的.text开头的段被聚合到当前.text段*/
        *(.rodata)                  /*包含只读数据（read-olny data）：常量，字符串字面量，其他只读数据*/
    }

    .data :                         /*定义.data区data段用于存储已经初始化的全局变量和静态变量，且初值不为0*/
    {
        start_ctors = .;            /*定义构造函数指针开始位置*/
        KEEP(*( .init_array ));     /*保留.init_array,它保留了程序启动时需要被调用的初始化函数的指针数组*/
        KEEP(*(SORT_BY_INIT_PRIORITY(.init_array.*))); /*将其按优先级排序并保留*/
        end_ctors = .;              /*定义构造函数指针结束位置*/

        *(.data)                    /*聚合所有目标文件的.data内容到当前.data段*/
    }

    .bss :                          /*定义.bss，bss段用于存储初始化过的全局变量和静态常量，或者其初值为0,因为不占存储空间*/
    {
        *(.bss)                     /*聚合.bss段*/
    }

    /DISCARD/ :                     /*可忽略（丢弃）*/
    {
        *(.fini_array*)             /*.fini_array 段通常包含一系列在程序终止时需要调用的函数的指针。这些函数主要用于执行清理工作，如释放资源、关闭文件等。*/
        *(.comment)                 /*.comment 段通常包含编译器或其他工具添加的注释或元数据，这些信息对于程序的执行不是必需的，但可能对于调试或分析程序有用。*/
    }
}