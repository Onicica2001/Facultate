from errors.exceptions import RepoException
class RepositoryInchiriere:

    
    def __init__(self):
        self.__elems=[]
    
    def __len__(self):
        return len(self.__elems) 
    
    
    def store(self, inchiriere):
        """
        Stores rentals in list 
        inchiriere - Inchiriere
        raise Repoexception if we have a rental with the same book id
        """
        if inchiriere in self.__elems:
            raise RepoException("Cartea nu este disponibila momentan. Va rugam reveniti!\n")
        self.__elems.append(inchiriere)

    
    def returnare(self, key_carte):
        """
        Verifies if the book with the id key_carte is rented and deletes the rent if true
        key_carte - int
        raise Repoexception if we do not have a rental with the same book id
        """
        if key_carte not in self.__elems:
            raise RepoException("Cartea nu a fost inchiriata!\n")
        for elem in self.__elems:
            if elem.get_id_carte()==key_carte:
                self.__elems.remove(elem)
                break
        
    
    def cauta_inchiriere(self,key_carte):
        """
        Searches a rent 
        key_carte - int
        raise Repoexception if we do not have a rental with the same book id
        """
        if key_carte not in self.__elems:
            raise RepoException("Cartea nu a fost inchiriata!\n")
        for elem in self.__elems:
            if elem.get_id_carte()==key_carte:
                return elem
            
    def cauta_inchiriere_recursiv(self,key_carte,lungime):
        """
        Searches a rent 
        key_carte - int
        raise Repoexception if we do not have a rental with the same book id
        """
        if key_carte not in self.__elems:
            raise RepoException("Cartea nu a fost inchiriata!\n")
        if self.__elems[lungime].get_id_carte()==key_carte:
            return self.__elems[lungime]
        else:
            return self.cauta_inchiriere_recursiv(key_carte, lungime-1)
            
    def cauta_inchiriere_client(self,key_client):
        """
        Searches a rent 
        key_client - int
        raise Repoexception if we do not have a rental with the same client id
        """
        if key_client not in self.__elems:
            raise RepoException("Clientul nu a inchiriat nicio carte\n")
        for elem in self.__elems:
            if elem.get_id_client()==key_client:
                return elem
    
    def cauta_inchiriere_client_recursiv(self,key_client,lungime):
        """
        Searches a rent 
        key_client - int
        raise Repoexception if we do not have a rental with the same client id
        """
        if key_client not in self.__elems:
            raise RepoException("Clientul nu a inchiriat nicio carte\n")
        if self.__elems[lungime].get_id_client()==key_client:
            return self.__elems[lungime]
        else:
            return self.cauta_inchiriere_client_recursiv(key_client, lungime-1)
    
    def get_all(self):
        """
        Getter for list
        """
        return self.__elems[:]
    
    def remove_by_ID_client(self,Id_client):
        """
        Deletes a rent with the client id id_client
        id_client - int
        """
        k=0
        try:
            while k< self.__len__():
                if self.__elems[k].get_id_client()==Id_client:
                    del self.__elems[k]
                    return 
                k+=1
        except:
            None
    
    def remove_by_ID_carte(self,Id_carte):
        """
        Deletes a rent with the book id id_carte
        id_carte - int
        """
        e=0
        try:
            while e < self.__len__():
                if self.__elems[e].get_id_carte()==Id_carte:
                    del self.__elems[e]
                    return
                e+=1
        except:
            None



