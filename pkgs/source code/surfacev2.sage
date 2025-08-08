u = var('u'); v = var('v'); du = var('du'); dv = var('dv')
assume(v, 'real'); assume(v >= 0); assume(v < 2*pi);
assume(u, 'real'); assume(u >= 0); assume(u < 2*pi)

def getvalues(x_func, y_func, z_func):
    s = vector([x_func, y_func, z_func])
    ds_du = diff(s,u)
    ds_dv = diff(s,v)
    ds_du_dv = diff(diff(s,u), v)
    dds_du = diff(diff(s,u), u)
    dds_dv = diff(diff(s,v), v)

    normal = ds_du.cross_product(ds_dv) / norm(ds_du.cross_product(ds_dv))
    
    E = ds_du.dot_product(ds_du); F =ds_du.dot_product(ds_dv); G = ds_dv.dot_product(ds_dv)
    e = dds_du.dot_product(normal); f =ds_du_dv.dot_product(normal); g = dds_dv.dot_product(normal)
    
    firstquadraticform = du^2 * E + 2*du*dv*F + dv^2 * G
    secondquadraticform = du^2 * e + 2*du*dv*f + dv^2 * g
    
    kn = secondquadraticform / firstquadraticform
    K = (e*g - f**2)/(E*G - F**2)
    H = 1/2*((e*G - 2*f*F + E*g) / (E*G - F**2))
    
    return [K, H, firstquadraticform, secondquadraticform, kn]
    
def showgraph(x, y, z):
    surface = parametric_plot3d([x, y, z], (u,0,2*pi), (v,0,2*pi), color='red')
    return surface

func = vector([(3 + cos(v)) * cos(u), (3 + cos(v)) * sin(u), sin(v)])
print('Curvatura Gaussiana: ', getvalues(*func)[0].simplify_full())
print('Curvatura Média: ', getvalues(*func)[1].simplify_full())
print('Primeira Forma Quadrática: ', getvalues(*func)[2].simplify_full())
print('Segunda Forma Quadrática: ', getvalues(*func)[3].simplify_full())
print('Curvatura Normal: ', getvalues(*func)[4].simplify_full())
showgraph(*func)