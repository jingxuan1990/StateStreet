#Linux基础知识

##基础命令
```bash
man(man man)
.
..
ctrl + z(fg)  # 挂起
ctrl + c  # 结束
ctrl + d  # End Of Life

cd         cd .     cd -        cd ..   cd + path
ls         ls -l    ll  ls -F   ls -a
pwd

which     # only search command
whereis   # command, document and so on

mkdir     # mkidr -p + path   
touch(umask)  # touch newfile
mv        # rename or move file, dir
cp        # cp -ap    cp -rf  cp -i
rm        #  rm -rf
rmdir(rm -rf) # remove empty dir

cat
less    
more    # b & space, n N 
head    head -n 10
tail    tail -n 10

df      
du

ln      # ln, ln -s

mount  # mount -t fat32 /mnt/share
umount # umount /mnt/share or umount /dev/sha1
fdisk  # fdisl -l

tar  # tar zcvf  newfile.tar.gz, tar zxvf arch.tar.gz .
unzip  # unzip filename.zip

cut    # cut -f1 -d ':' file
wc     # wc -l, wc -c

kill   # kill process by id
killall  # kill process by name
who    # who is onlining ?

su     # su -    su - andy
sudo(visudo)
```

##文件和目录权限
```bash
r  w  x
4  2  1

u  g  o = own group other

umask  # e.g. 0002
file   # 666 - umask e.g. 666 - 002 = 664  rw-rw-r (由八进制换算而成)
dir    # 777 - umask e.g. 777 - 002 = 775  rwxrwxr-x
```
##数据重定向和管道
```bash
1. |
2. >> 
3. >
4. <
5. tee（双重定向） # screen or file
6. cat file > /dev/null 2&1 # 2 - right, 1 - error
```

## Shell Script
### Some Commands
1. grep
2. awk
3. sed
