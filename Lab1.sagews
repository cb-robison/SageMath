# Euler's method 

def eulers_method(df, x0, y0, Delta_x, n):
    # starting point
    a, b = x0, y0
    L = [(a, b)]
    # compute tangent lines & step forward
    for i in range(n):
        b = Delta_x * df(a, b) + b
        a = Delta_x + a
        L.append((a, b))
    return L

# Runge-Kutta Method 

def runge_kutta(df, x0, y0, Delta_x, n):
    a, b = x0, y0
    L = [(a, b)]
    for i in range(n):
        k1 = df(a, b)
        k2 = df(a + (Delta_x/2), b + (Delta_x/2)*k1)
        k3 = df(a + (Delta_x/2), b + (Delta_x/2)*k2)
        k4 = df(a + Delta_x, b + Delta_x*k3)
        b = b + (Delta_x/6)*(k1+k2+k3+k4)
        a = a + Delta_x
        L.append((a, b))
    return L
︡
# Solve the following differential equation using various methods: dy = cos(x)dx.

df(x, y) = cos(x)
f(x) = sin(x)
a, b = 0, 2*pi

p1 = plot(sin(x), a, b, color='darkorange')
p2 = point(eulers_method(df, 0, 0, b/80, 80), color='blue')
p3 = point(runge_kutta(df, 0, 0, b/80, 80), color='darkolivegreen')

p1 + p2 + p3
︡