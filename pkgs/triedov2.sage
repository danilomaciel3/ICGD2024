from sage.all import *

#Calcula o valor da função em um ponto
def make_subs(func):
        def _subs(p):
            return func.subs(t=p)
        return _subs
    
def getvalues(x_func, y_func, z_func):
    dx_func = diff(x_func,t)
    dy_func = diff(y_func,t)
    dz_func = diff(z_func,t)
    module = abs(vector([dx_func, dy_func, dz_func]))
    ddx_func = diff(dx_func / module, t)
    ddy_func = diff(dy_func / module, t)
    ddz_func = diff(dz_func / module, t)
    
    x = make_subs(x_func); y = make_subs(y_func); z = make_subs(z_func)
    dx = make_subs(dx_func); dy = make_subs(dy_func); dz = make_subs(dz_func)
    ddx = make_subs(ddx_func); ddy = make_subs(ddy_func); ddz = make_subs(ddz_func)
    
    return {'x': x, 'y': y, 'z': z, 'dx': dx, 'dy': dy, 'dz': dz, 'ddx': ddx, 'ddy': ddy, 'ddz': ddz}

def graph_generation(x, y, z, dx, dy, dz ,ddx ,ddy, ddz):    
    graph = Graphics()
    graph += parametric_plot3d([x(t), y(t), z(t)], (t,-pi,pi))

    for i in srange(-pi, pi, 0.5):
        #Define os pontos do triedo de Frenet
        tan = vector([dx(i), dy(i), dz(i)])
        dtan = vector([ddx(i), ddy(i), ddz(i)])
        normal = dtan/abs(dtan)
        b = (tan/abs(tan).n()).cross_product(normal)

        #Define o comeco e fim dos vetores
        start = vector([x(i).n(), y(i).n(), z(i).n()])
        end_tan = vector(tan/ abs(tan).n())
        end_norm = vector(normal.n())

        graph += arrow(start, start + end_tan ,color='red', width=1, arrowsize = 3)
        graph += arrow(start, start + end_norm, color = 'green', width = 1, arrowsize = 3)
        graph += arrow(start, start + b, color='blue', width=1, arrowsize=3)

    return graph

t = var('t') 
val = getvalues(t,t^2, t)
graph_generation(val['x'], val['y'] ,val['z'], val['dx'] ,val['dy'], val['dz'], val['ddx'], val['ddy'] , val['ddz'])