︠
def isreal(num):
    # Returns True if num is real, else False
    real = False
    if (imag_part(num) == 0):
        real = True
    return real
︡f2aac7c8-94a5-4981-b966-3406979cc245︡{"stdout": "", "done": true}︡
︠004ec68b-7d39-4f40-8b70-55ded90d944c︠
def combn2(f):
    # Returns an increasing list of interesting x-values
    # First derivative Test
        df = diff(f, x)
        # Solve for critical points
        sols = solve(df, x)
        # Save real solutions to a list
        L = []
        for sol in sols:
            if(isreal(sol.rhs())):
                L.append(sol.rhs())
        #print('CP solutions: ',sols)
        #print('real CPs: ', L)
    # Second derivative test
        df2 = diff(df, x)
        # Solve for pips
        sols = solve(df2, x)
        #print('pips solutions: ', sols)
        # Save real pips to a list
        df2(x) = df2
        for sol in sols:
            if(isreal(sol.rhs())):
                L.append(sol.rhs())
    # Remove duplicates and order the list
        #print('L before: ', L)
        L = list(set(L))
        L.sort()
        #print('L after: ', L)
    # Return
        return L
︡055b5272-b601-4d46-b1f5-0ecf3f646cbd︡{"stdout": "", "done": true}︡
︠86802ea7-ded2-43d4-bc5a-3fd4fec0f0e7︠
def graphcal(f, L, hac, ic, dc):
    # Return a graphic containing the function f, it's interesting points, and shows any HA's
    # Get the interesting coordinates
        f(x) = f
        XS = L     # List of x-values (increasing order)
        #print('x-coordinates: ', XS)

    # Produce a graphic
        df(x) = diff(f, x)
        df2(x) = diff(df, x)
        intvl = XS[-1] - XS[0]
        if(intvl == 0):
            intvl = 10     # This may not be an ideal solution for every case
        # Establish the endpoints
        a = XS[0] - 0.1*intvl
        b = XS[0]
        # Perform the tests
        for i in range(len(XS) + 1):
            tp = (a+b) / 2     # Test-point
            #print('[ i =', i,'] a: ', a, '/ tp: ', tp, ' / b: ', b)
            col = dc     # Decreasing color
            ls = '--'
            # Check if the interval is increasing or decreasing
            #print(' df sign: ', sign(df(tp)))
            if(df(tp) > 0):
                  col = ic     # Increasing color
            # Check concavity
            #print('df2 sign: ', sign(df2(tp)))
            if(df2(tp) > 0):
                ls = ':'

            # Update the graphic
            if(i == 0):
                lbha = a     # Left bound for the HA
                G = plot(f, xmin=a, xmax=b, color=col, linestyle=ls)
            else:
                G += plot(f, xmin=a, xmax=b, color=col, linestyle=ls)
            if(i == (len(XS))):
                rbha = b     # Right bound for the HA
                # TEST FOR HORIZONTAL ASYMPTOTES
                # These few lines of code will show any HA's by plotting a horizontal line
                llim = f.limit(x=-oo)
                rlim = f.limit(x=oo)
                #print('lims: ', llim, ' / ', rlim)
                if(not(abs(llim) == oo)):
                    #print('Yes LHA: y =', llim)
                    ha = plot(llim, xmin=lbha, xmax=rbha, color=hac, zorder=5, thickness=2)
                    #show(ha)
                    G += ha
                if(not(abs(rlim) == oo)):
                    #print('Yes RHA: y =', rlim)
                    ha = plot(rlim, xmin=lbha, xmax=rbha, color=hac, zorder=5, thickness=2)
                    #show(ha)
                    G += ha
                #else:
                    #print('No HA')
                return G     # Return G after len(XS) + 1 iterations
            # Adjust the endpoints
            a = b
            if(i == (len(XS) - 1)):
                b = XS[-1] + 0.1*intvl
            else:
                b = XS[i+1]
︡78602930-eaca-4ce6-bd1e-06e23a875b8a︡{"stdout": "", "done": true}︡
︠81346577-9eca-45c7-a058-b067f2f5f098︠
def second_deriv_test(f, x0, y0):
    # This procedure can test for local max or min
    d2x(x) = diff(f,x,2)
    #print(d2x)
    D = d2x(x0)
    if(D > 0):
        result = 'min'
    elif(D < 0):
        result = 'max'
    else:
        result = 'inconclusive'
    #print(D, ' / ', result)
    return result
︡0553d332-d4e3-485b-a144-86c055e1629d︡{"stdout": "", "done": true}︡
︠2dc806c6-27a2-4108-8de0-aff2a53a7177︠
def max_min(f, L, maxc, minc, pc):
    # Returns a plot of interesting points with corresponding point colors
    f(x) = f
    for i in range(len(L)):
        x0, y0 = L[i], f(L[i])
        test = second_deriv_test(f, x0, y0)
        if(test == 'max'):
            col = maxc
        elif(test == 'min'):
            col = minc
        else:
            col = pc
        if(i == 0):
            g =  point([(x0, y0)], color=col, zorder=10, size=50)
        else:
            g += point([(x0, y0)], color=col, zorder=10, size=50)
    #show(g)
    return g
︡002b4738-95e6-4585-90ab-49715d5c15ac︡{"stdout": "", "done": true}︡
︠51f18951-6db1-4d56-8818-90f113711f19︠
@interact
def inter_graph(f=input_box(label='f(x)=', default='x^3+x^2-x-7'), max_color=Color('green'), min_color=Color('purple'), pt_color=Color('black'), HA_color=Color('darkorange'), in_color=Color('blue'), de_color=Color('red'), auto_update=False):
    if(f != None):
        IPTS = combn2(f) # increasing list of interesting points (x-values)
        p = graphcal(f, IPTS, HA_color, in_color, de_color)
        p += max_min(f, IPTS, max_color, min_color, pt_color)
        show(p)
