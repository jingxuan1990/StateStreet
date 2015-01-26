#!/bin/bash
#提示用户输入命令行参数
echo "1：增加；2：删除；3：更新；4：显示；5：查找；6：退出"
if test ! -z "$1"; then
 if test ! -f "Info.txt"; then
  touch "Info.txt"
  echo -e "ID Name Phone Email Address" >> Info.txt
 fi
fi
declare -i id=0
id=`cat Info.txt | wc -l`
case $1 in
 "1")
 while [ "$quit" != "quit" ]
 do
  read -p "请输入用户Name:" name
  read -p "请输入用户Phone:" phone
  read -p "请输入用户Email:" email
  read -p "请输入用户Address:" address
  echo -e "id$id $name $phone $email $address" >> Info.txt
  id=$(($id+1))
  read -p "输入quit停止增加:" quit
 done
 ;;
 "2")
 read -p "1：为逐条删除 2：批量删除 :" del
 if [ "$del" == "1" ];then
  while [ "$quit" != "quit" ]
  do
   read -p "请输入要删除用户的ID:" delId
    sed -i "/id$delId/d" Info.txt
   read -p "输入quit停止删除:" quit
  done
 elif [ "$del" == "2" ];then
  read -p "请输入开始删除的用户ID：" idStr
  read -p "请输入结束删除用户的ID：" idEnd
   sed -i "/id$idStr/,/id$idEnd/d" Info.txt
 else
  echo "输入参数错误，不能执行删除！"
  exit 1
 fi 
 ;;
 "3")
 read -p "请输入要更新用户的ID：" up
 grep "id$up" Info.txt
        read -p "新Name：" newName
  newName1=` grep "id$up" Info.txt | awk '{print $2}' `
  sed -i -e 's/'$newName1'/'$newName'/g' Info.txt
 read -p "新Phone：" newPhone
  newPhone1=` grep "id$up" Info.txt | awk '{print $3}' `
  sed -i -e 's/'$newPhone1'/'$newPhone'/g' Info.txt
        read -p "新Email：" newEmail
                newEmail1=` grep "id$up" Info.txt | awk '{print $4}' `
                sed -i -e 's/'$newEmail1'/'$newEmail'/g' Info.txt
 read -p "新Address：" newAddress
                newAddress1=` grep "id$up" Info.txt | awk '{print $5}' `
                sed -i -e 's/'$newAddress1'/'$newAddress'/g' Info.txt
  exit 0
 ;;
 "4")
  awk '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5}' Info.txt
 ;;
 "5")
 read -p "1:根据用户ID查找 2：根据正则表达式查找 ：" fd
 if [ "$fd" == "1" ];then
  read -p "请输入要查找的用户ID：" userId
  grep "id$userId" Info.txt
 elif [ "$fd" == "2" ];then
  read -p "请输入正则表达示：" regex
  grep "$regex" Info.txt
 else
  echo "输入参数错误，不能执行查找！"
  exit 1
 fi
 ;;
 "6")
  exit 0
 ;;
 *)
 echo -e "请输入正确的命令(如：$0 1|2|3|4|5|6)"
 ;;
esac

