# Extended Euclidean Algorithm (Programming Problem 7 at the end of Chapter 8)

def euclidalg(a, b):
    m, n = abs(a), abs(b)
    s = d = 0
    c = t = 1
    while(n != 0):
        q = m // n
        r = m % n
        m, n = n, r
        w, c = c, s
        s = w - q*s
        w, d = d ,t
        t = w - q*t
    #print('a =', a, ' / b =', b , ' / c =', c, ' / d =', d)
    print('ac + bd = ', a*c + b*d)
    print('gcd(a,b) = ', gcd(a,b))
    return c, d
︡
# Continued Fractions

def cont_frac(b, m):
    L = [0 for i in range(m+1)]
    #print('L before: ', L)
    i = 0
    print('b = ', b, ' = ', b.n())
    while((i <= m) and (b != 0)):
        L[i] = floor(b)
        d = b - L[i]
        if(d != 0):
            d = 1/d
        print('L[', i, '] = ', L[i], '/ d = ', d.n())
        b = d
        i += 1
    return L
