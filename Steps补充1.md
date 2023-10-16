# Steps补充 1
对于官方课程未涉及到或者没有理解的知识点进行补充

## 1 Step1
### 1.1 set命令

set命令可以设置普通变量、缓存条目、环境变量三种变量的值，分别对应以下三种命令格式。set的值`<value>...`表示可以给变量设置0个或者多个值，当设置多个值时（大于2个），多个值会通过分号连接符连接成一个真实的值赋值给变量，当设置0个值时，实际上是把变量变为未设置状态，相当于调用unset命令。

```cmake
# [PARENT_SCOPE]是该命令的参数，去掉方括号直接使用该参数
set(<variable> <value>... [PARENT_SCOPE]) #设置普通变量
 
set(<variable> <value>... CACHE <type> <docstring> [FORCE]) #设置缓存条目
 
set(ENV{<variable>} [<value>]) #设置环境变量
```

太多了！！！直接参考[cmake命令之set](https://blog.csdn.net/sinat_31608641/article/details/123101969)

### 1.2 target_include_directories

该命令可以指定目标(exe或者so文件)需要包含的头文件路径

`<target>`必须是由add_executable()或者add_library()之类的命令创建的，并且不能是ALIAS目标。通过显式地使用AFTER或者BEFORE，就可以在附加和预挂之间进行选择，而不是依赖默认值。

```cmake
target_include_directories(<target> [SYSTEM] [AFTER|BEFORE]
  <INTERFACE|PUBLIC|PRIVATE> [items1...]
  [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
```

具体详细信息可以参考

[1.cmake命令之target_include_directories](https://blog.csdn.net/sinat_31608641/article/details/121713191)

[2.cmake中 target_include_directories的用法](https://blog.csdn.net/weixin_45935219/article/details/120655782)

## 2 Step2

### 2.1 add_library

```cmake
add_library(<name> [STATIC | SHARED | MODULE]
            [EXCLUDE_FROM_ALL]
            [<source>...])
```

[参考1.CMake的add_library与target_link_libraries](https://blog.csdn.net/sinat_31608641/article/details/121736503)

### 2.2 add_subdirectory

该命令是添加一个子目录并构建该子目录，命令格式为

```cmake
add_subdirectory (source_dir [binary_dir] [EXCLUDE_FROM_ALL])
```

命令解析

- source_dir
  
  **必选参数**。该参数指定一个子目录，子目录下应该包含CMakeLists.txt文件和代码文件。子目录可以是相对路径也可以是绝对路径，如果是相对路径，则是相对当前目录的一个相对路径。

- binary_dir
  
  **可选参数**。该参数指定一个目录，用于存放输出文件。可以是相对路径也可以是绝对路径，如果是相对路径，则是相对当前输出目录的一个相对路径。如果该参数没有指定，则默认的输出目录使用source_dir。

- EXCLUDE_FROM_ALL
  
  **可选参数**。当指定了该参数，则子目录下的目标不会被父目录下的目标文件包含进去，父目录的CMakeLists.txt不会构建子目录的目标文件，必须在子目录下显式去构建。例外情况：当父目录的目标依赖于子目录的目标，则子目录的目标仍然会被构建出来以满足依赖关系（例如使用了target_link_libraries）。

[参考1.Cmake命令之add_subdirectory](https://blog.csdn.net/sinat_31608641/article/details/122660652)

## 3 Step3

### 3.1 list

cmake的list命令即对列表的一系列操作，cmake中的列表变量是用分号;分隔的一组字符串，创建列表可以使用set命令（参考set命令），例如：set (var a b c d)创建了一个列表 "a;b;c;d"，而set (var "a b c d")则是只创建了一个变量"a c c d"。list命令的具体格式根据子命令不同会有所区别。

下面是list提供的命令

```cmake
list(LENGTH <list><output variable>)
list(GET <list> <elementindex> [<element index> ...]<output variable>)
list(APPEND <list><element> [<element> ...])
list(FIND <list> <value><output variable>)
list(INSERT <list><element_index> <element> [<element> ...])
list(REMOVE_ITEM <list> <value>[<value> ...])
list(REMOVE_AT <list><index> [<index> ...])
list(REMOVE_DUPLICATES <list>)
list(REVERSE <list>)
list(SORT <list>)
```

我们可以看到，list命令的格式如下

```cmake
list (subcommand <list> [args...])
```

subcommand为具体的列表操作子命令，例如读取、查找、修改、排序等。<list>为待操作的列表变量，[args...]为对列表变量操作需要使用的参数表，不同的子命令对应的参数也不一致。

```cmake
ENGTH　　　　   　　　　 返回list的长度
 
GET　　　　　　    　　　　返回list中index的element到value中
 
APPEND　　　　    　　　　添加新element到list中
 
FIND　　　　　　   　　　　返回list中element的index，没有找到返回-1
 
INSERT 　　　　　　　　　 将新element插入到list中index的位置
 
REMOVE_ITEM　　　　　　从list中删除某个element
 
REMOVE_AT　　　　　　　从list中删除指定index的element
 
REMOVE_DUPLICATES       从list中删除重复的element
 
REVERSE 　　　　　　　　将list的内容反转
 
SORT 　　　　　　　　　　将list按字母顺序排序
```

[参考1.cmake命令之list](https://blog.csdn.net/sinat_31608641/article/details/123101692)

### 3.2 CMake编译标志简要
以下是一些常用的CMake编译标志的简要说明：

- CMAKE_BUILD_TYPE：指定项目的构建类型。可能的值包括Debug、Release、RelWithDebInfo和MinSizeRel。

- CMAKE_C_COMPILER和CMAKE_CXX_COMPILER：指定用于编译C和C++代码的编译器。

- CMAKE_C_FLAGS和CMAKE_CXX_FLAGS：指定编译C和C++代码时使用的编译器选项。

- CMAKE_EXE_LINKER_FLAGS：指定链接可执行文件时使用的链接器选项。

- CMAKE_INSTALL_PREFIX：指定安装目标的根目录。

- CMAKE_MODULE_PATH：指定要搜索的CMake模块的目录。

- CMAKE_PREFIX_PATH：指定要搜索的库文件和头文件的目录。

- CMAKE_VERBOSE_MAKEFILE：设置为ON时，会在编译过程中打印所有命令。

这些编译标志可以在CMakeLists.txt文件中使用set命令来设置，或者在<span style="background-color: pink;">命令行中使用-D选项</span>来设置。例如，要将CMAKE_BUILD_TYPE设置为Debug，可以使用以下命令：

```bash
cmake -DCMAKE_BUILD_TYPE=Debug
```

在CMakeLists.txt文件中：

```cmake
set(CMAKE_BUILD_TYPE Debug)
```

此外，还有许多其他的CMake编译标志可用，它们的作用各不相同。例如：

- CMAKE_C_STANDARD：指定C语言的标准版本，如C11。

- CMAKE_CXX_STANDARD：指定C++语言的标准版本，如C++11。

- CMAKE_POSITION_INDEPENDENT_CODE：将其设置为ON，则生成的代码将是位置独立的，可以在动态链接库中使用。

- CMAKE_SKIP_INSTALL_ALL_DEPENDENCY：将其设置为ON，则在安装项目时会跳过所有依赖项的安装。

### 3.3 target_compile_definitions

target_compile_definitions是CMake中的一个内置命令，用于向特定目标的编译器添加定义。它的语法如下：

```cmake
target_compile_definitions(<target> [INTERFACE|PUBLIC|PRIVATE] [items1...] [items2...] ...)
```

>其中，`<target>`是要添加定义的目标的名称。接下来的三个参数都是可选的，用于指定定义的可见性。

**INTERFACE**：这些定义对于目标的所有用户都是可见的。

**PUBLIC**：这些定义对于目标的所有用户和目标的所有依赖项都是可见的。

**PRIVATE**：这些定义仅对于目标内部是可见的，对于目标的所有用户和依赖项都是不可见的。

后面的参数是一系列的定义，可以是字符串或者变量。这些定义会被添加到目标的编译器选项中，在编译目标时会生效。


例如，假设我们有一个叫做mylib的库目标，要为它添加一个名为MY_DEFINITION的定义，可以这样写：

```camke
target_compile_definitions(mylib PRIVATE MY_DEFINITION)
```

这会导致在编译mylib时添加-DMY_DEFINITION编译器选项。

target_compile_definitions命令可以在CMakeLists.txt文件中使用，也可以在使用add_definitions命令之后使用。

例如，假设我们有一个库目标mylib和一个可执行文件目标myapp，要为这两个目标添加定义，可以这样写：

```camke
add_definitions(-DGLOBAL_DEFINITION)

target_compile_definitions(mylib PRIVATE MY_DEFINITION)

target_compile_definitions(myapp PRIVATE MY_DEFINITION)
```

这会导致在编译mylib和myapp时添加-DGLOBAL_DEFINITION和-DMY_DEFINITION编译器选项。

注意，如果使用add_definitions命令添加的定义对于所有目标都是可见的，那么使用target_compile_definitions命令添加的定义将被覆盖。

### 3.4 target_compile_features

**target_compile_features**：是CMake中的一个命令，用于为CMake目标指定所需的C++编译特性。这个命令用于告诉CMake编译器需要满足的最低C++标准以及其他编译特性。