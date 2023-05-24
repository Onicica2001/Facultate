from errors.exceptions import RepoException
class RepositoryCarte:
    """
    Manage the store/retrieval of books
    """
    
    def __init__(self):
        self.__elems=[]
    
    def __len__(self):
        return len(self.__elems)

    
    def store(self, carte):
        """
        Stores books in list 
        carte - Carte
        raise Repoexception if we have a book with the same id
        """
        if carte in self.__elems:
            raise RepoException("element existent!\n")
        self.__elems.append(carte)

    
    def search_id(self, key_carte):
        """
        Searches a book in list
        key_carte - int
        raise Repoexception if we do not have a book with the id mentioned
        """
        if key_carte not in self.__elems:
            raise RepoException("element inexistent!\n")
        for elem in self.__elems:
            if elem.get_id_carte()==key_carte:
                return elem

    
    def update(self, carte):
        """
        Updates the data of a book
        carte - Carte
        raise Repoexception if we do not have a book with the id mentioned
        """
        if carte not in self.__elems:
            raise RepoException("element inexistent!\n")
        for i in range(len(self.__elems)):
            if self.__elems[i]==carte:
                self.__elems[i]=carte
                return

    
    def remove(self, key_carte):
        """
        Removes a book from list
        key_carte - int
        raise Repoexception if we do not have a book with the id mentioned
        """
        if key_carte not in self.__elems:
            raise RepoException("element inexistent!\n")
        i=0
        while i < len(self.__elems):
            if self.__elems[i]==key_carte:
                del self.__elems[i]
                i=i-1
            i+=1
    
    def get_all(self):
        """
        Getter for list
        """
        return self.__elems[:]

    
    def search_titlu(self,titlu_carte):
        """
        Searches a book in list
        titlu_carte - string
        raise Repoexception if we do not have a book with the title mentioned
        """
        lista_aux=[]
        for i in self.__elems:
            if titlu_carte.lower() in i.get_titlu().lower():
                lista_aux.append(i.get_carte())
        if lista_aux==None:
            raise RepoException("element inexistent!\n")
        return lista_aux
    
    def search_autor(self,autor_carte):
        """
        Searches a book in list
        autor_carte - string
        raise Repoexception if we do not have a book with the author mentioned
        """
        lista_aux=[]
        for i in self.__elems:
            if autor_carte.lower() in i.get_autor().lower():
                lista_aux.append(i.get_carte())
        if lista_aux==None:
            raise RepoException("element inexistent!\n")
        return lista_aux
    
    
    
    
    
    
    



