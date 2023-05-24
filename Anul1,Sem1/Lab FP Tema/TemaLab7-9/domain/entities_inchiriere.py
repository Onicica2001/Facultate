class Inchiriere():
    
    
    def __init__(self, id_carte, id_client):
        self.__id_carte=id_carte
        self.__id_client=id_client

    
    def get_id_client(self):
        return self.__id_client
        
    def get_id_carte(self):
        return self.__id_carte
    
    def __eq__(self,ot):
        return self.__id_carte==ot
    
    def __str__(self):
        return "Cartea cu id-ul "+str(self.__id_carte)+" a fost inchiriata de clientul cu id-ul "+str(self.__id_client)
    
    
    
    



