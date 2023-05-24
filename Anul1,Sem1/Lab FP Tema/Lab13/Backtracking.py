#9) Se dau coordonatele pentru n puncte in plan. Determinati toate multimile de puncte cu
#proprietatea ca cel putin trei puncte din multime sunt colineare. Tipariti un mesaj daca
#problema nu are solutie.

nr_sol=0

def afisare_punct(punct):
    print(end='(')
    print(punct[0], end=', ')
    print(punct[1], end=')')
    
def determinant3(mat):
    return (mat[0][0] * mat[1][1] * mat[2][2] + mat[1][0] * mat[2][1] * mat[0][2] + mat[2][0] * mat[0][1] * mat[1][2]) - (mat[0][2] * mat[1][1] * mat[2][0] + mat[1][2] * mat[2][1] * mat[0][0] + mat[2][2] * mat[0][1] * mat[1][0])

def coliniaritate3(A, B, C):
    return abs(determinant3([[1, A[0], A[1]], [1, B[0], B[1]], [1, C[0], C[1]]])) < 1e-13

def estesol(puncte, sol):
    if len(sol) < 3:
        return False
    for i in range(len(sol) - 2):
        for j in range(i + 1, len(sol) - 1):
            for k in range(j + 1, len(sol)):
                if coliniaritate3(puncte[sol[i]], puncte[sol[j]], puncte[sol[k]]):
                    return True
    return False

def afisare_solutie(puncte, sol):
    global nr_sol
    nr_sol += 1
    print('Solutia #', end = '')
    print(nr_sol, end = ': {')
    index = 0
    while index < len(sol) - 1:
        afisare_punct(puncte[sol[index]])
        print(', ', end = '')
        index += 1
    afisare_punct(puncte[sol[index]])
    print('}') 
    
def recursive_backtracking(puncte, sol = []):
    start = (0) if (not len(sol)) else (sol[-1] + 1)
    for index in range(start, len(puncte)):
        sol.append(index)
        if estesol(puncte, sol):
            afisare_solutie(puncte, sol)
        if len(sol) < len(puncte):
            recursive_backtracking(puncte, sol)
        sol.pop()
        
def iterative_backtracking(puncte):
    sol = [-1] #candidate solution
    while len(sol):
        ales = False
        while not ales and len(sol) <= len(puncte) and sol[-1] < len(puncte) - 1:
            sol[-1] += 1 #increase the last component
            ales = True
        if not ales:
            sol = sol[:-1] #go back one component
        else:
            if estesol(puncte, sol):
                afisare_solutie(puncte, sol)
            sol.append(sol[-1]) #expand candidate solution

def main():
    print("Enunt problema 9:\nSe dau coordonatele pentru n puncte in plan.\nDeterminati toate multimile de puncte cu proprietatea ca cel putin trei puncte din multime sunt coliniare.\nTipariti un mesaj daca problema nu are solutie.\n")
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
    puncte = []
    for index in range(n):
        print('\nx', end = '')
        print(index, end = ': ')
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
        print(index, end=': ')
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
        puncte.append([x, y])
        print('(x', end = '')
        print(index, end = ', y')
        print(index, end = ') = ')
        afisare_punct(puncte[index])
        print()
    print('\nSolutii varianta recursiva:')
    recursive_backtracking(puncte)
    global nr_sol
    if not nr_sol:
        print('Nu exista solutie!')
    nr_sol = 0
    print('\nSolutii varianta iterativa:')
    iterative_backtracking(puncte)
    if not nr_sol:
        print('Nu exista solutie!')

main()