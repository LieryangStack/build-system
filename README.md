# build-system
常用构建系统学习

## 1 前言
### 1.1 什么是构建系统？

构建系统(build system)是用来从源代码生成用户可以使用的目标(targets)的自动化工具。目标可以包括库、可执行文件、或者生成的脚本等等。

**构建系统的需求是随着软件规模的增大而提出的**。如果只是做软件编程训练，通常代码量比较小，编写的源代码只有几个文件。比如你编写了一段代码放入helloworld.c文件中，要编译这段代码，只需要执行以下命令：gcc helloworld.c

### 1.2 为什么需要构建系统？

当软件规模逐渐增加，这时可能有几十个源代码文件，而且有了模块划分，有的要编译成静态库，有的要编译成动态库，最后链接成可执行代码，这时命令行方式就捉襟见肘，需要一个构建系统。常见的构建系统有GNU Make。需要注意的是，构建系统并不是取代gcc这样的工具链，而是定义编译规则，最终还是会调用工具链编译代码。

当软件规模进一步扩大，特别是有多平台支持需求的时候，编写GNU Makefile将是一件繁琐和乏味的事情，而且极容易出错。这时就出现了生成Makefile的工具，比如CMake、AutoMake等等，这种构建系统称作元构建系统（Meta-Build System）。

## 1.3 常见的构建系统（Build System）
  - **Make (GNU Make, BSD Make)**： Make可以追溯到1976年，属于最早的构建系统，在类Unix系统上比较常用。在类Unix系统上，大多数C++的项目代码是通过编写或生成Makefile进行编译构建的。

    <span style="background-color: lightblue;">问题1：直接编写Makefile，复杂且难以阅读，维护困难；项目规模比较大的C++项目尤甚。</span>

    <span style="background-color: lightblue;">问题2： 构建速度相对较慢。笔者常常听人提到“CMake编译速度慢”，CMake表示“这锅我不背”，CMake默认的Build Backend是Make。</span>

  - **Ninja**：Google的一名程序员推出的注重速度的构建工具，是一个专注于速度的小型构建系统。最初是为了对Chromium、Swift等进行快速编译构建，用来替代GNU Make。设计哲学是通过包含描述依赖关系图的方式提供快速的构建。一般作为元构建系统工具的Build Backend。

  - **Bazel**：Bazel是Google内部构建系统Blaze的子集。很久以前，Google使用大的，生成的Makefile来构建软件。这导致构建的速度慢而且不可靠，开始干扰开发人员的生产率和公司的敏捷度。因此，Google工程师创造了Bazel。Bazel优点很明显，缺点也很致命，并不适合大多数公司。考虑到部分同事是bazel的拥趸，笔者这里并不多讲，具体参阅下面的链接《寻找Google的Blaze》和《为什么google bazel构建工具流行不起来》。

  - **Scons**：Scons是一个Python写的自动化构建工具，从构建这个角度说，它跟GNU Make是同一类的工具。它是一种改进，并跨平台的GNU Make替代工具，其集成功能类似于autoconf/automake 。Scons自动配置功能弱（跨平台能力不足），构建速度慢。

## 1.4 元构建系统（Meta-Build System）

一个生成其他构建系统的构建系统。如：cmake + make, cmake + ninja, meson + ninija等等

- **CMake**：CMake是Kitware公司为了解决ITK软件跨平台构建的需求而设计出来的，后来VTK也用上了CMake。CMake是一个元构建系统工具，支持多种语言，多种Build Backend（Make，Ninjia，Visual Studio，Xcode等）。

- **Meson**：Meson 是一个开源的构建系统和构建定义语言，旨在简化和加速软件项目的构建过程。它最初由 Jussi Pakkanen 创建，目前由社区维护和开发。Meson 主要用于构建 C、C++、Rust 和其他编程语言的项目，它的设计注重性能、可维护性和跨平台支持。

