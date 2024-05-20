︠
# Write a procedure to calculate the distance between two points, which will be given as ordered pairs.
︡
def distance_between(pt1, pt2):
    x1, y1 = pt1
    x2, y2 = pt2
    deltax = x2 - x1
    deltay = y2 - y1
    return sqrt(deltax^2 + deltay^2)
︡
# Write a procedure that approximates the arc length of f(x) on the interval [a,b] using N subintervals.

def arclen(f, a, b, N):
    # Check for inappropriate arguments
    if (a>=b):
        raise ValueError('b should be greater than a')
    if (N<=0) or (N-floor(N)!=0):
        raise ValueError('N should be a positive integer')
    # Approximate the arclength of a function f on the interval [a,b] using N subintervals.
    f(x) = f
    al = 0
    deltax = abs(b - a) / N
    x_i = a
    x_j = a + deltax
    # Find the approximated arclength
    for i in range(N):
        # Create points to calculate the distance
        pt_i = (x_i, f(x_i))
        pt_j = (x_j, f(x_j))
        # Update the running total
        al = al + distance_between(pt_i, pt_j)
        # Update the points
        x_i = x_j
        x_j = x_j + deltax
    # Return the approximated arclength
    return al.n()
︡
# Write a procedure that will visualize this process.

def arclen_vis(f, a, b, N):
    # Check for inappropriate arguments
    if (a>=b):
        raise ValueError('b should be greater than a')
    if (N<=0) or (N-floor(N)!=0):
        raise ValueError('N should be a positive integer')
    # Visualize an arclength approximation of the function f on [a,b] with N subintervals.
    f(x) = f
    L = []
    deltax = abs(b - a) / N
    x_i = a
    for i in range(N+1):
        L.append((x_i, f(x_i)))
        x_i = x_i + deltax
    # Construct a graphic
    y1, y2 = f(a), f(b)
    if (y1>0) and (y2>0):
        color = 'black'
    elif (y1<0) and (y2<0):
        color = 'red'
    else:
        color = 'purple'
    l = line(L, color=color)
    pts = point(L, color=color)
    # Return the graphic
    return l + pts

# Animate these approximations.

def anim_arclen(f, a, b, kmax):
    # Animation of arc length approximation: starting with 1 subinterval, and doubling the number of subintervals kmax times.
    num = 1
    G = []
    # Created the frames for the animation
    for k in range(kmax):
        G.append(arclen_vis(f, a, b, num))
        num = num * 2
    # Display the estimated and exaxt arc length
    print('Approximated arc length: ', arclen(f, a, b, num))
    eal = integrate( sqrt(1 + (diff(f, x))^2), x, a, b)
    print('Exact arc length: ', round(eal,3))
    # Show the animation
    animate(G).show(delay=125, iterations=6)
︡
