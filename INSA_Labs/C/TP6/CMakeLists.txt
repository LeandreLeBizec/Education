cmake_minimum_required(VERSION 3.20)
project(TP6 C)

set(CMAKE_C_STANDARD 11)

include_directories(.)

add_executable(TP6
        commun.h
        fichier.c
        fichier.h
        principal.c)
