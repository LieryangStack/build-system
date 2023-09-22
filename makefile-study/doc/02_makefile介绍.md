# makefile介绍

## 1 Makefile文件是什么
&emsp;&emsp;可以简单的认为是一个工程文件的编译规则，描述了整个工程的编译和链接规则。其中包含了那些文件需要编译，那些文件不需要编译，那些文件需要先编译，那些文件需要后编译，那些文件需要重建等等。编译整个工程需要涉及到的，在 Makefile 中都可以进行描述。换句话说，Makefile 可以使得我们的项目工程的编译变得自动化，不需要每次都手动输入一堆源文件和参数。

## 2 Makefile的规则
在讲述这个makefile之前，还是让我们先来粗略地看一看makefile的规则。
```bash
target ... : prerequisites ...
    recipe
    ...
    ...
```
 - **target**：可以是一个object file（`目标文件`），也可以是一个`可执行文件`，还可以是一个`标签`（label）。对于标签这种特性，在后续的“伪目标”章节中会有叙述。**后面的介绍中要注意这三种target的不同**。
 - **prerequisites**：生成该target所依赖的文件和/或target
 - **recipe**：该target要执行的命令（任意的shell命令）
  
这是一个文件的依赖关系，也就是说，target这一个或多个的目标文件依赖于prerequisites中的文件，其生成规则定义在command中。（如果prerequisites中的是其他规则中的target，其他规则也会执行）说白一点就是说:

>prerequisites中如果有一个以上的文件比target文件要新的话，recipe所定义的命令就会被执行。

这就是makefile的规则，也就是makefile中最核心的内容。


### 2.1 单个源文件示例 
新建sample1文件夹，创建一个hello.c和Makefile文件。在Makefile文件编写一下内容：
```makefile
#是注释
#第一层：显式规则
#目标文件：依赖文件
#[TAB]指令
#
# 第一个目标文件是我的最终目标
#
# rm -rf hello.o hello.s hello.i hello
# 伪目标 .PHONY:
# .PHONY: hello
hello:hello.o
	gcc hello.o -o hello
hello.o:hello.s
	gcc -c hello.s -o hello.o
hello.s:hello.i
	gcc -S hello.i -o hello.s
hello.i:hello.c
	gcc -E hello.c -o hello.i

.PHONY: clear
.PHONY: clearall

clearall:
	rm -rf hello.o hello.s hello.i
clear:
	rm -rf hello
```

伪目标更多知识点会在后续讲到。这个[示例](../sample1/Makefile)中hello也可以理解为一个伪目标，如果只输入`make`命令，Makefile默认执行第一个规则（第一个伪目标）。

```bash
make #make hello
```


### 2.2 多个源文件示例

正如前面所说，如果一个工程有3个头文件和8个C文件，为了完成前面所述的那三个规则，我们的makefile 应该是下面的这个样子的。

```makefile
edit : main.o kbd.o command.o display.o \
        insert.o search.o files.o utils.o
    cc -o edit main.o kbd.o command.o display.o \
        insert.o search.o files.o utils.o

main.o : main.c defs.h
    cc -c main.c
kbd.o : kbd.c defs.h command.h
    cc -c kbd.c
command.o : command.c defs.h command.h
    cc -c command.c
display.o : display.c defs.h buffer.h
    cc -c display.c
insert.o : insert.c defs.h buffer.h
    cc -c insert.c
search.o : search.c defs.h buffer.h
    cc -c search.c
files.o : files.c defs.h buffer.h command.h
    cc -c files.c
utils.o : utils.c defs.h
    cc -c utils.c
clean :
    rm edit main.o kbd.o command.o display.o \
        insert.o search.o files.o utils.o
```


反斜杠（ `\` ）是换行符的意思。这样比较便于makefile的阅读。我们可以把这个内容保存在名字为“makefile”或“Makefile”的文件中，然后在该目录下直接输入命令 `make` 就可以生成执行文件edit。如果要删除可执行文件和所有的中间目标文件，那么，只要简单地执行一下 `make clean` 就可以了。

在这个makefile中，目标文件（target）包含：可执行文件edit和中间目标文件（ `*.o` ），依赖文件（prerequisites）就是冒号后面的那些 `.c` 文件和 `.h` 文件。每一个 `.o` 文件都有一组依赖文件，而这些 `.o` 文件又是可执行文件 `edit` 的依赖文件。依赖关系的实质就是说明了目标文件是由哪些文件生成的，换言之，目标文件是哪些文件更新的。

在定义好依赖关系后，后续的recipe行定义了如何生成目标文件的操作系统命令，一定要以一个 `Tab` 键作为开头。记住，make并不管命令是怎么工作的，他只管执行所定义的命令。make会比较targets文件和prerequisites文件的修改日期，如果prerequisites文件的日期要比targets文件的日期要新，或者target不存在的话，那么，make就会执行后续定义的命令。

这里要说明一点的是， `clean` 不是一个文件，它只不过是一个动作名字，有点像C语言中的label一样，其冒号后什么也没有，那么，make就不会自动去找它的依赖性，也就不会自动执行其后所定义的命令。要执行其后的命令，就要在make命令后明显得指出这个label的名字。这样的方法非常有用，我们可以在一个makefile中定义不用的编译或是和编译无关的命令，比如程序的打包，程序的备份，等等。



### 例子讲解

创建一个包含有多个源文件和Makefile的目录文件，源文件之间相互关联。在Makefile中添加下面代码：
```
main: main.o test1.o test2.o
	gcc main.o test1.o test2.o -o main
main.o : main.c test.h
	gcc -c main.c -o main.o
test1.o : test1.c test.h
	gcc -c test1.c -o test1.o
test2.o : test2.c test.h
	gcc -c test2.c -o test2.o
```


`：`左边是目标文件，右边是依赖文件。默认情况下make执行的是Makefile文件中的第一个规则（Makefile中出现的第一个依赖关系），此规则的第一目标称之为“最终目标”或者是“终极目标”。

因为第一个规则是最终目标，Makefile系统会检查第一个目标的依赖是否是其他规则的目标，如果是先执行其他目标。最后执行最终目标。

所以先执行 
```bash
# 编译
gcc -c main.c -o main.o
gcc -c test1.c -o test1.o
gcc -c test2.c -o test2.o
```
最后执行
```bash
# 链接
gcc main.o test1.o test2.o -o main
```

**为什么依赖中会有头文件？**

答：该源码所含有的头文件，有些源码的头文件是根据某些规则生成的，所以要写在依赖项里面。编译过程要提供头文件路径，链接过程不需要提供头文件路径。


## 3 make是如何工作的

在默认的方式下，也就是我们只输入 `make` 命令。那么，

 1. make会在当前目录下找名字叫“Makefile”或“makefile”的文件。

 2. 如果找到，它会找文件中的第一个目标文件（target），在上面的例子中，他会找到“edit”这个文件，并把这个文件作为最终的目标文件。
 
 3. 如果edit文件不存在，或是edit所依赖的后面的 `.o` 文件的文件修改时间要比 `edit` 这个文件新，那么，他就会执行后面所定义的命令来生成 `edit` 这个文件。
  
 4. 如果 `edit` 所依赖的 `.o` 文件也不存在，那么make会在当前文件中找目标为 .o 文件的依赖性，如果找到则再根据那一个规则生成 `.o` 文件。（这有点像一个堆栈的过程）
 
 5. 当然，你的C文件和头文件是存在的啦，于是make会生成 `.o` 文件，然后再用 `.o` 文件生成make的终极任务，也就是可执行文件 `edit` 了。

这就是整个make的依赖性，make会一层又一层地去找文件的依赖关系，直到最终编译出第一个目标文件。在找寻的过程中，如果出现错误，比如最后被依赖的文件找不到，那么make就会直接退出，并报错，而对于所定义的命令的错误，或是编译不成功，make根本不理。make只管文件的依赖性，即，如果在我找了依赖关系之后，冒号后面的文件还是不在，那么对不起，我就不工作啦。

通过上述分析，我们知道，像clean这种，没有被第一个目标文件直接或间接关联，那么它后面所定义的命令将不会被自动执行，不过，我们可以显示要make执行。即命令—— `make clean` ，以此来清除所有的目标文件，以便重编译。

于是在我们编程中，如果这个工程已被编译过了，当我们修改了其中一个源文件，比如 `file.c` ，那么根据我们的依赖性，我们的目标 `file.o` 会被重编译（也就是在这个依性关系后面所定义的命令），于是 `file.o` 的文件也是最新的啦，于是 `file.o` 的文件修改时间要比 `edit` 要新，所以 `edit` 也会被重新链接了（详见 `edit` 目标文件后定义的命令）。

而如果我们改变了 `command.h` ，那么， `kdb.o` 、 `command.o` 和 `files.o` 都会被重编译，并且， `edit` 会被重链接。

>重新学习Makefile过程中，让我想起了，









# 3 清除工作目录中的过程文件
&emsp;&emsp;其中clean是一个目标，它是独立的，不会与第一个目标文件相关联，所以我们在执行make的时候也不会执行下面的命令。在shell中执行“make clean”命令，编译时的中间文件和生成的最终目标文件都会被清除，方便我们下次使用。
```
.PHONY:clean
clean:
	rm -rf *.o main
```
# 4 变量的定义和使用
Makefile文件中定义变量的基本语法如下: 变量名称=值列表。调用变量的时候可以用" $(VALUE_LIST) " 或者 ${VALUE_LIST}。

```
OBJS=main.o add.o minus.o
TARG=test
$(TARG):$(OBJS)
	gcc $(OBJS) -o $(TARG)
```

| 符合 |含义  |
|--|--|
|简单赋值（:=）|编程语言中常规理解的赋值方式，只对当前语句的变量有效|
|递归赋值（=）|赋值语句可能影响多个变量，所有目标变量相关的其他变量都受影响|
|条件赋值（?=）|如果变量未定义，则使用符号中的值定义变量（如果变量已赋值，则赋值语句无效）|
|追加赋值（+=）|原变量用空格隔开的方式追加一个新值|

## 4.1 简单赋值

```
# Makefile
x:= foo
y:= $(x)b

x:= new
test:
        @echo "y = $(y)"
        @echo "x = $(x)"

```
输出结果

```bash
y = foob
x = new
```
## 4.2 递归赋值
```
x= foo
y= $(x)b

x= new
test:
        @echo "y = $(y)"
        @echo "x = $(x)"
```
输出结果
```c
y = newb
x = new
```
## 4.3 条件赋值
```
x:= foo
y:= $(x)b

x?= new
test:
        @echo "y = $(y)"
        @echo "x = $(x)"
```
输出结果

```bash
y = foob
x = foo
```
## 4.4 追加赋值

```
x:= foo
y:= $(x)b
x+= $(y)
test：
      @echo "y = $(y)"
      @echo "x = $(x)"
```
输出结果

```bash
y = foob
x = foo foob
```


# 参考

[参考1：如何系统地学习 Makefile 相关的知识（读/写）？](https://www.zhihu.com/question/23792247/answer/600773044)
[参考2：Makefile变量的定义和使用](http://c.biancheng.net/view/7096.html)
