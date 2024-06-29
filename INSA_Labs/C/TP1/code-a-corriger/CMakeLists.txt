cmake_minimum_required(VERSION 3.17)
project(code_a_corriger C)

set(CMAKE_C_STANDARD 90)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -pedantic-errors")

add_executable(code_a_corriger main.c)