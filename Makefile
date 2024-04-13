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

mykernel.iso:mykernel.bin			# 生成光盘镜像                        
# 生成目录结构
	mkdir iso
	mkdir iso/boot					
	mkdir iso/boot/grub	
# 拷贝bin3
	sudo cp $< iso/boot/	
	echo 'set timeout=0'>> iso/boot/grub/grub.cfg   #写入grub.cfg
	echo 'set default=0'>> iso/boot/grub/grub.cfg
	echo ''>> iso/boot/grub/grub.cfg
	echo 'menuentry "My Operating System"{'>> iso/boot/grub/grub.cfg
	echo '	multiboot /boot/mykernel.bin'>> iso/boot/grub/grub.cfg
	echo '	boot'>> iso/boot/grub/grub.cfg
	echo '}'>> iso/boot/grub/grub.cfg
#echo ''>> iso/boot/grub/grub.cfg
# 生存镜像
	grub-mkrescue --output=$@ iso
# 清理iso
	rm -rf iso

clean:
	rm -rf kernel.o loader.o mykernel.bin mykernel.iso
run:mykernel.iso
#启动虚拟机
	(killall VirtualBoxVM&& sleep 1) || true
	VBoxManage startvm "MyOS" &
