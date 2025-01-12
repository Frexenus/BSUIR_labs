# -*- coding: utf-8 -*-

import pandas as pd
import matplotlib.pyplot as plt
from tqdm import tqdm

from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
from matplotlib.animation import FuncAnimation



# task 6
# Загрузите набор данных ex1data2.txt из текстового файла.
data = pd.read_csv("ex1data2.txt", header=None, sep=",", names=['Area','RoomCount', 'Price'])


print("data head")
print(data.head())

def show_plot():
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    print('initial data')
    ax.scatter(data.RoomCount, data.Area, data.Price, c='r', marker='o')
    ax.set_xlabel('X Area')
    ax.set_ylabel('Y RoomCount')
    ax.set_zlabel('Z Price')
    plt.show()


show_plot()

# task 7.1
# Произведите нормализацию признаков.


df = data
normalized_data = (df - df.min()) / (df.max() - df.min())
print("normalized head")
print(normalized_data.head())

# task 7.2

# Повлияло ли это на скорость сходимости градиентного спуска? Ответ дайте в виде графика.
# ответ, да. без нормализации нет сходимости. коэффициенты выходят за вычислительный диапазон
# скорость с нормализацией 150it, без нормализации inf


# task 8
# Реализуйте функции потерь J(θ) и градиентного спуска для случая многомерной линейной регрессии

# Regular Gradient
def Gradient(data, tetha_start = [1,1,1], alpha = -0.01, iterations = 150):
    tetha = np.array(tetha_start)
    tethas_history = [np.array(tetha_start)]
    costs = []
    x = np.array(data.iloc[:, 0:2])
    x1 = np.array(data.RoomCount)
    x2 = np.array(data.Area)
    y_actual = np.array(data.Price)
    for i in range(iterations):

        theroyes = [tetha[0] * x1_actual + x2_actual * tetha[1] + tetha[2] for x1_actual, x2_actual in zip(x1, x2)]
        sum_diff_x1 = 0
        sum_diff_x2 = 0
        sum_diff_b = 0
        for y_theory, y_actual, x1_actual, x2_actual in zip(theroyes, data.Price, data.RoomCount, data.Area):
            sum_diff_x1 += (y_theory - y_actual) * x1_actual * 2 / len(theroyes)
            sum_diff_x2 += (y_theory - y_actual) * x2_actual * 2 / len(theroyes)
            sum_diff_b += 2 * (y_theory - y_actual) / len(theroyes)
        sum_diff_x1 *= alpha
        sum_diff_x2 *= alpha
        sum_diff_b *= alpha
        tetha = [tetha[0] + sum_diff_x1, tetha[1] + sum_diff_x2, tetha[2] + sum_diff_b]
        tethas_history.append(tetha)
        y_theory = x.dot(tetha[0:2]) + tetha[2]
        j = 0.5 * ((y_theory - y_actual).T).dot((y_theory - y_actual))/len(y_theory)
        costs.append(j)
    print('regular cost function')
    plt.plot(range(len(costs)), costs, 'ro')
    print("costs head(last 5)")
    print(costs[:5])
    print("costs tail(last 5)")
    print(costs[-5:])
    plt.show()
    print("koefs")
    print(tethas_history[-1])
    return tethas_history
print("normalized_data cost function")



tetha = Gradient(normalized_data)

print("denormalized_data cost function")
Gradient(data, iterations=1500)

def ShowGradientResult(data, feature, tetha, tetha_ind, indicator ='b-'):
    x = np.arange(0, 1, 0.01)
    k = tetha[0]
    b = tetha[2]
    y = [i * k + b for i in x]
    print("result linear function model")
    plt.plot(x, y, indicator)




def ShowAnimatedGradientResult(data, feature, tetha, tetha_ind):
    fig = plt.figure()
    ax = plt.axes(xlim=(0, 4), ylim=(-2, 2))

    normalized_data.plot.scatter(x=feature, y='Price', c='DarkBlue')
    plt.grid()
    plt.axis('equal')
    x = np.arange(0, 1, 0.01)
    k = tetha[0][0]
    b = tetha[0][2]
    y = [i * k + b for i in x]
    print("result linear function model")
    line, = plt.plot(x, y, 'b-')

    def animate(i):
        x = np.arange(0, 1, 0.01)
        k = tetha[i][0]
        b = tetha[i][2]
        y = [i * k + b for i in x]
        line.set_data(x, y)
        return line,

    anim = FuncAnimation(fig, animate, frames=len(tetha), interval=20, blit=True, repeat=False)

    plt.show()
    plt.cla()
    plt.clf()
    plt.close()


ShowAnimatedGradientResult(normalized_data, 'Area', tetha, 1)
ShowAnimatedGradientResult(normalized_data, 'RoomCount', tetha, 0)


# vectorized descent
# task 8.2
# градиентного спуска для случая многомерной линейной регрессии с использованием векторизации.

def VectorizedGradient(X, Y, theta, iterations=150, alpha=-0.01):
    thetas = [theta]
    costs = []
    for i in range(iterations):
        theta += alpha * ((X.dot(theta) - Y).T.dot(X)).T / len(Y)
        thetas.append(theta)
        cost = (X.dot(theta) - Y).T.dot(X.dot(theta) - Y) / (2 * len(X))
        if len(costs) == 0 or cost < costs[-1]:
            costs.append(cost)
    print("vectorized cost function")
    plt.plot(range(len(costs)), costs, 'ro')
    print("costs head(last 5)")
    print(costs[:5])
    # task 9 Покажите, что векторизация дает прирост производительности.
    # сходится быстрее при одинаковых параметрах
    print("costs tail(last 5)")
    print(costs[-5:])
    plt.show()
    print("tetha")
    print(thetas[-1])


X = np.array(normalized_data.iloc[:, 0:2])
Y = np.array(normalized_data.Price)
theta = [1, 1]
# task 9
# Покажите, что векторизация дает прирост производительности.

VectorizedGradient(X, Y, theta)


# task 10
# Попробуйте изменить параметр ɑ (коэффициент обучения). Как при этом изменяется график функции потерь в зависимости от числа итераций градиентного спуск? Результат изобразите в качестве графика.


Gradient(normalized_data, alpha = -0.01, iterations = 150)

Gradient(normalized_data, alpha = -0.01, iterations = 1500)

Gradient(normalized_data, alpha = -0.1, iterations = 1500)

analytics_tetha = [0.6, 0.95, 0.0]
normalized_data.plot.scatter(x='RoomCount', y='Price', c='DarkBlue')
plt.grid()
plt.axis('equal')
ShowGradientResult(normalized_data, 'RoomCount', tetha[-1],0)
ShowGradientResult(normalized_data, 'RoomCount', analytics_tetha,0, indicator='r-')
plt.show()


normalized_data.plot.scatter(x='RoomCount', y='Price', c='DarkBlue')
plt.grid()
plt.axis('equal')
ShowGradientResult(normalized_data, 'Area', tetha[-1],1)
ShowGradientResult(normalized_data, 'Area', analytics_tetha,1, 'r-')
plt.show()
# task 11


