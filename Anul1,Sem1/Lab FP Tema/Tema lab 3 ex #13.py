def meniu():
    print("1.Citirea unei liste de numere întregi")
    print("2.Găsirea secventei de lungime maximă care are suma elementelor egală cu 5")
    print("3.Găsirea secventei de lungime maximă care are oricare două elemente consecutive de semne contrare")
    print("4.Iesire")
def semne_contrare(a,b):
    if a>0 and b>0: return False
    elif a<0 and b<0:return False
    return True
n=1
secv=1
ok=0
while n!=None:
    meniu()
    n=int(input("Introduceti cifra corespunzătoare instructiunii dorite:"))
    pozmax=None
    secvmax=1
    if n==1:
        l=input("Introduceti numerele:")
        l=l.split()
        for j in range(len(l)):
            l[j]=int(l[j])
        ok=1
    elif n==2:
        if ok==0:
            print("Eroare>>Nu a fost introdusă lista!")
        else:
            for i in range(len(l)):
                x=l[i]
                for j in range(i+1,len(l)):
                    x=x+l[j]
                    secv+=1
                    if x==5:
                        if secv>secvmax:
                            secvmax=secv
                            pozmax=j
                secv=1
            if secvmax==1:
                print("Nu exista secvente care au suma elementelor egala cu 5")
            else:
                for p in range(pozmax-secvmax+1,pozmax+1):
                    print(l[p])
    elif n==3:
        if ok==0:
            print("Eroare>>Nu a fost introdusă lista!")
        else:
            for i in range(len(l)-1):
                if semne_contrare(l[i],l[i+1]):
                    secv+=1
                    if i==len(l)-1:
                        secv+=1
                else:
                    if secv>secvmax:
                        secvmax=secv
                        pozmax=i
                    secv=1
            if secv>secvmax:
                        secvmax=secv
                        pozmax=i+1
            if secvmax==1:
                print("Nu exista secvente care au oricare două elemente consecutive de semne contrare")
            else:
                for p in range(pozmax-secvmax+1,pozmax+1):
                    print(l[p])
                    
    elif n==4:
        n=None
