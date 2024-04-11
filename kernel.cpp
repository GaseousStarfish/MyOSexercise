//#include<cstdio>
void printf(char* str)
{
    unsigned short* videoMemory = 
    reinterpret_cast<unsigned short*>(0xb8000);  //在内存中从该地址开始对应屏幕，每个字符有两个字节，
                                            //高位字节为字符的属性 低位字节为字符ascii码 
    for(int i=0;str[i]!='\0';i++)
    {
        videoMemory[i]=(videoMemory[i]&0xFF00) | str[i];//输出白色字符
    }
}
extern "C" void kernelMain(void* multibootStructure,unsigned int magicNumber)   //extern "C"让编译器按照c语言的链接约定编译该函数
                                                                                //使得g++在编译时不改变函数名称，让loader可以找到该函数
{
    printf("Hello World");
    while(1);

}