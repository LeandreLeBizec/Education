#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Dec 24 16:45:25 2021

@author: leandre
"""
from random import randint


def initialiserAleatoire(taille, vmin, vmax):
    l = []
    for k in range(taille):
        l.append(randint(vmin, vmax))
    print(l)
    return l


def triListe(l):
    for i in range(len(l)):
        min = i
        for j in range(i + 1, len(l), 1):
            if (l[j] < l[min]):
                min = j
        if (min != i):
            tmp = l[i]
            l[i] = l[min]
            l[min] = tmp
    print(l)


l = initialiserAleatoire(10, 1, 10)
triListe(l)
