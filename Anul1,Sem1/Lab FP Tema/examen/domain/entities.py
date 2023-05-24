class Emisiune():
    def __init__(self,nume,tip,durata,descriere):
        self.__nume = nume
        self.__tip = tip
        self.__durata = durata
        self.__descriere = descriere
        
    def get_nume(self):
        """
        Get the nume of the entity
        """
        return self.__nume
    
    def get_tip(self):
        """
        Get the tip of the entity
        """
        return self.__tip
    
    def get_durata(self):
        """
        Get the durata of the entity
        """
        return self.__durata
        
    def __eq__(self,other):
        return self.__nume==other.get_nume()
        
    def __str__(self):
        return self.__nume+','+self.__tip+','+str(self.__durata)+','+self.__descriere+'\n'