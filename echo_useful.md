# echo命令介绍

功能说明：显示文字。

语 　 法：echo [-ne][字符串] / echo [--help][--version]

补充说明：echo会将输入的字符串送往标准输出。输出的字符串间以空白字符隔开, 并在最后加上换行号。

参 　 数：

    -n 不要在最后自动换行
    
    -e 打开反斜杠ESC转义。若字符串中出现以下字符，则特别加以处理，而不会将它当成一般文字输出：
    
           \a 发出警告声；
           
           \b 删除前一个字符；
           
           \c 最后不加上换行符号；
           
           \f 换行但光标仍旧停留在原来的位置；
           
           \n 换行且光标移至行首；
           
           \r 光标移至行首，但不换行；
           
           \t 插入tab；
           
           \v 与\f相同；
           
           \\ 插入\字符；
           
           \nnn 插入nnn（八进制）所代表的ASCII字符；
           
    -E 取消反斜杠ESC转义 (默认)
    
    -help 显示帮助
    
    -version 显示版本信息 
    

############################################################
### echo输出颜色文本

echo命令改变样式，以输出不同颜色的文本，必须有 -e 选项(开启echo中的转义)。

文本终端的显示颜色可以使用“ANSI非常规字符序列”来生成。

例如：echo -e "\033[44;37;5m ME\033[0m COOL"

解释："\033[44;37;5m ME "设置背景为蓝色，前景为白色，闪烁光标，输出字符“ME”；

      "\033[0m COOL"重新设置屏幕到缺省设置，输出字符 “COOL”。
      
      "e"是命令echo的一个可选项，它用于激活特殊字符的解析器。"\033"引导非常规字符序列(即"\033["表示终端转义字符开始，"\033"即退出键<ESC>的ASCII码)。"m"意味着设置属性然后结束非常规字符序列，这个例子里真正有效的字符是"44;37;5"和"0"。修改"44;37;5"可以生成不同颜色的组合，数值和编码的前后顺序没有关系。
      
    
    可以选择的编码如下所示(这些颜色是ANSI标准颜色)：
          编码          颜色/动作
          0      　     重新设置属性到缺省设置
          1     　      设置粗体
          2     　      设置一半亮度(模拟彩色显示器的颜色)
          4     　      设置下划线(模拟彩色显示器的颜色)
          5     　      设置闪烁
          7     　      设置反向图象
          22    　      设置一般密度
          24    　      关闭下划线
          25     　     关闭闪烁
          27     　     关闭反向图象
          30      　    设置黑色前景
          31   　       设置红色前景
          32   　       设置绿色前景
          33   　       设置黄色前景
          34   　       设置蓝色前景
          35    　      设置紫色前景
          36     　     设置青色前景
          37    　      设置白色(灰色)前景
          38      　    在缺省的前景颜色上设置下划线
          39      　    在缺省的前景颜色上关闭下划线
          40      　    设置黑色背景
          41      　    设置红色背景
          42     　     设置绿色背景
          43     　     设置黄色背景
          44     　     设置蓝色背景
          45     　     设置紫色背景
          46     　     设置青色背景
          47      　    设置白色(灰色)背景
          49      　    设置缺省黑色背景
          
    其他有趣的代码还有：
          \033[2J  　   清除屏幕
          \033[0q  　   关闭所有的键盘指示灯
          \033[1q 　    设置"滚动锁定"指示灯(Scroll Lock)
          \033[2q 　    设置"数值锁定"指示灯(Num Lock)
          \033[3q 　    设置"大写锁定"指示灯(Caps Lock)
          \033[15:40H   把关闭移动到第15行，40列
          \007  　　    发蜂鸣生beep

一些说明：

    前景颜色各数字是对应背景颜色减去10。
    
    结束非常规字符序列的"m"要紧跟前面的数字，不能有空格。
    
    命令也可以写成echo -e "^[[44;37;5m ME \033[0m COOL"，其中的"^["是先按Ctrl-V,然后再按<ESC>键产生的。

    输出带有颜色的文本，echo命令必须带有选项"-e"。

这种方法只能暂时改变echo命令输出的文本的样式，logout后就恢复为默认。修改.bashrc文件，可以修改默认的显示样式。

如：在.bashrc文件的最后面追加一行：echo -e '\033[47;30m'。

#----------------------------------------------------------

### 建议:在shell文件的最前面，将echo命令的输出样式定义成变量。
1.   define echo terminal style
2.   color: 0~6 --> black, red, green, yellow, blue, purple, cyan, grey
    
    export ECHO_STYLE_00="\033[0m"        # default style(black background, white foreground)
    export ECHO_STYLE_01="\033[41;33;1m"  # red background, yellow foregound bold
    echo -e "${ECHO_STYLE_01}echo command terminal style example${ECHO_STYLE_00}"
    

############################################################
### echo命令的其他用法

1).光标跳到第60列，然后显示一个OK。

    格式：echo -en '\033[60G' && echo OK
    
    说明："\033["是终端转义字符开始，60G是命令。