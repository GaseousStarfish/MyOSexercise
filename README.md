# MyOSexercise
### 这是一个学习编写操作系统的项目
#### 所有的注释均为utf-8,如果出现乱码请检查
### [学习视频](https://www.youtube.com/watch?v=1rnA6wpF0o4&list=PLHh55M_Kq4OApWScZyPl5HhgsTJS9MZ6M)
## 章节一 hello OS
##### 视频作者修改了grub.cfg文件直接在电脑上运行。
##### 我所使用的VMware Ubuntu Linux 出现了一些故障，修改grub.cfg后重启虚拟机后并不能运行
##### 甚至使我按f12后无法进入选择操作系统的界面（这个问题哪怕我重置了grub.cfg也未能得到修复）
##### 所以我使用了qemu进行运行，只需要```qemu-system-i386 -kernel /path/mykernel.bin```  
##### 当然这不太美观，helo word会将原本的字覆盖一部分，你可以选择在其他映射屏幕的内存中进行输出
#### 第二个视频为第一个视频的补充，修补了遗漏的地方，调用了所有init_array函数，
##### 但是所写的for循环中应该为 i！=&end_ctor,比较的应该是地址 