
# Maxima/Minima in 3D

def isreal(num):
    real = False
    if (imag_part(num) == 0):
        real = True
    return real

def critical_points(f):
    f(x,y) = f
    dx = diff(f,x)
    dy = diff(f,y)
    #print("dx =",dx, " / dy =", dy)
    L = []
    sols = solve((dx==0, dy==0), (x,y))
    #print("sols =", sols)
    for sol in sols:
        x0, y0 = sol[0].rhs(), sol[1].rhs()
        #print("x0 =", x0," / y0 =", y0)
        if(isreal(x0))and(isreal(y0)):
            L.append((x0, y0))
    L = list(set(L))
    L.sort()
    return L

def second_derivs_test(f, x0, y0):
    d2x(x,y) = diff(f,x,2)
    d2y(x,y) = diff(f,y,2)
    dxy(x,y) = diff(diff(f,x),y)
    D = d2x(x0,y0)*d2y(x0,y0) - (dxy(x0,y0))^2
    if(D == 0):
        result = 'inconclusive'
    elif(D < 0):
        result = 'saddle'
    else:
        if(d2x(x0,y0) > 0):
            result = 'min'
        else:
            result = 'max'
    return result

def plot_critical_points(f):
    # Return a 3-dimensional plot with the following:
    # * f(x,y) in the default color
    # * local maxima in red
    # * local minima in yellow
    # * saddle points in green
    # * other critical points in black
    f(x,y) = f
    CP = critical_points(f)     # An increasing list of real critical points (x,y)
    if(len(CP) == 1):
        x1, y1 = CP[0]
        xmin, xmax = x1 - 1, x1 + 1
        ymin, ymax = y1 - 1, y1 + 1
    else:
        x1, y1 = CP[0]
        x2, y2 = CP[-1]
        c = 0.2     # A constant
        d = sqrt((x2-x1)^2 + (y2-y1)^2)     # Distance between (x1,y1) and (x2,y2)
        cd = c*d
        xmin, xmax = x1 - cd, x2 + cd
        ymin, ymax = y1 - cd, y2 + cd
    G = plot3d(f, (x,xmin,xmax), (y,ymin,ymax), opacity=0.8)
    for point in CP:
        x0, y0 = point[0], point[1]
        test = second_derivs_test(f, x0, y0)
        if(test == 'max'):
            col = 'red'
        elif(test == 'min'):
            col = 'yellow'
        elif(test == 'saddle'):
            col = 'green'
        else:
            col = 'black'
        G += point3d((x0, y0, f(x0,y0)), color=col, size=30)
    return G

