from domain.entities import Emisiune
from exceptions.exceptii import RepoException
class RepositoryEmisiuni():
    def __init__(self,filename):
        self.__filename=filename
        self.__elems=[]
        self.__LoadFromFile()

    def __CreateEmisiune(self,line):
        """
        Creates an entity emisiune from a line
        line- a line from file
        return emisiune
        """
        field=line.split(',')
        emisiune=Emisiune(field[0],field[1],int(field[2]),field[3])
        return emisiune
    
    def __LoadFromFile(self):
        """
        Loads from the specified file into a list
        """
        file=open(self.__filename)
        continut=file.read()
        file.close()
        lines=continut.split('\n')
        for line in lines:
            if line !="":
                emisiune=self.__CreateEmisiune(line)
                self.__elems.append(emisiune)
                
    def __SaveToFile(self):
        """
        Saves into the specified file the list from memory
        """
        file=open(self.__filename,"a")
        for elem in self.__elems:
            file.write(str(elem))
        file.close()
        
    def sterge(self,emisiune):
        """
        Deletes an entity emisiune
        emisiune- Emisiune
        raise Repoexception if element not in list
        update file
        """
        if emisiune not in self.__elems:
            raise RepoException("element inexistent!\n")
        i=0
        while i<len(self.__elems):
            if self.__elems[i]==emisiune:
                del self.__elems[i]
                i=i-1
            i+=1
        self.__ClearFile()
        self.__SaveToFile()
              
    def actualizeaza(self,emisiune):
        """
        Updates an entity emisiune
        emisiune- Emisiune
        raise Repoexception if element not in list
        update file
        """
        if emisiune not in self.__elems:
            raise RepoException("element inexistent!\n")
        for i in range(len(self.__elems)):
            if self.__elems[i]==emisiune:
                self.__elems[i]=emisiune
        self.__ClearFile()
        self.__SaveToFile()        
           
    def __ClearFile(self):
        """
        Clears the specified file
        """
        file=open(self.__filename,"w")
        file.close()