#Linux基础知识

##基础命令
```bash
man(man man

ls         ls -l    ll  ls -F   ls -a
pwd

which
whereis

mkdir      
touch(umask)
mv
cp
rm
rmdir(rm -rf)

cat
less    
more    b & space
head    head -n
tail    tail -n

df      
du

ln

mount
fdisk

tar
unzip

cut
wc

kill
killall
who
```
##帐号管理的一些命令
```bash
useradd
usermod
userdel

groupadd
groupmod
groupdel

su  su -    su - andy
sudo(visudo)
```

##文件和目录权限
```bash
r  w  x
4  2  1

u  g  o = own group other

umask e.g. 0002
file 666 - umask e.g. 666 - 002 = 664  rw-rw-r (由八进制换算而成)
dir  777 - umask e.g. 777 - 002 = 775  rwxrwxr-x
```
##数据重定向和管道
1. |
2. >> 
3. >
4. <
5. tee（双重定向）

## Shell Script
### Some Commands
1. grep
2. awk
3. sed
