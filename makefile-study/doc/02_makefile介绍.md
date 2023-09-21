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
[sample2](../sample2/)

```
└── sample2
    ├── add.c
    ├── main.c
    ├── main.h
    ├── Makefile
    └── minus.c
```


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

&emsp;&emsp;`：`左边是目标文件，右边是依赖文件。默认情况下make执行的是Makefile文件中的第一个规则（Makefile中出现的第一个依赖关系），此规则的第一目标称之为“最终目标”或者是“终极目标”。
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
