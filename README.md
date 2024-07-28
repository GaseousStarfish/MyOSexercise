# MyOSexercise
这是一个学习编写操作系统的项目  
所有的注释均为utf-8,如果出现乱码请检查  
[学习视频](https://www.youtube.com/watch?v=1rnA6wpF0o4&list=PLHh55M_Kq4OApWScZyPl5HhgsTJS9MZ6M)

---

## 章节一 hello OS
视频作者修改了grub.cfg文件直接在电脑上运行。  
我所使用的VMware Ubuntu Linux 出现了一些故障，修改grub.cfg后重启虚拟机后并不能运行  
甚至使我按f12后无法进入选择操作系统的界面（这个问题哪怕我重置了grub.cfg也未能得到修复）  
**所以我使用了qemu进行运行，只需要```qemu-system-i386 -kernel /path/mykernel.bin``` **  
当然这不太美观，helo word会将原本的字覆盖一部分，你可以选择在其他映射屏幕的内存中进行输出  

---

**第二个视频为第一个视频的补充，修补了遗漏的地方，调用了所有init_array函数**，  
但是所写的for循环中应该为 ```i！=&end_ctor```,比较的应该是地址   
## 章节二 在虚拟机上运行os
浅浅吐槽一下，因为无法安装在linux虚拟机上的我，研究了一下午如何运行在虚拟机上，没想到第二章就是教学，果然看目录还是很重要的  
视频中的grub已经更新为grub2并且我的ubuntu已经自带无需安装  
**但是有一个很严重的问题，grub-mkrescue失败，解决方法为 ```sudo apt-get install mtools```**  
**同理 sudo apt-get install virtualbox-qt**  
同样makefile里的run改为  
```(killall VirtualBoxVM&& sleep 1) || true```  
```VBoxManage startvm "MyOS" &```  

---

 ## Global Descriptor Table
 这一章写了gdt，但是目前只用了base limit 和界限力度，但是界限粒度没有很清晰的说明。
 