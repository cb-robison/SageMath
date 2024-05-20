
# Linear Algebra

def is_square(M):
    square = False
    rows, cols = M.dimensions()
    if(rows == cols):
        square = True
    return square
︡
def is_zero_one_negative(M):
    is_zon = True
    rows, cols = M.dimensions()
    for i in range(rows):
        for j in range(cols):
            el = M[i, j]
            if(not((el == -1)or(el == 0)or(el == 1))):
                is_zon = False
    return is_zon
︡
def sums_to_one(M):
    sto = True
    rows = M.dimensions()[0]
    for i in range(rows):
        total = sum(M[i])
        #print(M[i]," / ", total)
        if(total != 1):
            sto = False
    return sto
︡
def allthree(M):   #return True if M satisfies all 3 above, False otherwise.
    at = False
    if((is_square(M))and(is_zero_one_negative(M))and(sums_to_one(M))):
        at = True
    return at

# Stirling numbers of the second kind 

Stirling numbers of the second kind count how many ways you can partition $n$ elements into $k$ subsets.

* https://en.wikipedia.org/wiki/Stirling_numbers_of_the_second_kind
* https://mathworld.wolfram.com/StirlingNumberoftheSecondKind.html

Write a procedure <font face='courier'>s2matrix(Nmax)</font> which takes a positive integer $Nmax$ and constructs a square matrix with $Nmax$ rows and columns of Stirling numbers of the second kind.

The matrix should be lower triangular and should contain the Stirling numbers of the second kind.  You will need to use this definition (not any other formula or built-in command):

def s2matrix(Nmax):
    S = zero_matrix(Nmax)
    for n in range(Nmax):
        for k in range(Nmax):
            if(k == 0):
                S[n,k] = 1
            elif(k == n):
                S[n,k] = 1
            else:
                S[n,k] = S[n-1,k-1] + (k+1)*S[n-1,k]
    return S
