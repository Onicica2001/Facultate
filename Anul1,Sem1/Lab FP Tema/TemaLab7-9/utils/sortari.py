def Quicksort(lista,key=lambda x:x, reverse=False):          
    def __Quicksortrec(lista,key):
        if len(lista)<=1:
            return lista
        pivot=lista.pop()
        inferior=__Quicksortrec([x for x in lista if key(x)<key(pivot)],key)
        superior=__Quicksortrec([x for x in lista if key(x)>=key(pivot)], key)
        return inferior+[pivot]+superior 
    lista=__Quicksortrec(lista, key)   
    if reverse==False:
        return lista
    else:
        return list(reversed(lista))
    


def test_quicksort():
    def key_1(elem):
        return elem[1]
    elem1=[10,0]
    elem2=[5,7]
    elem3=[4,8]
    elem4=[8,5]
    lista=[elem1,elem2,elem3,elem4]
    lista=Quicksort(lista, key_1)
    assert(lista==[ [10, 0], [8, 5], [5, 7], [4, 8]])
    lista=Quicksort(lista, key_1,reverse=True)
    assert(lista==[ [4, 8], [5, 7], [8, 5], [10, 0]])
test_quicksort()



def Gnomesort(lista,key=lambda x:x,reverse=False):
    pozitie=0
    while pozitie<len(lista):
        if reverse==False:
            if pozitie==0 or key(lista[pozitie])>=key(lista[pozitie-1]):
                pozitie+=1
            else:
                lista[pozitie-1],lista[pozitie]=lista[pozitie],lista[pozitie-1]
                pozitie=pozitie-1
        else:
            if pozitie==0 or key(lista[pozitie])<=key(lista[pozitie-1]):
                pozitie+=1
            else:
                lista[pozitie-1],lista[pozitie]=lista[pozitie],lista[pozitie-1]
                pozitie=pozitie-1
    return lista
            
def test_gnomesort():
    def key_1(elem):
        return elem[1]
    elem1=[10,0]
    elem2=[5,7]
    elem3=[4,8]
    elem4=[8,5]
    lista=[elem1,elem2,elem3,elem4]
    assert(Gnomesort(lista, key_1)==[ [10, 0], [8, 5], [5, 7], [4, 8]])
    assert(Gnomesort(lista, key_1,reverse=True)==[ [4, 8], [5, 7], [8, 5], [10, 0]])
test_gnomesort()



def Gnomesort2key(lista,key_1=lambda x:x,key_2=lambda x:x,reverse=False):
    pozitie=0
    while pozitie<len(lista):
        if reverse==False:
            if pozitie==0 or key_1(lista[pozitie])>key_1(lista[pozitie-1]):
                pozitie+=1
            elif key_1(lista[pozitie])<key_1(lista[pozitie-1]):
                lista[pozitie-1],lista[pozitie]=lista[pozitie],lista[pozitie-1]
                pozitie=pozitie-1
            elif key_1(lista[pozitie])==key_1(lista[pozitie-1]):
                if key_2(lista[pozitie])>=key_2(lista[pozitie-1]):
                    pozitie+=1
                else:
                    lista[pozitie-1],lista[pozitie]=lista[pozitie],lista[pozitie-1]
                    pozitie=pozitie-1
        else:
            if pozitie==0 or key_1(lista[pozitie])<key_1(lista[pozitie-1]):
                pozitie+=1
            elif key_1(lista[pozitie])>key_1(lista[pozitie-1]):
                lista[pozitie-1],lista[pozitie]=lista[pozitie],lista[pozitie-1]
                pozitie=pozitie-1
            elif key_1(lista[pozitie])==key_1(lista[pozitie-1]):
                if key_2(lista[pozitie])<key_2(lista[pozitie-1]):
                    pozitie+=1
                else:
                    lista[pozitie-1],lista[pozitie]=lista[pozitie],lista[pozitie-1]
                    pozitie=pozitie-1
    return lista

def test_gnomesort2key():
    def key_1(elem):
        return elem[1]
    def key_2(elem):
        return elem[0]
    elem1=[10,0]
    elem2=[3,7]
    elem3=[4,8]
    elem4=[8,5]
    elem5=[5,7]
    lista=[elem1,elem2,elem3,elem4,elem5]
    assert(Gnomesort2key(lista, key_1)==[ [10, 0], [8, 5], [3,7], [5, 7], [4, 8]])
    assert(Gnomesort2key(lista, key_1,reverse=True)==[ [4, 8], [5, 7], [3,7], [8, 5], [10, 0]])
test_gnomesort2key()
