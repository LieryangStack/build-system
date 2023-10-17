# Step 5：Installing and Testing
通常，仅构建可执行文件是不够的，它还应该具备可安装性。使用CMake，我们可以使用install()命令来指定安装规则。在CMake中，为你的构建支持本地安装通常只需要指定一个安装位置以及要安装的目标和文件，这非常简单。
## 1 Exercise 1 - Install Rules

### 1.1 Goal

安装Tutorial可执行文件和MathFunctions库

### 1.2 Getting Started

在Step5目录中提供了初始代码。在这个练习中，请完成TODO 1到TODO 4。

首先，更新MathFunctions/CMakeLists.txt文件，将MathFunctions和tutorial_compiler_flags库安装到lib目录中。在同一文件中，指定安装规则以将MathFunctions.h安装到include目录中。

然后，更新顶层的CMakeLists.txt文件，将Tutorial可执行文件安装到bin目录中。最后，任何头文件都应安装到include目录中。请记住，TutorialConfig.h位于PROJECT_BINARY_DIR中。

### 1.3 Build and Run


创建一个名为Step5_build的新目录。运行cmake可执行文件或cmake-gui来配置项目，然后使用你选择的构建工具构建它。

然后，通过在命令行中使用cmake命令的--install选项（引入自CMake 3.15，较旧版本的CMake必须使用make install）来运行安装步骤。这一步将安装适当的头文件、库和可执行文件。例如：

```bash
cmake --install .
```

对于多配置工具，请不要忘记使用--config参数来指定配置。

```bash
cmake --install . --config Release
```

如果使用集成开发环境（IDE），只需构建INSTALL目标。你也可以从命令行中构建相同的install目标，如下所示：


```bash
cmake --build . --target install --config Debug
```

CMake变量CMAKE_INSTALL_PREFIX 用于确定文件将被安装到的根目录。如果使用cmake --install命令，安装前缀可以通过--prefix参数进行覆盖。例如：

```bash
cmake --install . --prefix "/home/myuser/installdir"
```

### 1.4 Solution

我们项目的安装规则相当简单：

- 对于MathFunctions，我们希望将库和头文件分别安装到lib和include目录。

- 对于Tutorial可执行文件，我们希望将可执行文件和配置的头文件分别安装到bin和include目录。

因此，在MathFunctions/CMakeLists.txt文件的末尾，我们添加如下内容：


```cmake
# TODO 1: MathFunctions/CMakeLists.txt
set(installable_libs MathFunctions tutorial_compiler_flags)
if(TARGET SqrtLibrary)
  list(APPEND installable_libs SqrtLibrary)
endif()
install(TARGETS ${installable_libs} DESTINATION lib)
```


```cmake
# TODO 2: MathFunctions/CMakeLists.tx
install(FILES MathFunctions.h DESTINATION include)
```

可执行文件Tutorial和配置的头文件的安装规则类似。在顶层CMakeLists.txt文件的末尾，我们添加如下内容：

```cmake
# CMakeLists.txt
install(TARGETS Tutorial DESTINATION bin)
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h"
  DESTINATION include
  )
```

## 2 Exercise 2 - Testing Support

CTest提供了一种轻松管理项目测试的方式。通过add_test()命令可以添加测试。尽管本教程没有明确介绍，但CTest与其他测试框架（如GoogleTest）之间存在很大的兼容性。

### 2.1 Goal

### 2.2 Getting Started

### 2.3 Build and Run

### 2.4 Solution



