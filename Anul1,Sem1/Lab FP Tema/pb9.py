#9. Se dau coordonatele pentru n puncte în plan. Determinați toate mulţimile de puncte cu
#proprietatea că cel puţin trei puncte din mulţime sunt colineare. Tipăriţi un mesaj dacă
#problema nu are soluţie.

nr_sol = 0

def afisare_punct(point):
    print(end='(')
    print(point[0], end=', ')
    print(point[1], end=')')

def determinant3(mat):
    return (mat[0][0] * mat[1][1] * mat[2][2] + mat[1][0] * mat[2][1] * mat[0][2] + mat[2][0] * mat[0][1] * mat[1][2]) - (mat[0][2] * mat[1][1] * mat[2][0] + mat[1][2] * mat[2][1] * mat[0][0] + mat[2][2] * mat[0][1] * mat[1][0])

def coliniaritate3(A, B, C):
    return abs(determinant3([[1, A[0], A[1]], [1, B[0], B[1]], [1, C[0], C[1]]])) < 1e-13

def esol(points, sol):
    if len(sol) < 3:
        return False
    for i in range(len(sol) - 2):
        for j in range(i + 1, len(sol) - 1):
            for k in range(j + 1, len(sol)):
                if coliniaritate3(points[sol[i]], points[sol[j]], points[sol[k]]):
                    return True
    return False

def afisare_solutie(points, sol):
    global nr_sol
    nr_sol += 1
    print('Solutia #', end = '')
    print(nr_sol, end = ': {')
    idx = 0
    while idx < len(sol) - 1:
        afisare_punct(points[sol[idx]])
        print(end = ', ') #print(', ', end = '')
        idx += 1
    afisare_punct(points[sol[idx]])
    print('}') #print(end = '}\n')

def recursive_backtracking(points, sol = []):
    start = (0) if (not len(sol)) else (sol[-1] + 1)
    for idx in range(start, len(points)):
        sol.append(idx)
        if esol(points, sol):
            afisare_solutie(points, sol)
        if len(sol) < len(points):
            recursive_backtracking(points, sol)
        sol.pop()

def iterative_backtracking(points):
    sol = [-1] #candidate solution
    while len(sol):
        choosed = False
        while not choosed and len(sol) <= len(points) and sol[-1] < len(points) - 1:
            sol[-1] += 1 #increase the last component
            choosed = True
        if not choosed:
            sol = sol[:-1] #go back one component
        else:
            if esol(points, sol):
                afisare_solutie(points, sol)
            sol.append(sol[-1]) #expand candidate solution

def pb9():
    print('Enunț problema 9:\nSe dau coordonatele pentru n puncte în plan.\nDeterminați toate mulţimile de puncte cu proprietatea că cel puţin trei puncte din mulţime sunt colineare.\nTipăriţi un mesaj dacă problema nu are soluţie.\n')
    try:
        n = int(input('n = '))
    except ValueError as ve:
        print(str(ve))
        return
    except TypeError as te:
        print(str(te))
        return
    except Exception as ex:
        print(str(ex))
        return
    assert n >= 0
    points = []
    for idx in range(n):
        print('\nx', end = '')
        print(idx, end = ': ')
        try:
            x = float(input())
        except ValueError as ve:
            print(str(ve))
            return
        except TypeError as te:
            print(str(te))
            return
        except Exception as ex:
            print(str(ex))
            return
        print('y', end='')
        print(idx, end=': ')
        try:
            y = float(input())
        except ValueError as ve:
            print(str(ve))
            return
        except TypeError as te:
            print(str(te))
            return
        except Exception as ex:
            print(str(ex))
            return
        points.append([x, y])
        print('(x', end = '')
        print(idx, end = ', y')
        print(idx, end = ') = ')
        afisare_punct(points[idx])
        print()
    print('\nSolutii varianta recursiva:')
    recursive_backtracking(points)
    global nr_sol
    if not nr_sol:
        print('Nu exista solutie!')
    nr_sol = 0
    print('\nSolutii varianta iterativa:')
    iterative_backtracking(points)
    if not nr_sol:
        print('Nu exista solutie!')

pb9()