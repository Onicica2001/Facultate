from infrastructure.repositories_client import RepositoryClient
from domain.entities_client import Client
class FileRepositoryClient(RepositoryClient):
    """
    Manage the store/retrieval of clients from files
    """
    def __init__(self,fileName):
        RepositoryClient.__init__(self)
        self.__filename=fileName
        self.__LoadFromFile()
        
    def __CreateClientLine(self,line):
        """
        Process the a line from the file and create a client
        return client
        """
        field=line.split(" ")
        client=Client(int(field[0]),field[1],field[2])
        return client
        
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
            client=self.__CreateClientLine(line)
            RepositoryClient.store(self,client)
    
    def store(self, client):
        RepositoryClient.store(self, client)
        self.__appendToFile(client)
        
    def __appendToFile(self,client):
        """
          Append a new line in the file representing the client client
        """
        file=open(self.__filename,"a")
        line=str(client.get_id_client())+" "+client.get_nume()+" "+client.get_cnp()
        file.write("\n")
        file.write(line)
        file.close()
        
    def remove(self, key_client):
        RepositoryClient.remove(self, key_client)
        self.__SaveToFile()
        
    def update(self, client):
        RepositoryClient.update(self, client)
        self.__SaveToFile()
    
    def __SaveToFile(self):
        lista=self.get_all()
        file=open(self.__filename,"w")
        for elem in lista:
            self.__appendToFile(elem)
        file.close()
    
    def get_nume(self):
        return self.get_nume()