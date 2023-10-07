# Step 2: Adding a Library
在这一点上，我们已经看到了如何使用CMake创建一个基本项目。在这一步中，我们将学习如何在项目中创建和使用库。我们还将看到如何使库的使用成为可选的。

## Exercise 1 - Creating a Library

要在CMake中添加一个库，使用add_library()命令并指定哪些源文件应该组成该库。

与将所有源文件放在一个目录中不同，我们可以使用一个或多个子目录来组织项目。在这种情况下，我们将为我们的库创建一个子目录。在这里，我们可以添加一个新的CMakeLists.txt文件和一个或多个源文件。在顶层CMakeLists.txt文件中，我们将使用add_subdirectory()命令将子目录添加到构建中。

一旦库被创建，就可以使用target_include_directories()和target_link_libraries()将其连接到我们的可执行目标中。

## Goal

增加，然后使用一个库

## Getting Started