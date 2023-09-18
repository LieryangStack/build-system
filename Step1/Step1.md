# Step 1: A Basic Starting Point
我应该从哪里开始学习CMake？这一步将介绍CMake的基本语法、命令和变量。随着这些概念的介绍，我们将完成三个练习并创建一个简单的CMake项目。

这一步中的每个练习都将以一些背景信息开始。然后，提供一个目标和有用资源的列表。在“要编辑的文件”部分中的每个文件都位于Step1目录中，包含一个或多个TODO注释。每个TODO代表要更改或添加的一两行代码。TODO应按照数字顺序完成，首先完成TODO 1，然后再完成TODO 2，以此类推。入门指南部分将提供一些有用的提示，并引导您完成练习。然后，“构建和运行”部分将逐步介绍如何构建和测试练习。最后，在每个练习结束时，将讨论预期的解决方案。

还请注意，教程中的每一步都是基于下一步构建的。例如，Step2的起始代码是Step1的完整解决方案。

## Exercise 1 - Building a Basic Project

最基本的CMake项目是通过单个源代码文件构建的可执行文件。对于这样简单的项目，只需一个包含三个命令的CMakeLists.txt文件即可。

注意：虽然CMake支持大写、小写和大小写混合的命令，但推荐使用小写命令，并将在整个教程中使用小写命令。

任何项目的顶层CMakeLists.txt必须通过使用cmake_minimum_required()命令指定最低CMake版本。这会建立策略设置，并确保以下CMake函数在兼容的CMake版本上运行。

为了启动一个项目，我们使用project()命令来设置项目名称。这个调用在每个项目中都是必需的，并应该在cmake_minimum_required()之后尽快调用。正如我们将在后面看到的，这个命令也可以用于指定其他项目级别的信息，如语言或版本号。

最后，add_executable()命令告诉CMake使用指定的源代码文件创建一个可执行文件。

## Goal

了解如何创建一个简单的CMake项目

## Getting Started

tutorial.cxx的源代码位于Help/guide/tutorial/Step1目录中，可以用于计算一个数字的平方根。在这一步中，无需编辑这个文件。

在相同的目录中有一个CMakeLists.txt文件，您将完成它。从TODO 1开始，依次完成TODO 3。

## Build and Run

