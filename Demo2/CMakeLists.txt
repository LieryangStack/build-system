# Cmake 最低版本号要求
cmake_minimum_required(VERSION 2.8)

# 项目信息
project(Demo2)

# 查找当前目录下的所有源文件
# 并将名称保存到 DIR_SRCS 变量
aux_source_directory(. DIR_SRCS)

# 指定生成目标
# 方式一：直接写入所有要编写的源文件 add_executable(Demo main.cpp MathFunctions.cpp)
# 方式二：
add_executable(Demo2 ${DIR_SRCS})
