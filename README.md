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
suig  sgid

umask  # e.g. 0002
file   # 666 - umask e.g. 666 - 002 = 664  rw-rw-r
dir    # 777 - umask e.g. 777 - 002 = 775  rwxrwxr-x
```
##关于网络和进程命令
```bash
netstat -ano
ps -ef | ps aux
top
ping -c 3
telnet localhost 8088
sleep 10
fg + No.
bg      # restart  a job from back-end
jobs    # show all jobs
```

##开关机命令
```bash
reboot
shutdown -h 0
init 0
init 3 # text mode
init 6 # reboot
init 1 # singleton

## .bash_profile .bashrc
```

##数据重定向和管道
```bash
1. |
2. >> 
3. >
4. <
5. cat file > /dev/null 2&1 # 2 - right, 1 - error
```

## Shell Script
### Some Commands
```bash
exit + code (0-255)
grep -v -i 
awk
sed
```
### Control
```bash

```
### Shell Function
```bash
function(){
   echo "This is my function."
}

# $#, $*, $0, $1 ......
# return -- return the exited code (0-255)
# $?     -- function exited code
# $rtn=`function_name`  -- return the result of function, not exited code
# keyword -- local -- defined local varibles in function
```

### Shell Array
```bash
array=(1 2 3 4 5)

# ${array[*]} --- show all elements
# ${array[index]} -- index from zero begin
# array length = $# - 1
e.g.
function count{
   return $[$# - 1]
}

invoked: count $array
```

