# Steps补充5-

对于官方课程未涉及到或者没有理解的知识点进行补充

## 1 Step5

### 1.1 install

install命令为项目生成一系列的安装规则。在执行make install时，所指定的安装规则会被依次执行，最终将目标文件（so,exe,其他文件等）复制到指定的路径下。

**目标文件的安装**

```cmake
install(TARGETS targets... [EXPORT <export-name>]
        [[ARCHIVE|LIBRARY|RUNTIME|FRAMEWORK|BUNDLE|
          PRIVATE_HEADER|PUBLIC_HEADER|RESOURCE]
         [DESTINATION <dir>]
         [INCLUDES DESTINATION [<dir> ...]]
         [PERMISSIONS permissions...]
         [CONFIGURATIONS [Debug|Release|...]]
         [COMPONENT <component>]
         [OPTIONAL] [NAMELINK_ONLY|NAMELINK_SKIP]
        ] [...])
```

参数中的 TARGETS 后面跟的就是我们通过 ADD_EXECUTABLE 或者 ADD_LIBRARY 定义的目标文件，可能是可执行二进制、动态库、静态库。

目标类型也就相对应的有三种，ARCHIVE 特指静态库，LIBRARY 特指动态库，RUNTIME
特指可执行目标二进制。

DESTINATION 定义了安装的路径，如果路径以/开头，那么指的是绝对路径，这时候
CMAKE_INSTALL_PREFIX 其实就无效了。如果你希望使用 CMAKE_INSTALL_PREFIX 来
定义安装路径，就要写成相对路径，即不要以/开头，那么安装后的路径就是
${CMAKE_INSTALL_PREFIX}/<DESTINATION 定义的路径>

**普通文件的安装**
```cmake
install(<FILES|PROGRAMS> files... DESTINATION <dir>
        [PERMISSIONS permissions...]
        [CONFIGURATIONS [Debug|Release|...]]
        [COMPONENT <component>]
        [RENAME <name>] [OPTIONAL])
```

可用于安装一般文件，并可以指定访问权限，文件名是此指令所在路径下的相对路径。如果
默认不定义权限 PERMISSIONS，安装后的权限为：
OWNER_WRITE, OWNER_READ, GROUP_READ,和 WORLD_READ，即 644 权限 

**非目标文件的可执行程序安装(比如脚本之类)**

```cmake
INSTALL(PROGRAMS files... DESTINATION <dir>
    [PERMISSIONS permissions...]
    [CONFIGURATIONS [Debug|Release|...]]
    [COMPONENT <component>]
    [RENAME <name>] [OPTIONAL])
```

跟上面的 FILES 指令使用方法一样，唯一的不同是安装后权限为:
OWNER_EXECUTE, GROUP_EXECUTE, 和 WORLD_EXECUTE，即 755 权限 

**目录的安装**

```cmake
install(DIRECTORY dirs... DESTINATION <dir>
        [FILE_PERMISSIONS permissions...]
        [DIRECTORY_PERMISSIONS permissions...]
        [USE_SOURCE_PERMISSIONS] [OPTIONAL] [MESSAGE_NEVER]
        [CONFIGURATIONS [Debug|Release|...]]
        [COMPONENT <component>] [FILES_MATCHING]
        [[PATTERN <pattern> | REGEX <regex>]
         [EXCLUDE] [PERMISSIONS permissions...]] [...])
```

[更多详细内容参考：cmake的install](https://blog.csdn.net/sinat_31608641/article/details/122517522)

### 1.2 add_test 

```cmake
add_test(NAME <name> [CONFIGURATIONS [Debug|Release|...]]
           [WORKING_DIRECTORY dir]
           COMMAND <command> [arg1 [arg2 ...]])
```

其中通过NAME关键值指定本测试的名称，可以随意命名，
Debug/Release选项可以控制在不同的编译版本下是否进行测试。
通过WORKING_DIRECTORY可以设置工作路径，command表示可运行程序

比如：

```cmake
add_test (NAME test1 COMMAND main)
```

### 1.3 set_tests_properties

```cmake
# test1 test2 是add_test自定义的NAME后面的变量
set_tests_properties(test1 [test2...] 
PROPERTIES prop1 value1 prop2 value2)
```

你可以不对结果进行检查，但大多数情况下你都需要检查test1的输出结果，可以通过如下：

```cmake
set_tests_properties(test1 PROPERTIES PASS_REGULAR_EXPRESSION "Hello Cmake")
```

