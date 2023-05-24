from errors.exceptions import RepoException
class RepositoryClient:
    """
    Manage the store/retrieval of clients
    """
    
    def __init__(self):
        self.__elems=[]
    
    def __len__(self):
        return len(self.__elems)

    
    def store(self, client):
        """
        Stores clients in list 
        client - Client
        raise Repoexception if we have a client with the same id
        """
        if client in self.__elems:
            raise RepoException("element existent!\n")
        self.__elems.append(client)

    
    def search_id(self, key_client):
        """
        Searches a client in list
        key_client - int
        raise Repoexception if we do not have a client with the id mentioned
        """
        if key_client not in self.__elems:
            raise RepoException("element inexistent!\n")
        for elem in self.__elems:
            if elem==key_client:
                return elem

    
    def update(self, client):
        """
        Updates the data of a client
        client - Client
        raise Repoexception if we do not have a client with the id mentioned
        """
        if client not in self.__elems:
            raise RepoException("element inexistent!\n")
        for i in range(len(self.__elems)):
            if self.__elems[i]==client:
                self.__elems[i]=client
                return

    
    def remove(self, key_client):
        """
        Removes a client from list
        key_client - int
        raise Repoexception if we do not have a client with the id mentioned
        """
        if key_client not in self.__elems:
            raise RepoException("element inexistent!\n")
        i=0
        while i < len(self.__elems):
            if self.__elems[i]==key_client:
                del self.__elems[i]
                i=i-1
            i+=1
    
    def get_all(self):
        """
        Getter for list
        """
        return self.__elems[:]

    
    def search_nume(self,nume_client):
        """
        Searches a client in list
        nume_client - string
        raise Repoexception if we do not have a client with the name mentioned
        """
        lista_aux=[]
        for i in self.__elems:
            if nume_client.lower() in i.get_nume().lower():
                lista_aux.append(i.get_client())
        if lista_aux==None:
            raise RepoException("element inexistent!\n")
        return lista_aux

    
    def search_cnp(self,cnp_client):
        """
        Searches a client in list
        cnp_client - string
        raise Repoexception if we do not have a client with the cnp mentioned
        """
        lista_aux=[]
        for i in self.__elems:
            if cnp_client.lower() in i.get_cnp().lower():
                lista_aux.append(i.get_client())
        if lista_aux==None:
            raise RepoException("element inexistent!\n")
        return lista_aux

    
    
    
    
    
    
    
    
    
    



