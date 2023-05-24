from domain.entities_inchiriere import Inchiriere
from infrastructure.repositories_inchiriere import RepositoryInchiriere
class FileRepositoryInchiriere(RepositoryInchiriere):
    """
    Manage the store/retrieval of rents from files
    """
    def __init__(self,fileName):
        RepositoryInchiriere.__init__(self)
        self.__filename=fileName
        self.__LoadFromFile()
        
    def __CreateInchiriereLine(self,line):
        """
        Process the a line from the file and create a rent
        return client
        """
        field=line.split(" ")
        inchiriere=Inchiriere(int(field[0]),int(field[1]))
        return inchiriere
        
    def __LoadFromFile(self):
        """
         Load client from file
         Load file at once
        """
        file=open(self.__filename)
        continut=file.read()
        file.close()
        lines=continut.split('\n')
        for line in lines:
            if line.strip()=="":
                continue
            inchiriere=self.__CreateInchiriereLine(line)
            RepositoryInchiriere.store(self,inchiriere)
    
    def store(self, inchiriere):
        RepositoryInchiriere.store(self, inchiriere)
        self.__appendToFile(inchiriere)
        
    def __appendToFile(self,inchiriere):
        """
          Append a new line in the file representing the rent inchiriere
        """
        file=open(self.__filename,"a")
        line=str(inchiriere.get_id_carte())+" "+str(inchiriere.get_id_client())
        file.write("\n")
        file.write(line)
        file.close()
        
    def returnare(self, key_carte):
        RepositoryInchiriere.returnare(self, key_carte)
        self.__SaveToFile()
        
    def remove_by_ID_carte(self, Id_carte):
        RepositoryInchiriere.remove_by_ID_carte(self, Id_carte)
        self.__SaveToFile()
        
    def remove_by_ID_client(self, Id_client):
        RepositoryInchiriere.remove_by_ID_client(self, Id_client)
        self.__SaveToFile()
    
    def __SaveToFile(self):
        lista=self.get_all()
        file=open(self.__filename,"w")
        for elem in lista:
            self.__appendToFile(elem)
        file.close()
    
    