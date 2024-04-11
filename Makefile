GRAPPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore 
#32位 以及告诉编译器不要假设有一个操作系统辅助程序运行
ASPARAMS = --32
LDPARAMS= -melf_i386

objects= loader.o kernel.o

%.o: %.cpp 							# .cpp编译为.o
	g++ $(GRAPPPARAMS) -o $@ -c $<
%.o: %.s							# .s编译为.o
	as $(ASPARAMS) -o $@ $<
mykernel.bin:linker.ld $(objects)	# 指定linker.ld为链接规则进行链接
	ld $(LDPARAMS) -T $< -o $@ $(objects)
install:mykernel.bin				# 安装（复制）到boot/
	sudo cp $< /boot/mykernel.bin