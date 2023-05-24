index=0
def test_adauga_cheltuiala():
    assert adauga_cheltuiala({}, '1', '60', 'mancare')=={1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'}}
    assert adauga_cheltuiala({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'}}, '7','220', 'intretinere')== {1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'220', 'tip':'intretinere'}}
    assert adauga_cheltuiala({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'220', 'tip':'intretinere'}}, '15', '150', 'imbracaminte')== {1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'220', 'tip':'intretinere'},3: { 'ziua':'15','suma':'150', 'tip':'imbracaminte'}}
    assert adauga_cheltuiala({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'220', 'tip':'intretinere'},3: { 'ziua':'15','suma':'150', 'tip':'imbracaminte'}}, '30', '750', 'altele')== {1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'220', 'tip':'intretinere'},3: { 'ziua':'15','suma':'150', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}}
    assert adauga_cheltuiala({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'220', 'tip':'intretinere'},3: { 'ziua':'15','suma':'150', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}}, '19', '140', 'telefon')=={1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'220', 'tip':'intretinere'},3: { 'ziua':'15','suma':'150', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: {'ziua': '19', 'suma': '140', 'tip': 'telefon'}}
    assert adauga_cheltuiala({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'}}, '1','45', 'mancare')=='Exista deja o cheltuiala in aceeazi zi si de acelasi tip. Daca doriti sa o actualizati folositi functia de actualizare'
def adauga_cheltuiala(cheltuieli,ziua,suma,tip):
    """
     Adauga o noua cheltuiala la cele existente
     cheltuieli dictionar, n numar intreg, ziua, suma, tip string
     returneaza dictionarul actualizat sau mesaj de eroare
    """
    ok=True
    n=1
    for n in cheltuieli:
        if int(cheltuieli[n]['ziua'])==int(ziua) and cheltuieli[n]['tip']==tip: ok=False
        n+=1
    if ok==True:
        cheltuieli[n]={}
        cheltuieli[n]['ziua']=ziua
        cheltuieli[n]['suma']=suma
        cheltuieli[n]['tip']=tip
        return cheltuieli
    else: return "Exista deja o cheltuiala in aceeazi zi si de acelasi tip. Daca doriti sa o actualizati folositi functia de actualizare"
test_adauga_cheltuiala()
                                      
def test_actualizare_cheltuiala():
    assert actualizare_cheltuiala({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'220', 'tip':'intretinere'},3: { 'ziua':'15','suma':'150', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: {'ziua': '19', 'suma': '140', 'tip': 'telefon'}},'7','500','intretinere')=={1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'150', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: {'ziua': '19', 'suma': '140', 'tip': 'telefon'}}
    assert actualizare_cheltuiala({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'150', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: {'ziua': '19', 'suma': '140', 'tip': 'telefon'}},'15','200','imbracaminte')=={1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: {'ziua': '19', 'suma': '140', 'tip': 'telefon'}}
    assert actualizare_cheltuiala({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: {'ziua': '19', 'suma': '140', 'tip': 'telefon'}},'30','800','telefon')=='Nu exista in baza de date o cheltuiala de acel tip in ziua mentionata. Daca doriti sa adaugati aceasta cheltuiala, o puteti face prin comanda de adaugare.'
def actualizare_cheltuiala(cheltuieli,ziua,suma,tip):
    """
     Actualizeaza o cheltuiala din cele existente
     cheltuieli dictionar, ziua, suma, tip string
     returneaza dictionarul actualizat sau mesaj de eroare
    """
    ok=False
    for i in cheltuieli:
        if cheltuieli[i]['ziua']==ziua and cheltuieli[i]['tip']==tip:
            cheltuieli[i]['suma']=suma
            ok=True
    if ok==False:
        return "Nu exista in baza de date o cheltuiala de acel tip in ziua mentionata. Daca doriti sa adaugati aceasta cheltuiala, o puteti face prin comanda de adaugare."
    else:
        return cheltuieli
test_actualizare_cheltuiala()

def test_cheltuieli_mai_mari():
    assert cheltuieli_mai_mari({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: {'ziua': '19', 'suma': '140', 'tip': 'telefon'}},600)=={1: { 'ziua':'30','suma':'750', 'tip':'altele'}}
    assert cheltuieli_mai_mari({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: {'ziua': '19', 'suma': '140', 'tip': 'telefon'}},300)=={1: {'ziua':'7','suma':'500', 'tip':'intretinere'},2: {'ziua':'30','suma':'750', 'tip':'altele'}}
    assert cheltuieli_mai_mari({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: {'ziua': '19', 'suma': '140', 'tip': 'telefon'}},800)=='Nu exista nicio cheltuiala cu suma de o valoare mai mare decat cea introdusa'
def cheltuieli_mai_mari(cheltuieli,suma):
    """
    Cauta cheltuielile mai mari decat varibila suma
    cheltuieli dictionar, suma numar real
    returneaza dictionar sau mesaj de eroare
    """
    ok=False
    raspuns={}
    nr=0
    for i in cheltuieli:
        if int(cheltuieli[i]['suma'])>suma:
            nr+=1
            raspuns[nr]=cheltuieli[i]
            ok=True
    if ok==False:
        return "Nu exista nicio cheltuiala cu suma de o valoare mai mare decat cea introdusa"
    else:
        return raspuns
test_cheltuieli_mai_mari()

def test_cheltuieli_inainte():
    assert cheltuieli_inainte({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: {'ziua': '19', 'suma': '140', 'tip': 'telefon'}},15,200)=={1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'}}
    assert cheltuieli_inainte({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: {'ziua': '19', 'suma': '140', 'tip': 'telefon'}},1,100)=='Nu exista nicio cheltuiala cu suma de o valoare mai mica decat cea introdusa si inainte de ziua mentionata'
    assert cheltuieli_inainte({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: {'ziua': '19', 'suma': '140', 'tip': 'telefon'}},30,50)=='Nu exista nicio cheltuiala cu suma de o valoare mai mica decat cea introdusa si inainte de ziua mentionata'
def cheltuieli_inainte(cheltuieli,ziua,suma):
    """
     Cauta cheltuielile cu proprietatile cerute
     cheltuieli dictionar, ziua numar intreg, suma numar real
     returneaza dictionar sau mesaj de eroare
     """
    ok=False
    raspuns={}
    nr=1
    for i in cheltuieli:
        if int(cheltuieli[i]['ziua'])<ziua and int(cheltuieli[i]['suma'])<suma:
            ok=True
            raspuns[nr]=cheltuieli[i]
            nr+=1
    if ok==False:
        return "Nu exista nicio cheltuiala cu suma de o valoare mai mica decat cea introdusa si inainte de ziua mentionata"
    else:
        return raspuns
test_cheltuieli_inainte()

def test_cheltuieli_tip():
    assert cheltuieli_tip({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: {'ziua': '19', 'suma': '140', 'tip': 'telefon'}},'altele')=={1: { 'ziua':'30','suma':'750', 'tip':'altele'}}
    assert cheltuieli_tip({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: {'ziua': '19', 'suma': '140', 'tip': 'telefon'}},'mancare')=={1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'}}
    assert cheltuieli_tip({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}},'telefon')=='Nu exista cheltuieli de acest tip inregistrate'
def cheltuieli_tip(cheltuieli,tip):
    """
    Cauta cheltuieilile de tipul indicat
    cheltuieli dictionar, tip string
    returneaza dictionar sau mesaj de eroare
    """
    raspuns={}
    ok=False
    nr=1
    for i in cheltuieli:
        if cheltuieli[i]['tip']==tip:
            ok=True
            raspuns[nr]=cheltuieli[i]
            nr+=1
    if ok==False:
        return "Nu exista cheltuieli de acest tip inregistrate"
    else:
        return raspuns
test_cheltuieli_tip()

def test_elimina_tip():
    assert elimina_tip({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}},'altele')=={1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'}}
    assert elimina_tip({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: { 'ziua':'27','suma':'300', 'tip':'mancare'}},'mancare')=={1: {'ziua':'7','suma':'500', 'tip':'intretinere'},2: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},3: { 'ziua':'30','suma':'750', 'tip':'altele'}}
    assert elimina_tip({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}},'telefon')=={1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}}
    assert elimina_tip({1: {'ziua': '1', 'suma': '60', 'tip': 'altele'},2: {'ziua':'7','suma':'500', 'tip':'altele'},3: { 'ziua':'15','suma':'200', 'tip':'altele'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}},'altele')=='Nu exista cheltuieli cu tipul diferit de cel introdus'

def elimina_tip(cheltuieli,tip):
    """
    Elimina cheltuielile de un anumit tip
    cheltuieli dictionar, tip string
    returneaza dictionar sau mesaj de eroare
    """
    raspuns={}
    nr=1
    ok=False
    for i in cheltuieli:
        if cheltuieli[i]['tip']!=tip:
            ok=True
            raspuns[nr]=cheltuieli[i]
            nr+=1
    if ok==False:
        return "Nu exista cheltuieli cu tipul diferit de cel introdus"
    else:
        return raspuns

test_elimina_tip()

def test_elimina_suma():
    assert elimina_suma({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}},200)=={1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'}}
    assert elimina_suma({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'},5: { 'ziua':'27','suma':'300', 'tip':'mancare'}},350)=={1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},3: { 'ziua':'27','suma':'300', 'tip':'mancare'}}
    assert elimina_suma({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}},800)=={1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}}
    assert elimina_suma({1: {'ziua': '1', 'suma': '60', 'tip': 'altele'},2: {'ziua':'7','suma':'500', 'tip':'altele'},3: { 'ziua':'15','suma':'200', 'tip':'altele'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}},60)=='Nu exista cheltuieli cu suma mai mica decat cea introdusa'

def elimina_suma(cheltuieli,suma):
    """
    Elimina cheltuielile mai mici decat suma data
    cheltuieli dictionar, suma numar intreg
    returneaza dictionar sau mesaj de eroare
    """
    raspuns={}
    nr=1
    ok=False
    for i in cheltuieli:
        if int(cheltuieli[i]['suma'])<suma:
            ok=True
            raspuns[nr]=cheltuieli[i]
            nr+=1
    if ok==False:
        return "Nu exista cheltuieli cu suma mai mica decat cea introdusa"
    else:
        return raspuns

test_elimina_suma()

def test_sterge_ziua():
    assert sterge_ziua({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'15','suma':'750', 'tip':'altele'}},15)=={1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'}}
    assert sterge_ziua({1: {'ziua': '30', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'30','suma':'500', 'tip':'intretinere'},3: { 'ziua':'30','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}},30)=={}
    assert sterge_ziua({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}},1)=={1: {'ziua':'7','suma':'500', 'tip':'intretinere'},2: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},3: { 'ziua':'30','suma':'750', 'tip':'altele'}}

def sterge_ziua(cheltuieli,ziua):
    """
    Sterge cheltuielile din ziua data
    cheltuieli dictionar, ziua numar intreg
    returneaza dictionar
    """
    raspuns={}
    nr=1
    for i in cheltuieli:
        if int(cheltuieli[i]['ziua'])!=ziua:
            raspuns[nr]={}
            raspuns[nr]=cheltuieli[i]
            nr+=1
    return raspuns

test_sterge_ziua()

def test_sterge_intre_zile():
    assert sterge_intre_zile({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'15','suma':'750', 'tip':'altele'}},15,17)=={1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'}}
    assert sterge_intre_zile({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'15','suma':'750', 'tip':'altele'}},1,31)=={}
    assert sterge_intre_zile({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'15','suma':'750', 'tip':'altele'}},31,1)=={}

def sterge_intre_zile(cheltuieli,ziuain,ziuasf):
    """
    Sterge cheltuielile efectuate intre 2 zile date (inclusiv)
    cheltuieli dictionar, ziuain,ziuasf numere intregi
    returneaza dictionar
    """
    if ziuain>ziuasf:
        aux=ziuain
        ziuain=ziuasf
        ziuasf=aux
    raspuns={}
    nr=1
    for i in cheltuieli:
        if int(cheltuieli[i]['ziua'])<ziuain or int(cheltuieli[i]['ziua'])>ziuasf:
            raspuns[nr]={}
            raspuns[nr]=cheltuieli[i]
            nr+=1
    return raspuns

test_sterge_intre_zile()

def test_sterge_tip():
    assert sterge_tip({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}},'altele')=={1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'}}
    assert sterge_tip({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'mancare'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}},'mancare')=={1: {'ziua':'7','suma':'500', 'tip':'intretinere'},2: { 'ziua':'30','suma':'750', 'tip':'altele'}}
    assert sterge_tip({1: {'ziua': '1', 'suma': '60', 'tip': 'telefon'},2: {'ziua':'7','suma':'500', 'tip':'telefon'},3: { 'ziua':'15','suma':'200', 'tip':'telefon'},4: { 'ziua':'30','suma':'750', 'tip':'telefon'}},'telefon')=={}

def sterge_tip(cheltuieli,tip):
    """
    Sterge cheltuielile de un anumit tip
    cheltuieli dictionar, tip string
    returneaza dictionar 
    """
    raspuns={}
    nr=1
    for i in cheltuieli:
        if cheltuieli[i]['tip']!=tip:
            raspuns[nr]=cheltuieli[i]
            nr+=1
    return raspuns

test_sterge_tip()

def test_suma_totala_tip():
    assert suma_totala_tip({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}},'mancare')==60
    assert suma_totala_tip({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'altele'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}},'altele')==1250
    assert suma_totala_tip({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'imbracaminte'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}},'telefon')=='Nu exista cheltuieli de acest tip'

def suma_totala_tip(cheltuieli,tip):
    """
    Insumeaza cheltuielile de un anumit tip
    cheltuieli dictionar, tip string
    returneaza suma sau mesaj de eroare 
    """
    suma=0
    ok=False
    for i in cheltuieli:
        if cheltuieli[i]['tip']==tip:
            suma=suma+int(cheltuieli[i]['suma'])
            ok=True
    if ok==True: return suma
    else: return "Nu exista cheltuieli de acest tip"

test_suma_totala_tip()

def test_ziua_suma_maxima():
    assert ziua_suma_maxima({1: {'ziua': '1','suma': '60','tip': 'mancare'},2: {'ziua':'7','suma':'500','tip':'intretinere'},3: {'ziua':'15','suma':'200','tip':'imbracaminte'},4: {'ziua':'30','suma':'750','tip':'altele'}})==30
    assert ziua_suma_maxima({1: {'ziua': '1','suma': '60','tip': 'mancare'},2: {'ziua':'7','suma':'500','tip':'intretinere'},3: {'ziua':'7','suma':'200','tip':'imbracaminte'},4: {'ziua':'30','suma':'650','tip':'altele'}})==7
    assert ziua_suma_maxima({1: {'ziua': '1','suma': '60','tip': 'mancare'},2: {'ziua':'1','suma':'500','tip':'intretinere'},3: {'ziua':'1','suma':'200','tip':'imbracaminte'},4: {'ziua':'30','suma':'750','tip':'altele'}})==1

def ziua_suma_maxima(cheltuieli):
    """
    Insumeaza cheltuielile din fiecare zi si gaseste ziua cu suma maxima
    cheltuieli dictionar
    returneaza suma 
    """
    suma={}
    nr=0
    sumamax=0
    for i in cheltuieli:
        if len(suma)==0:
            nr+=1
            suma[nr]={}
            suma[nr]=cheltuieli[i]
        else:
            if suma[nr]['ziua']==cheltuieli[i]['ziua']:
                suma[nr]['suma']=int(suma[nr]['suma'])+int(cheltuieli[i]['suma'])
            else:
                nr+=1
                suma[nr]={}
                suma[nr]=cheltuieli[i]
    for i in suma:
        if(int(suma[i]['suma'])>sumamax):
            sumamax=int(suma[i]['suma'])
            ziua=int(suma[i]['ziua'])
    return ziua

test_ziua_suma_maxima()

def test_suma_egala():
    assert suma_egala({1: {'ziua': '1','suma': '60','tip': 'mancare'},2: {'ziua':'7','suma':'500','tip':'intretinere'},3: {'ziua':'15','suma':'200','tip':'imbracaminte'},4: {'ziua':'30','suma':'750','tip':'altele'}},500)=={1: {'ziua':'7','suma':'500', 'tip':'intretinere'}}
    assert suma_egala({1: {'ziua': '1','suma': '60','tip': 'mancare'},2: {'ziua':'7','suma':'200','tip':'intretinere'},3: {'ziua':'15','suma':'200','tip':'imbracaminte'},4: {'ziua':'30','suma':'750','tip':'altele'}},200)=={1: {'ziua':'7','suma':'200','tip':'intretinere'},2: {'ziua':'15','suma':'200','tip':'imbracaminte'}}
    assert suma_egala({1: {'ziua': '1','suma': '60','tip': 'mancare'},2: {'ziua':'7','suma':'500','tip':'intretinere'},3: {'ziua':'15','suma':'200','tip':'imbracaminte'},4: {'ziua':'30','suma':'750','tip':'altele'}},50)=='Nu exista cheltuieli care au suma egala cu cea data'

def suma_egala(cheltuieli,suma):
    """
    Cauta cheltuielile egale cu suma data
    cheltuieli dictionar, suma numar real
    returneaza dictionar sau mesaj de eroare
    """
    raspuns={}
    nr=0
    ok=False
    for i in cheltuieli:
        if int(cheltuieli[i]['suma'])==suma:
            nr+=1
            raspuns[nr]={}
            raspuns[nr]=cheltuieli[i]
            ok=True
    if ok==True: return raspuns
    else: return "Nu exista cheltuieli care au suma egala cu cea data"

test_suma_egala()

def test_sortare_tip():
    assert sortare_tip({1: {'ziua': '1','suma': '60','tip': 'mancare'},2: {'ziua':'7','suma':'500','tip':'intretinere'},3: {'ziua':'15','suma':'200','tip':'imbracaminte'},4: {'ziua':'30','suma':'750','tip':'altele'}})=={1: {1: { 'ziua':'30','suma':'750', 'tip':'altele'}},2: {1: { 'ziua':'15','suma':'200', 'tip': 'imbracaminte'}},3: {1: {'ziua':'7','suma':'500', 'tip':'intretinere'}},4: {1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'}}}
    assert sortare_tip({1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'},2: {'ziua':'7','suma':'500', 'tip':'intretinere'},3: { 'ziua':'15','suma':'200', 'tip':'intretinere'},4: { 'ziua':'30','suma':'750', 'tip':'altele'}})=={1: {1: { 'ziua':'30','suma':'750', 'tip':'altele'}},2: {1: {'ziua':'7','suma':'500', 'tip':'intretinere'},2: { 'ziua':'15','suma':'200', 'tip': 'intretinere'}},3: {1: {'ziua': '1', 'suma': '60', 'tip': 'mancare'}}}
    assert sortare_tip({1: {'ziua': '1','suma': '60','tip': 'altele'},2: {'ziua':'7','suma':'500','tip':'altele'},3: {'ziua':'15','suma':'200','tip':'imbracaminte'},4: {'ziua':'30','suma':'750','tip':'altele'}})=={1: {1: {'ziua': '1','suma': '60','tip': 'altele'},2: {'ziua':'7','suma':'500','tip':'altele'},3: {'ziua':'30','suma':'750','tip':'altele'}},2: {1: { 'ziua':'15','suma':'200', 'tip': 'imbracaminte'}}}

def sortare_tip(cheltuieli):
    """
    Aranjeaza cheltuielile in ordinea alfabetica a tipurilor lor
    cheltuieli dictionar
    returneaza dictionar
    """
    raspuns={}
    altele={}
    mancare={}
    telefon={}
    imbracaminte={}
    intretinere={}
    nr=0
    alt=0
    man=0
    tel=0
    imb=0
    intr=0
    for i in cheltuieli:
        if cheltuieli[i]['tip']=='altele':
            alt+=1
            altele[alt]=cheltuieli[i]
        if cheltuieli[i]['tip']=='imbracaminte':
            imb+=1
            imbracaminte[imb]=cheltuieli[i]
        if cheltuieli[i]['tip']=='intretinere':
            intr+=1
            intretinere[intr]=cheltuieli[i]
        if cheltuieli[i]['tip']=='mancare':
            man+=1
            mancare[man]=cheltuieli[i]
        if cheltuieli[i]['tip']=='telefon':
            tel+=1
            telefon[tel]=cheltuieli[i]
    if alt!=0:
        nr+=1
        raspuns[nr]=altele
    if imb!=0:
        nr+=1
        raspuns[nr]=imbracaminte
    if intr!=0:
        nr+=1
        raspuns[nr]=intretinere
    if man!=0:
        nr+=1
        raspuns[nr]=mancare
    if tel!=0:
        nr+=1
        raspuns[nr]=telefon
    return raspuns
test_sortare_tip()  
def test_undo():
    assert undolast([{},{1: {'ziua': '1','suma': '60','tip': 'mancare'}},{1: {'ziua': '1','suma': '60','tip': 'mancare'},2: {'ziua':'7','suma':'500','tip':'intretinere'}}])=={1: {'ziua': '1','suma': '60','tip': 'mancare'}}
    assert undolast([{},{1: {'ziua': '1','suma': '60','tip': 'mancare'}}])=={}   
    assert undolast([])=='Nu exista operatii care sa poata fi refacute'                                                                                                                                                                                                                                                                                               

def undolast(undolist):
    """
    Reface ultima operatie executata
    undolist lista
    returneaza dictionar
    """
    if undolist==[]:
        return "Nu exista operatii care sa poata fi refacute"
    else:
        undolist.pop()
        cheltuieli={}
        if undolist==[]:
            return cheltuieli
        else:
            cheltuieli=undolist.pop()
        return cheltuieli
test_undo()

def meniu_Adauga_cheltuiala(cheltuieli):
    print("1.Adauga o cheltuiala noua")
    print("2.Actualizeaza o cheltuiala existenta")
    func=int(input("Introduceti optiunea dorita: "))
    if func==1:
        ziua=input("Introduceti ziua in care ati cheltuit banii: ")
        while int(ziua)<1 or int(ziua)>31:
            print("Ziua introdusa nu se afla in intervalul [1,31] ")
            print("Introduceti din nou ziua dorita")
            ziua=input("Introduceti ziua in care ati cheltuit banii: ")
        suma=input("Introduceti suma cheltuita: ")
        print("Tipurile de cheltuieli valide pentru aceasta aplicatie sunt mancare, intretinere, imbracaminte, telefon, altele")
        tip=input("Introduceti tipul cheltuielii: ")
        print(adauga_cheltuiala(cheltuieli,ziua,suma,tip))
    elif func==2:
        ziua=input("Introduceti ziua cheltuielii pe care doriti sa o actualizati: ")
        while int(ziua)<1 or int(ziua)>31:
            print("Ziua introdusa nu se afla in intervalul [1,31] ")
            print("Introduceti din nou ziua dorita")
            ziua=input("Introduceti ziua in care ati cheltuit banii: ")
        suma=input("Introduceti suma cheltuita: ")
        print("Tipurile de cheltuieli valide pentru aceasta aplicatie sunt mancare, intretinere, imbracaminte, telefon, altele")
        tip=input("Introduceti tipul cheltuielii: ")
        while tip!='mancare' and tip!='intretinere' and tip!='imbracaminte' and tip!='telefon' and tip!='altele':
            print("Tipul introdus nu este un tip valabil. Introduceti un tip dintre cele disponibile")
            tip=input("Introduceti tipul cheltuielii: ")
        print(actualizare_cheltuiala(cheltuieli,ziua,suma,tip))

def meniu_Cautari(cheltuieli):
    print("1.Tipareste toate cheltuielile mai mari decât o suma data")
    print("2.Tipareste toate cheltuielile efectuate inainte de o zi data si mai mici decat o suma ")
    print("3.Tipareste toate cheltuielile de un anumit tip")
    func=int(input("Introduceti optiunea dorita: "))
    if func==1:
        suma=int(input("Tipareste toate cheltuielile mai mari decât o suma: "))
        print(cheltuieli_mai_mari(cheltuieli,suma))
    elif func==2:
        ziua=int(input("Se vor afisa cheltuielile efectuate inainte de data de :")) 
        suma=int(input("Si mai mici decat suma : "))
        print(cheltuieli_inainte(cheltuieli,ziua,suma))
    elif func==3:
        tip=input("Se vor afisa cheltuielile de tipul : ")
        while tip!='mancare' and tip!='intretinere' and tip!='imbracaminte' and tip!='telefon' and tip!='altele':
            print("Tipul introdus nu este un tip valabil. Introduceti un tip dintre cele disponibile")
            tip=input("Se vor afisa cheltuielile de tipul : ")
        print(cheltuieli_tip(cheltuieli,tip))

def meniu_Filtrare(cheltuieli):
    print("1.Elimina toate cheltuielile de un anumit tip")
    print("2.Elimina toate cheltuielile mai mici decât o suma data")
    func=int(input("Introduceti optiunea dorita: "))
    if func==1:
        print("Tipurile de cheltuieli valide pentru aceasta aplicatie sunt mancare, intretinere, imbracaminte, telefon, altele")
        tip=input("Introduceti tipul cheltuielii care doriti sa nu fie tiparita: ")
        while tip!='mancare' and tip!='intretinere' and tip!='imbracaminte' and tip!='telefon' and tip!='altele':
            print("Tipul introdus nu este un tip valabil. Introduceti un tip dintre cele disponibile")
            tip=input("Introduceti tipul cheltuielii care doriti sa nu fie tiparita: ")
        print(elimina_tip(cheltuieli,tip))
    else:
        suma=int(input("Introduceti suma fata de care sa se faca eliminarea: "))
        print(elimina_suma(cheltuieli,suma))

def meniu_Rapoarte(cheltuieli):
    print("1.Tipareste suma totala pentru un anumit tip de cheltuiala")
    print("2.Gaseste ziua in care suma cheltuita e maxima")
    print("3.Tipareste toate cheltuielile ce au o anumita suma")
    print("4.Tipareste cheltuielile sortate dupa tip")
    func=int(input("Introduceti optiunea dorita: "))
    if func==1:
        print("Tipurile de cheltuieli valide pentru aceasta aplicatie sunt mancare, intretinere, imbracaminte, telefon, altele")
        tip=input("Introduceti tipul cheltuielii pentru care doriti sa se faca suma totala: ")
        while tip!='mancare' and tip!='intretinere' and tip!='imbracaminte' and tip!='telefon' and tip!='altele':
            print("Tipul introdus nu este un tip valabil. Introduceti un tip dintre cele disponibile")
            tip=input("Introduceti tipul cheltuielii pentru care doriti sa se faca suma totala: ")
        print(suma_totala_tip(cheltuieli,tip))
    elif func==2:
        print(ziua_suma_maxima(cheltuieli))
    elif func==3:
        suma=int(input("Introduceti suma fata de care sa se faca comparatia: "))
        print(suma_egala(cheltuieli,suma))
    elif func==4:
        print(sortare_tip(cheltuieli))
    

def meniu():
    print("                           Meniul principal")
    print("  Aceasta aplicatie gestioneaza cheltuielile de familie efectuate intr-o luna")
    print("1.Adauga cheltuiala")
    print("2.Stergere")
    print("3.Cautari")
    print("4.Rapoarte")
    print("5.Filtrare")
    print("6.Undo")
    print("7.Iesire")

def run():
    cheltuieli={}
    undolist=[]
    n=1
    while n!=None:
        meniu()
        n=int(input("Introduceti optiunea dorita: "))
        if n==1:
            undolist.append(cheltuieli)
            meniu_Adauga_cheltuiala(cheltuieli)
        elif n==2:
            print("1.Sterge toate cheltuielile pentru ziua data")
            print("2.Sterge cheltuielile pentru un interval de timp ")
            print("3.Sterge toate cheltuielile de un anumit tip")
            func=int(input("Introduceti optiunea dorita: "))
            if func==1:
                undolist.append(cheltuieli)
                ziua=int(input("Introduceti ziua din care doriti sa stergeti cheltuielile: "))
                while int(ziua)<1 or int(ziua)>31:
                    print("Ziua introdusa nu se afla in intervalul [1,31] ")
                    print("Introduceti din nou ziua dorita")
                    ziua=int(input("Introduceti ziua din care doriti sa stergeti cheltuielile: "))
                cheltuieli=sterge_ziua(cheltuieli,ziua)
                print(cheltuieli)
            elif func==2:
                undolist.append(cheltuieli)
                ziuain=int(input("Introduceti ziua de inceput al intervalului de timp din care doriti sa stergeti cheltuielile: "))
                while int(ziuain)<1 or int(ziuain)>31:
                    print("Ziua introdusa nu se afla in intervalul [1,31] ")
                    print("Introduceti din nou ziua dorita")
                    ziuain=int(input("Introduceti ziua de inceput al intervalului de timp din care doriti sa stergeti cheltuielile: "))
                ziuasf=int(input("Introduceti ziua de sfarsit al intervalului de timp din care doriti sa stergeti cheltuielile: "))
                while int(ziuasf)<1 or int(ziuasf)>31:
                    print("Ziua introdusa nu se afla in intervalul [1,31] ")
                    print("Introduceti din nou ziua dorita")
                    ziuasf=int(input("Introduceti ziua de sfarsit al intervalului de timp din care doriti sa stergeti cheltuielile: "))
                cheltuieli=sterge_intre_zile(cheltuieli,ziuain,ziuasf)
                print(cheltuieli)
            elif func==3:
                undolist.append(cheltuieli)
                tip=input("Se vor sterge cheltuielile de tipul: ")
                while tip!='mancare' and tip!='intretinere' and tip!='imbracaminte' and tip!='telefon' and tip!='altele':
                    print("Tipul introdus nu este un tip valabil. Introduceti un tip dintre cele disponibile")
                    tip=input("Se vor sterge cheltuielile de tipul: ")
                cheltuieli=sterge_tip(cheltuieli,tip)
                print(cheltuieli)
        elif n==3:
            meniu_Cautari(cheltuieli)
        elif n==4:
            meniu_Rapoarte(cheltuieli)
        elif n==5:
            meniu_Filtrare(cheltuieli)
        elif n==6:
            raspuns=undolast(undolist)
            if raspuns=='Nu exista operatii care sa poata fi refacute':
                print(raspuns)
            else:
                cheltuieli=raspuns
                print("Undo a fost efectuat")
        elif n==7:
            n=None
        print(" \n ")

run()
    
    
