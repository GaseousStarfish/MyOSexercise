#ifndef __GDT_H
#define __GDT_H

#include"types.h"
class GlobalDescriptorTable //保护模式下，用于区分内存为什么类型，对其访问进行限制
{
public:
    class SegmentDescriptor
    {
        private:            //GDT 描述符的结构 base 一段内存的地址   limit 该段内存的长度
            uint16_t limit_lo;
            uint16_t base_lo;
            uint8_t base_hi;
            uint8_t type;
            uint8_t flag_limit_hi;
            uint8_t base_vhi;
        public:
            SegmentDescriptor(uint32_t base,uint32_t limit,uint8_t flags);
            uint32_t Base();
            uint32_t Limit();
    }__attribute__((packed));//取消字节对齐优化


    SegmentDescriptor nullSegmentSelector;
    SegmentDescriptor unusedSegmentSelector;
    SegmentDescriptor codeSegmentSelector;
    SegmentDescriptor dataSegmentSelector;
public:
    GlobalDescriptorTable(/* args */);
    ~GlobalDescriptorTable();
    uint16_t CodeSegmentSelector();
    uint16_t DataSegmentSelector();

};
    

#endif