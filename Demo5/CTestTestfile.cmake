# CMake generated Testfile for 
# Source directory: /home/lieryang/Desktop/build-system/Demo5
# Build directory: /home/lieryang/Desktop/build-system/Demo5
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(test_run "demo5" "5" "2")
set_tests_properties(test_run PROPERTIES  _BACKTRACE_TRIPLES "/home/lieryang/Desktop/build-system/Demo5/CMakeLists.txt;43;add_test;/home/lieryang/Desktop/build-system/Demo5/CMakeLists.txt;0;")
add_test(test_usage "demo5")
set_tests_properties(test_usage PROPERTIES  PASS_REGULAR_EXPRESSION "Usage: .* base exponent" _BACKTRACE_TRIPLES "/home/lieryang/Desktop/build-system/Demo5/CMakeLists.txt;46;add_test;/home/lieryang/Desktop/build-system/Demo5/CMakeLists.txt;0;")
add_test(test_5_2 "demo5" "5" "2")
set_tests_properties(test_5_2 PROPERTIES  PASS_REGULAR_EXPRESSION "is 25" _BACKTRACE_TRIPLES "/home/lieryang/Desktop/build-system/Demo5/CMakeLists.txt;51;add_test;/home/lieryang/Desktop/build-system/Demo5/CMakeLists.txt;0;")
subdirs("math")
