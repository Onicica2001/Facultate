
class Carte:
    def __init__(self,id_carte,titlu,descriere,autor):
        self.__id_carte = id_carte
        self.__titlu = titlu
        self.__descriere = descriere
        self.__autor = autor

    def get_id_carte(self):
        return self.__id_carte


    def get_titlu(self):
        return self.__titlu


    def get_descriere(self):
        return self.__descriere


    def get_autor(self):
        return self.__autor


    def set_descriere(self, value):
        self.__descriere = value
    
    
    def __str__(self):
        return str(self.__id_carte)+" "+self.__titlu+" "+self.__descriere+" "+self.__autor
    
    
    def __eq__(self,other):
        return self.__id_carte == other

    def get_carte(self):
        return [self.get_id_carte(), self.get_titlu(), self.get_descriere(), self.get_autor()]


    
    
        