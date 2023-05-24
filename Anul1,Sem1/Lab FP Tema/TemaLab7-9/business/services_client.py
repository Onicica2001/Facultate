from domain.entities_client import Client
from random import randint
from errors.exceptions import ValidationException, RepoException

class ServiceClient:
    """
    Use case coordinator for CRUD Operations on clients
    """
    
    def __init__(self,repo_client,valid_client):
        self.__repo_client=repo_client
        self.__valid_client=valid_client

    
    def add_client(self, id_client, nume, cnp):
        """
        Store a client
        id_client - int
        nume, cnp of the client as strings
        raise RepoException if a client with this id already exists
        raise ValidationException if the client is invalid
        """
        client=Client(id_client,nume,cnp)
        self.__valid_client.valideaza_client(client)
        self.__repo_client.store(client)

    def get_no_client(self):
        """
        Getter for number of clients
        """
        return len(self.__repo_client)
    
    def get_clienti(self):
        """
        Getter for list of clients
        """
        return self.__repo_client.get_all()
    
    def update_clienti(self,id_client, nume, cnp):
        """
        Update a client
        id_client - int
        nume, cnp of the client as strings
        raise RepoException if we do not have a client with the id mentioned
        raise ValidationException if the client is invalid
        """
        client=Client(id_client,nume,cnp)
        self.__valid_client.valideaza_client(client)
        self.__repo_client.update(client)

    
    def remove_client(self,id_client):
        """
        Remove a client
        id_client - int
        raise RepoException if we do not have a client with the id mentioned
        """
        self.__repo_client.remove(id_client)

    
    def search_id(self,id_client):
        """
        Searches a client after id
        id_client - int
        raise RepoException if we do not have a client with the id mentioned
        """
        return self.__repo_client.search_id(id_client)

    
    def search_nume(self,nume_client):
        """
        Searches a client after name
        nume_client - string
        raise RepoException if we do not have a client with the name mentioned
        """
        return self.__repo_client.search_nume(nume_client)

    def get_nume_client(self):
        elems=self.__repo_client.get_all()
        
    
    def search_cnp(self,cnp_client):
        """
        Searches a client after CNP
        cnp_client - string
        raise RepoException if we do not have a client with the CNP mentioned
        """
        return self.__repo_client.search_cnp(cnp_client)
    
    
    def generate_client(self,nr_client):
        """
        Generates books
        nr_carti - int
        """
        listastring="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        i=0
        while i<nr_client:
            id_client=randint(1,50)
            x=randint(0,51)
            y=randint(x,51)
            z=randint(1000000000000,6999999999999)
            nume_client=""
            cnp=str(z)
            for j in range(x,y):
                nume_client=listastring[j]+nume_client
            try:
                self.add_client(id_client,nume_client,cnp)
            except ValidationException:
                i=i-1
            except RepoException:
                i=i-1
            i+=1
    
    
    
    
    
    
    
    
    
    
    



