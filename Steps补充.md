# Steps补充
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