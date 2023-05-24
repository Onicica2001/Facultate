from infrastructure.repositories import RepositoryCarte
from domain.entities import Carte
class FileRepositoryCarte(RepositoryCarte):
    """
    Manage the store/retrieval of books from files
    """
    def __init__(self,fileName):
        RepositoryCarte.__init__(self)
        self.__filename=fileName
        self.__LoadFromFile()
        
    def __CreateCarteLine(self,line):
        """
        Process a line from the file and create a book
        return carte
        """
        field=line.split(" ")
        carte=Carte(int(field[0]),field[1],field[2],field[3])
        return carte
        
    def __LoadFromFile(self):
        """
         Load book from file
         Load file at once
        """
        file=open(self.__filename)
        continut=file.read()
        file.close()
        lines=continut.split('\n')
        for line in lines:
            if line.strip()=="":
                continue
            carte=self.__CreateCarteLine(line)
            RepositoryCarte.store(self,carte)
    
    def store(self, carte):
        RepositoryCarte.store(self, carte)
        self.__appendToFile(carte)
        
    def __appendToFile(self,carte):
        """
          Append a new line in the file representing the book carte
        """
        file=open(self.__filename,"a")
        line=str(carte.get_id_carte())+" "+carte.get_titlu()+" "+carte.get_descriere()+" "+carte.get_autor()
        file.write("\n")
        file.write(line)
        file.close()
        
    def remove(self, key_carte):
        RepositoryCarte.remove(self, key_carte)
        self.__SaveToFile()
        
    def update(self, carte):
        RepositoryCarte.update(self, carte)
        self.__SaveToFile()
    
    def __SaveToFile(self):
        lista=self.get_all()
        file=open(self.__filename,"w")
        for elem in lista:
            self.__appendToFile(elem)
        file.close()
    
    