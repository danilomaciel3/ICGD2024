from contextlib import redirect_stdout

t= var('t')

#Defina as funcoes simbolicas
x_func = t
y_func = t^2
z_func = t

dx_func = diff(x_func,t)
dy_func = diff(y_func,t)
dz_func = diff(z_func,t)

dx_p = dx_func/ abs(vector([dx_func, dy_func, dz_func]))
dy_p = dy_func/ abs(vector([dx_func, dy_func, dz_func]))
dz_p = dz_func/ abs(vector([dx_func, dy_func, dz_func]))

ddx_func = diff(dx_p, t)
ddy_func = diff(dy_p, t)
ddz_func = diff(dz_p, t)

#Transforma as funcoes simbolicas como funcoes reais
def x(p):
    return x_func.subs(t=p)

def y(p):
    return y_func.subs(t=p)

def z(p):
    return z_func.subs(t=p)

def dx(p):
    return dx_func.subs(t=p)

def dy(p):
    return dy_func.subs(t=p)

def dz(p):
    return dz_func.subs(t=p)

def ddx_p(p):
    return ddx_func.subs(t=p)

def ddy_p(p):
    return ddy_func.subs(t=p)

def ddz_p(p):
    return ddz_func.subs(t=p)

def module(p):
    return abs(tan).n()

def k(p):
    return abs(dtan).n()


#Cria o grafico com a curva
graph = Graphics()
curva = parametric_plot3d([x(t), y(t), z(t)], (t,-pi,pi))
graph += curva

for i in srange(-pi, pi, 0.5):
    #Define o triedo de Frenet
    tan = vector([dx(i), dy(i), dz(i)])
    dtan = vector([ddx_p(i), ddy_p(i), ddz_p(i)])
    normal = dtan/k(i)
    b = (tan/module(i)).cross_product(normal)

    #Define o comeco e final da tangente e normal
    start = vector([x(i).n(), y(i).n(), z(i).n()])
    end_tan = vector((tan/ module(i)).n())
    end_norm = vector(normal.n())

    #Gera os vetores
    graph += arrow(start, start + end_tan ,color='red', width=1, arrowsize = 3)
    graph += arrow(start, start + end_norm, color = 'green', width = 1, arrowsize = 3)
    graph += arrow(start, start + b, color='blue', width=1, arrowsize=3)


#Caso um output seja gerado ele virará um arquivo txt envês de aparecer na tela e encher o saco
with open("output.txt", "w") as file:
    with redirect_stdout(file):
        show(graph)









