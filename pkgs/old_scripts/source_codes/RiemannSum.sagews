import matplotlib.pyplot as plt
import numpy as np

t = var('t')
i = var('i')
points_list = []
k_list = []

def riemann_sum(u,v):
    a = -1
    b = 1
    k = 1
    f = vector([u,v])
    func = norm(diff(f,t))

    while k <=50:
        delta = (b-a)/k
        ti = a +i*delta
        soma = sum(func.subs(t=ti)*delta, i,0,k-1).n()#.n() aproxima os valores irracionais
        points_list.append(soma)
        k_list.append(k)
        k +=1

    x_graph = np.array(k_list)
    y_graph = np.array(points_list)

    exact_value = integral(func,(t,a,b)).n()
    plt.plot(x_graph,y_graph, 'o')
    plt.axhline(y = exact_value, color = 'r', linestyle = '-')
    plt.show()

    return points_list








