# Step 3: Adding Usage Requirements for a Library

## Exercise 1 - Adding Usage Requirements for a Library

目标参数的Usage Requirements允许更好地控制库或可执行文件的链接和包含行，同时还能更好地控制CMake中目标的传递属性。主要利用使用要求的命令包括：

- target_compile_definitions()
- target_compile_options()
- target_include_directories()
- target_link_directories()
- target_link_options()
- target_precompile_headers()
- target_sources()

### 1.1 Goal

为库添加使用要求

### 1.2 Getting Started

在这个练习中，我们将重构我们从"Adding a Library"部分的代码，使用现代CMake的方法。我们将让我们的库定义自己的使用要求，以便根据需要将它们传递给其他目标。在这种情况下，MathFunctions将自己指定所需的包含目录。然后，使用 MathFunctions 的目标对象 Tutorial 只需要链接到 MathFunctions，而不必担心任何额外的包含目录。

起始源代码已经提供在 Step3 目录中。在这个练习中，完成 TODO 1 到 TODO 3。

首先，在 MathFunctions/CMakeLists 中添加一个调用 target_include_directories()。记住，CMAKE_CURRENT_SOURCE_DIR 是当前正在处理的源目录的路径。

然后，在顶级 CMakeLists.txt 中更新（并简化！）对 target_include_directories() 的调用。

### 1.3 Build and Run

创建一个名为Step3_build的新目录，运行cmake可执行文件或者使用cmake-gui来配置项目，然后使用你选择的构建工具构建项目，或者在构建目录中使用"cmake --build ."命令构建项目。以下是在命令行中执行这些步骤的刷新说明：

```bash
mkdir Step3_build
cd Step3_build
cmake ../Step3
cmake --build .
```

接下来，使用新构建的Tutorial并验证它是否按预期工作。

### 1.4 Solution

让我们更新前一步的代码，使用现代CMake的使用要求方法。

我们希望声明任何链接到MathFunctions的人都需要包含当前源目录，而MathFunctions本身则不需要。这可以用INTERFACE使用要求来表示。记住，<span style="background-color: pink;">INTERFACE 表示**使用**该库需要的内容，但编译生成该库则不需要</span>。

在MathFunctions/CMakeLists.txt的末尾，使用target_include_directories()和INTERFACE关键字，如下所示：

```Cmake
# TODO 1: MathFunctions/CMakeLists.txt
target_include_directories(MathFunctions
                           INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
                           )
```

现在，既然我们已经为MathFunctions指定了使用要求，我们可以安全地从顶级CMakeLists.txt文件中删除对EXTRA_INCLUDES变量的使用。

删除这行：


```Cmake
list(APPEND EXTRA_INCLUDES "${PROJECT_SOURCE_DIR}/MathFunctions")
```




```Cmake

```




```Cmake

```



```Cmake

```