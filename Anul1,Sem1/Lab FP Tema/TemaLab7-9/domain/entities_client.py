
class Client:
    def __init__(self,id_client,nume,cnp):
        self.__id_client = id_client
        self.__nume = nume
        self.__cnp = cnp

    def get_id_client(self):
        return self.__id_client


    def get_nume(self):
        return self.__nume


    def get_cnp(self):
        return self.__cnp
    
    
    def __len__(self):
        return len(self.__list)
    
        
    def get_list(self):
        return self.__list
    
    
    def __str__(self):
        return str(self.__id_client)+" "+self.__nume+" "+str(self.__cnp)
    
    
    def __eq__(self,other):
        return self.__id_client == other
    
    def get_client(self):
        return [self.__id_client, self.__nume, self.__cnp]


    
    
        