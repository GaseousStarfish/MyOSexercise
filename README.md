# MyOSexercise
### 这是一个学习编写操作系统的项目
### [学习视频](https://www.youtube.com/watch?v=1rnA6wpF0o4&list=PLHh55M_Kq4OApWScZyPl5HhgsTJS9MZ6M)
## 章节一 hello OS
### 视频作者修改了grub.cfg文件直接在电脑上运行，  我所使用的VMware Ubuntu Linux 出现了一些故障，修改grub.cfg后重启虚拟机后并不能运行，甚至使我按f12后无法进入选择操作系统的界面（这个问题哪怕我重置了grub.cfg也未能得到修复）
### 所以我使用了qemu进行运行，只需要 ```qemu-system-i386 -kernel /path/kernel.bin```