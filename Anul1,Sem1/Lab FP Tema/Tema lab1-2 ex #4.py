def prim(a):
    for d in range(2,a//2+1):
        if a%d==0: return False
    return True

n=int(input("Introduceti numarul n:"))
p1=2
i=None
ok=None
while p1<n:
    ok=prim(p1)
    if ok==True:
        p2=n-p1
        if p2>1:
            ok=prim(p2)
            if ok==True:
                print("p1=",p1,"     p2=",p2)
                i=1
    if p1==2:
        p1+=1
    else:
        p1=p1+2
if i==None:
    print("Numarul n nu se poate scrie ca suma de 2 numere prime")
