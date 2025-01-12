from math import floor
from numpy import *
from GomorianExtensions import isInteger, isIntegers, getIndexOfFirstFloat
from Simplex import Simplex as sms


class Gomorian(object):
    def __init__(self, A, b, c):
        self.A = A
        self.b = b
        self.c = c
        self.m, self.n = A.shape
        self.eps = 0.000001
        self.iteration = 0

    def RefreshParams(self, res):
        self.m, self.n = self.A.shape
        self.A, self.B, self.b, self.c, self.basicIndexes = res.A, res.B, res.b, res.c, res.basicIndexes
        self.nonBasicIndexes, self.n, self.m, self.x = res.nonBasicIndexes, res.n, res.m, res.x
        self.iteration += 1


    def resizeA(self, y):
        alpha = dot(y, self.A)
        alpha = array([round(i) if isInteger(self.eps, i) else i for i in alpha])
        alpha = array([i - floor(i) for i in alpha])
        self.A = vstack([self.A, alpha])
        column = -eye(self.m + 1)[:, self.m]
        self.A = hstack([self.A, column.reshape(self.m + 1, 1)])

    def resizeB(self, y):
        beta = dot(y, self.b)
        beta = beta - floor(beta)
        self.b = append(self.b, [beta])

    def resizeC(self):
        self.c = append(self.c, [0])

    def run(self):
        while True:
            self.RefreshParams(sms(self.A, self.b, self.c).solve())
            if isIntegers(self.eps, self.x):
                return self
            eab = dot(eye(self.m)[:, self.basicIndexes.index(getIndexOfFirstFloat(self.eps, self.x))], self.B)
            self.resizeA(eab)
            self.resizeB(eab)
            self.resizeC()
            print(str(self.iteration)+": "+str(list(self.x)))

    def GetBestPlan(self):
        return str([round(i) for i in self.x])

    def GetBestResult(self):
        return dot(self.c, self.x)

