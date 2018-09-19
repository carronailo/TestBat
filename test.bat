rem 这是注释，推荐使用这种形式
rem ::也可以用作注释，冒号是用来定义标签的，这里利用了冒号并不是合法的标签名称来让整行变为注释，不推荐这种形式，容易混淆

rem 注意，bat文件的编码格式最用食用ANSI，因为通常情况下windows的powershell都是用ANSI，并没有直接支持UTF8
rem 如果需要设置成支持UTF8，可以使用chcp
REM chcp 65001
pause

rem 在一行的开头加上@符号，可以让这一行命令不显示到控制台上，仅显示命令执行的结果
echo "Hello"
@echo "Hello hidden"

@rem echo off可以让这个bat文件里下面的所有命令都不显示在控制台上，都只显示命令执行的结果，对应的echo on可以开启命令显示
@echo off

rem 利用echo.（一个.紧跟在echo后面）可以输出一个空行
echo.

:: 可以使用>将任意字符串输出到文件，但是每一次使用>都会重新写文件，会将以前写过的内容覆盖掉（相当于truncate模式）
echo "输出到文件">test.txt
:: 可以使用>>来对文件进行后续添加（append功能）
echo "这是第二行">>test.txt
rem %n代表调用此bat文件时的参数列表，%1表示第一个参数，%n表示第n个参数，这个n最大只能到9，也就是说最多接收9个参数
rem %0表示bat文件自身，就是执行此bat时使用的命令行命令
rem ./testbat/test.bat 1 “test” 这样的调用里%0就是./testbat/test.bat，%1是1，%2是“test”
rem %*表示从1到9的所有参数组成的序列，一般用在循环里，不会单独使用（单独使用的作用无非是打印出所有接收的参数）
echo %0 %*

pause

rem 用%n表示参数的时候，可以使用~符号来扩展参数内容，不过一般是针对参数内容是文件或者目录的时候
rem %~1 表示扩展第1个参数，扩展参数如下
rem %~1         - 删除引号(")，扩充 %1
rem %~f1        - 将 %1 扩充到一个完全合格的路径名
rem %~d1        - 仅将 %1 扩充到一个驱动器号
rem %~p1        - 仅将 %1 扩充到一个路径
rem %~n1        - 仅将 %1 扩充到一个文件名
rem %~x1        - 仅将 %1 扩充到一个文件扩展名
rem %~s1        - 扩充的路径指含有短名
rem %~a1        - 将 %1 扩充到文件属性
rem %~t1        - 将 %1 扩充到文件的日期/时间
rem %~z1        - 将 %1 扩充到文件的大小
rem %~$PATH:1   - 查找列在 PATH 环境变量的目录，并将 %1 扩充到找到的第一个完全合格的名称。如果环境变量名未被定义，或者没有找到文件，此组合键会扩充到空字符串
rem 可以组合修定符来取得多重结果:
rem %~dp1       - 只将 %1 扩展到驱动器号和路径
rem %~nx1       - 只将 %1 扩展到文件名和扩展名
rem %~dp$PATH:1 - 在列在 PATH 环境变量中的目录里查找 %1，并扩展到找到的第一个文件的驱动器号和路径。
rem %~ftza1     - 将 %1 扩展到类似 DIR 的输出行。
echo %~ftza0

rem pause的作用就是在屏幕上打印一行“Press any key to continue . . .”，当接收到用户输入之后就接着执行后续的命令
pause

rem errorlevel是一个内置变量，用来存储上一行命令执行的结果返回值，一般来说0是正常，1是错误，但是对于不同的命令errorlevel会有不同的含义
echo %errorlevel%

rem title可以改变cmd窗口的标题文字
title "Just for fun"

rem dos的清屏命令
cls

rem color [attr] color命令接收一个两位的十六进制数值作为参数，参数数值的高位对应cmd窗口的背景色，低位对应前景色
rem 数值和颜色的对应关系如下：
rem 0 = 黑色       8 = 灰色
rem 1 = 蓝色       9 = 淡蓝色
rem 2 = 绿色       A = 淡绿色
rem 3 = 湖蓝色     B = 淡浅绿色
rem 4 = 红色       C = 淡红色
rem 5 = 紫色       D = 淡紫色
rem 6 = 黄色       E = 淡黄色
rem 7 = 白色       F = 亮白色
color f0
pause
color 0f
rem 不加参数的情况下，cmd窗口的颜色会恢复默认值
color

rem :用来定义一个标签，然后可以用goto来跳转到这个标签的位置，下面就写了一个死循环
rem :deadlock
rem goto deadlock

rem :eof是内置的一个标签，代表bat文件的结尾，如果使用goto :eof命令就会直接结束这个bat的执行，存在一个例外就是定义子过程
rem goto :eof

rem start命令是个dos命令，调用windows系统的其他功能的时候用得到
rem start explore c:\

rem assoc和ftype，assoc用来设置“文件扩展名”到“文件类型”的关联，ftype用来设置“文件类型”到“执行程序和参数”的关联
rem assoc
rem assoc .txt
rem assoc .txt=txtfile
rem ftype
rem ftype txtfile
rem ftype txtfile=%SystemRoot%\system32\NOTEPAD.EXE %1

rem pushd命令用来将当前目录跳转到指定目录，并将原本的当前目录记录下来，然后可以通过popd命令恢复原本的当前目录
pushd C:\git
popd

rem call命令用来调用另外的批处理（bat和cmd结尾的文件），也可以调用当前bat文件里定义的子过程
rem 定义子过程以:[label]的标签开头，以goto :eof结尾，然后就可以通过call :label来调用此子过程，
rem 并且可以在call :label后面添加需要传递给子过程的参数，就像单独调用批处理文件一样
call :sub1 test

rem 这里是此bat的结束位置，再往下都是定义的子过程
goto :eof

:sub1
echo in sub1 %1
goto :eof