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
typedef void (*constructor)();                  //定义一个函数指针类型，指向空返回值空参数的函数

extern "C" constructor start_ctors;              //定义kernel前的构造函数地址组（.init_array）的起点
extern "C" constructor end_ctors;                //定义终点

extern "C" void callConstructors()              //调用所有kernel运行前的构造函数
{
    for(constructor* i=&start_ctors;i != &end_ctors;i++ )
    {
        (*i)();
    }
}

extern "C" void kernelMain(void* multibootStructure,unsigned int magicNumber)   //extern "C"让编译器按照c语言的链接约定编译该函数
                                                                                //使得g++在编译时不改变函数名称，让loader可以找到该函数
{
    printf("Hello World");
    while(1);

}