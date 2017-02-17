
import lab1
from numpy import *

# #
m = 3
n = 5
A = array([
    [5.0, 9.0, 1.0, 0.0, 0.0],
    [3.0, 3.0, 0.0, 1.0, 0.0],
    [2.0, 1.0, 0.0, 0.0, 1.0]
])
b = array([45.0, 19.0, 10.0])
c = array([5.0, 6.0, 0.0, 0.0, 0.0])
x_0 = array([0.0, 0.0, 45.0, 19.0, 10.0])
J = array([3, 4, 5])


# пример 1 из задачника
# m = 4  # кол-во видов расходов
# n = 8  # кол-во видов продукции
# A = array([  # массив условий
#     [0.0, 1.0, 4.0, 1.0, 0.0, -3.0, 5.0, 0.0],
#     [1.0, -1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0],
#     [0.0, 7.0, -1.0, 0.0, -1.0, 3.0, 8.0, 0.0],
#     [1.0, 1.0, 1.0, 1.0, 0.0, 3.0, -3.0, 1.0]
# ])
# b = array([6.0, 10.0, -2.0, 15.0])  # массив расходов
# c = array([-5.0, -2.0, 3.0, -4.0, -6.0, 0.0, -1.0, -5.0])  # массив стоимостей
# x_0 = array([4.0, 0.0, 0.0, 6.0, 2.0, 0.0, 0.0, 5.0])  # начальный план
# J = array([1, 4, 5, 8])  # базисные индексы


lab1.simplex(m, n, A, b, c, x_0, J)