ENTRY(loader)                       /* 指定loader为入口点 */
OUTPUT_FORMAT(elf32-i386)           /* 指定输出文件的格式为32位的ELF格式,特定于x86架构,有良好的扩展性 */
OUTPUT_ARCH(i386:i386)              /* 指定目标架构和机器类型，冒号后一般为细化或子类型，这里为重复*/

SECTIONS
{
    . = 0x01000000;                  /*定义位置计数器.为0x01000000*/
    .text :                         /*定义一个.text段*/
    {                               
        *(.multiboot)
        *(.text*)
        *(.rodata)
    }

    .data :
    {
        start_ctors = .;
        KEEP(*( .init_array ));
        KEEP(*(SORT_BY_INIT_PRIORITY(.init_array.*)));
        end_ctors = .;

        *(.data)
    }

    .bss :
    {
        *(.bss)
    }

    /DISCARD/ :
    {
        *(.fini_array*)
        *(.comment)
    }
}