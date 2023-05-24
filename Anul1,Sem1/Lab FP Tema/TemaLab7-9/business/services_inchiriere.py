from domain.entities_inchiriere import Inchiriere
from errors.exceptions import RepoException, ValidationException,\
    ServiceException
from utils.sortari import Quicksort,Gnomesort, Gnomesort2key
from utils.keys import key_sortare_nume,key_sortare_inchirieri,key_sortare_nume_inchirieri
class ServiceInchiriere():

    
    def __init__(self, service_client, service_carte, repo_inchiriere, valid_inchiriere):
        self.__service_client=service_client
        self.__service_carte=service_carte
        self.__repo_inchiriere=repo_inchiriere
        self.__valid_inchiriere=valid_inchiriere
        self.__numar_inchirieri={}   
        self.__numar_inchirieri_client={}   
        self.__autor_carte_inchiriata={}
    
    
    def add_inchiriere(self, id_carte, id_client):
        """
        Store a rent
        id_carte - int , id_client - int
        raise RepoException if a rent with this id exists and the book is still rented
        raise ValidationException if the rent is invalid
        """
        inchiriere=Inchiriere(id_carte,id_client)
        self.__valid_inchiriere.valideaza(inchiriere)
        self.__service_carte.search_id(id_carte)
        self.__service_client.search_id(id_client)
        self.__repo_inchiriere.store(inchiriere)
        self.__inchiriere_carte(id_carte)
        self.__inchiriere_client(id_client)
        self.__autor_carte(self.__service_carte.search_id(id_carte).get_autor())

    def get_list(self):
        return self.__repo_inchiriere.get_all()
    
    def autori_carti_inchiriate_dupa_inchirieri(self):
        inchirieri_carti=self.__autor_carte_inchiriata
        lista=[]
        for elem,val in inchirieri_carti.items():
            lista.append([elem,val])
        lista=Quicksort(lista, key_sortare_inchirieri,reverse=True)
        #lista=Gnomesort(lista, key_sortare_inchirieri,reverse=True)
        return lista
    
    def sorteaza_client_nume(self):
        """
        Sort clients with current rented books by name
        """
        lista=self.get_list()
        elems=[]
        for x in range(len(lista)):
                elems.append(self.__service_client.search_id(lista[x].get_id_client()))
        #elems=Quicksort(elems, key_sortare_nume)
        elems=Gnomesort(elems, key_sortare_nume)
        rasp=[]          
        for e in range(len(elems)):
            if elems[e] not in rasp:
                rasp.append(elems[e])
        return rasp
        
    def __inchiriere_carte(self,id_carte):
        if id_carte not in self.__numar_inchirieri:
            self.__numar_inchirieri[id_carte]=1
        else:
            self.__numar_inchirieri[id_carte]+=1
            
    def __inchiriere_client(self,id_client):
        if id_client not in self.__numar_inchirieri_client:
            self.__numar_inchirieri_client[id_client]=1
        else:
            self.__numar_inchirieri_client[id_client]+=1
            
    def __autor_carte(self,autor):
        if autor not in self.__autor_carte_inchiriata:
            self.__autor_carte_inchiriata[autor]=1
        else:
            self.__autor_carte_inchiriata[autor]+=1
    
    def get_no_inchirieri(self):
        return len(self.__repo_inchiriere)
    
    def __sterge_autor_carte(self,autor,nr_carti):
        if self.__autor_carte_inchiriata[autor]==nr_carti:
            del self.__autor_carte_inchiriata[autor]
        else:
            self.__autor_carte_inchiriata[autor]=self.__autor_carte_inchiriata[autor]-nr_carti
            
    def returnare(self,key_carte):
        """
        Verifies if the book with the id key_carte is rented and deletes the rent if true
        key_carte - int
        raise Repoexception if we do not have a rental with the same book id
        """
        self.__service_carte.search_id(key_carte)
        self.__repo_inchiriere.cauta_inchiriere_recursiv(key_carte,len(self.__repo_inchiriere)-1)
        self.__repo_inchiriere.returnare(key_carte)
        
    def check_carti(self):
        if self.__service_carte.get_no_carte()==0:
            raise ValidationException("Nu exista carti!")
    
    
    def check_client(self):
        if self.__service_client.get_no_client()==0:
            raise ValidationException("Nu exista clienti!")
        
    def sterge_numar_inchirieri_client(self,id_client):
        if id_client in self.__numar_inchirieri_client.keys():
            del self.__numar_inchirieri_client[id_client]
        
    def remove_by_ID_client(self,id_client):
        inchiriere=Inchiriere(2,id_client)
        self.__valid_inchiriere.valideaza(inchiriere)
        self.__repo_inchiriere.remove_by_ID_client(id_client)
        
    def sterge_numar_inchirieri_carte(self,id_carte):
        self.__sterge_autor_carte(self.__service_carte.search_id(id_carte).get_autor(),self.__numar_inchirieri[id_carte])
        if id_carte in self.__numar_inchirieri.keys():
            del self.__numar_inchirieri[id_carte]
        
    def cauta_inchiriere_client(self,id_client):  
        self.__repo_inchiriere.cauta_inchiriere_client_recursiv(id_client,len(self.__repo_inchiriere)-1)  
    
    def cauta_inchiriere_carte(self,id_carte):
        self.__repo_inchiriere.cauta_inchiriere_recursiv(id_carte,len(self.__repo_inchiriere)-1)
        
    def remove_by_ID_carte(self,id_carte):
        inchiriere=Inchiriere(id_carte,2)
        self.__valid_inchiriere.valideaza(inchiriere)
        self.__repo_inchiriere.remove_by_ID_carte(id_carte)
        
    def __cele_mai_inchiriate_carti(self):
        max1=0
        max2=0
        lista=self.__numar_inchirieri
        for elem in lista.values():
            if elem>max1:
                max2=max1
                max1=elem
            elif elem>max2:
                max2=elem              
        ans=[]      
        for k,elem in lista.items():
            if elem==max1:
                ans.append(k)
        if max1!=max2:
            for k,elem in lista.items():
                if elem==max2:
                    ans.append(k)
        return ans

    def len_numar_inchirieri(self):
        return len(self.__numar_inchirieri)
    
    
    def numar_inchirieri(self):
        return self.__numar_inchirieri
    
    def cartile_cele_mai_inchiriate(self):
        if self.len_numar_inchirieri()==0:
            raise ServiceException("Nu exista carti inchiriate!")
        elif self.len_numar_inchirieri()==1:
            return self.numar_inchirieri()
        else:
            return self.__cele_mai_inchiriate_carti()
      
    def sorteaza_client_dupa_inchirieri(self):
        d=self.__numar_inchirieri_client
        lista=[]
        for elem,val in d.items():
            lista.append([self.__service_client.search_id(elem).get_nume(),val])
        #lista=Quicksort(lista, key_sortare_inchirieri,reverse=True)
        #lista=Gnomesort(lista, key_sortare_inchirieri,reverse=True)
        lista=Gnomesort2key(lista, key_sortare_inchirieri,key_sortare_nume_inchirieri,reverse=True)
        return lista
    
    def active_clients_20(self):
        lista=self.sorteaza_client_dupa_inchirieri()
        if len(lista)<5:
            raise ServiceException("Trebuie sa existe cel putin 5 clienti cu carti inchiriate!")
        nr=len(lista)//5
        ans=[]
        for k in range(nr):
            ans.append(lista[k])
        return ans
    
    def check_inchiriere_carte(self):
        if self.__repo_inchiriere.get_all()==[]:
            raise ValidationException("Nu exista carti inchiriate!")
