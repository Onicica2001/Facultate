from domain.entities import Carte
from random import randint
from errors.exceptions import ValidationException, RepoException

class ServiceCarte:
    """
    Use case coordinator for CRUD Operations on books
    """
    
    def __init__(self,repo_carte,valid_carte):
        self.__repo_carte=repo_carte
        self.__valid_carte=valid_carte

    
    def add_carte(self, id_carte, titlu, descriere, autor):
        """
        Store a book
        id_carte - int
        titlu, descriere, autor of the book as strings
        raise RepoException if a book with this id already exists
        raise ValidationException if the book is invalid
        """
        carte=Carte(id_carte,titlu,descriere,autor)
        self.__valid_carte.valideaza(carte)
        self.__repo_carte.store(carte)

    
    def get_no_carte(self):
        """
        Getter for number of books
        """
        return len(self.__repo_carte)
    
    def get_carti(self):
        """
        Getter for list of books
        """
        return self.__repo_carte.get_all()
    
    def update_carte(self, id_carte, titlu, descriere, autor):
        """
        Update a book
        id_carte - int
        titlu, descriere, autor of the book as strings
        raise RepoException if we do not have a book with the id mentioned
        raise ValidationException if the book is invalid
        """
        carte=Carte(id_carte,titlu,descriere,autor)
        self.__valid_carte.valideaza(carte)
        self.__repo_carte.update(carte)

    
    def remove_carte(self,id_carte):
        """
        Removes a book
        id_carte - int
        raise RepoException if we do not have a book with the id mentioned
        """
        self.__repo_carte.remove(id_carte)

    
    def search_id(self,id_carte):
        """
        Searches a book after id
        id_carte - int
        raise RepoException if we do not have a book with the id mentioned
        """
        return self.__repo_carte.search_id(id_carte)

    
    def search_titlu(self,titlu_carte):
        """
        Searches a book after title
        titlu_carte - string
        raise RepoException if we do not have a book with the title mentioned
        """
        return self.__repo_carte.search_titlu(titlu_carte)

    
    def search_autor(self,autor_carte):
        """
        Searches a book after author
        autor_carte - string
        raise RepoException if we do not have a book with the author mentioned
        """
        return self.__repo_carte.search_autor(autor_carte)
    
    def generate_carti(self,nr_carti):
        """
        Generates books
        nr_carti - int
        """
        listastring="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        i=0
        while i<nr_carti:
            id_carte=randint(1,50)
            x=randint(0,51)
            y=randint(x,51)
            z=randint(y,51)
            titlu_carte=""
            descriere=""
            autor_carte=""
            for j in range(x,y):
                titlu_carte=listastring[j]+titlu_carte
            for j in range(x,z):
                descriere=listastring[j]+descriere
            for j in range(y,z):
                autor_carte=listastring[j]+autor_carte
            try:
                self.add_carte(id_carte,titlu_carte,descriere,autor_carte)
            except ValidationException:
                i=i-1
            except RepoException:
                i=i-1
            i+=1
                
    
    
    
    
    
    
    
    
    
    
    
    



