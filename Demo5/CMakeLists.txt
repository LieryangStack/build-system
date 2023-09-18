# CMake 最低版本号要求
cmake_minimum_required(VERSION 2.8)

# 项目信息
project(Demo5)

# 加入一个配置文件，用于处理 CMake 对源码的设置
# 该配置文件由config.h.in生成config.h
configure_file( 
    "${PROJECT_SOURCE_DIR}/config.h.in"
    "${PROJECT_BINARY_DIR}/config.h"
)

# 是否使用自己的的 MathFunctions 库
option(USE_MYMATH "use provided math implementation" ON)

# 是否加入 MathFunctions 库
if (USE_MYMATH)
  include_directories("${PROJECT_BINARY_DIR}/math")
  add_subdirectory(math)
  set(EXTRA_LIBS ${EXTRA_LIBS} MathFunctions)
endif (USE_MYMATH)

# 查看当前目录下的所有源文件
# 并将名称保存到 DIR_SRCS 变量
aux_source_directory(. DIR_SRCS)

# 指定生成目标
add_executable(demo5 ${DIR_SRCS})

# 添加链接库
target_link_libraries(demo5 ${EXTRA_LIBS})

# 指定安装路径
install(TARGETS demo5 DESTINATION bin)
install (FILES "${PROJECT_BINARY_DIR}/config.h"
         DESTINATION include)

# 启动测试
enable_testing()

# 测试程序是否成功运行
add_test (test_run demo5 5 2)

# 测试帮助信息是否可以正常提示
add_test (test_usage demo5)
set_tests_properties (test_usage
  PROPERTIES PASS_REGULAR_EXPRESSION "Usage: .* base exponent")

# 测试 5 的平方
add_test (test_5_2 demo5 5 2)

set_tests_properties (test_5_2
 PROPERTIES PASS_REGULAR_EXPRESSION "is 25")
