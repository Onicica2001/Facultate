from errors.exceptions import RepoException
from domain.entities_client import Client
import os

class FileRepositoryClient2():
    def __init__(self,numefisier):
        self.__numefisier=numefisier
    
    def store(self,client):
        file=open(self.__numefisier)
        line=file.readline()
        while line:
            if line=="":
                line=file.readline()
            else:
                if str(client) in line:
                    file.close()
                    raise RepoException("element existent!\n")
                line=file.readline()
        if os.stat(self.__numefisier).st_size != 0 and line!='\n':
            file.close()
            file=open(self.__numefisier,"a")
            linie=str(client.get_id_client())+" "+client.get_nume()+" "+client.get_cnp()+" "
            file.write("\n")
            file.write(linie)
            file.close()
        else:
            file.close()
            file=open(self.__numefisier,"a")
            linie=str(client.get_id_client())+" "+client.get_nume()+" "+client.get_cnp()+" "
            file.write(linie)
            file.close()
        
    def update(self,client):
        exista=False
        file=open(self.__numefisier)
        fileaux=open("Auxiliar.txt","w")
        fileaux.close()
        line=file.readline()
        while line:
            if line=="":
                line=file.readline()
            else:
                field=line.split(" ")
                clientfile=Client(int(field[0]),field[1],field[2])
                if clientfile==client.get_id_client():
                    clientfile=client
                    exista=True
                fileaux=open("Auxiliar.txt","a")
                linie=str(clientfile.get_id_client())+" "+clientfile.get_nume()+" "+clientfile.get_cnp()+" "
                fileaux.write(linie)
                fileaux.write("\n")
                fileaux.close()
                line=file.readline()
        file.close()
        if exista==False:
            raise RepoException("element inexistent!\n")
        file=open(self.__numefisier,"w")
        file.close()
        if os.stat("Auxiliar.txt").st_size != 0:
            fileaux=open("Auxiliar.txt")
            line=fileaux.readline()
            while line:
                if line=='\n':
                    line=fileaux.readline()
                else:
                    file=open(self.__numefisier,"a")
                    file.write(line)
                    file.close()
                    line=fileaux.readline()
            fileaux.close()
    
        
    def remove(self,key_client):
        exista=False
        file=open(self.__numefisier)
        fileaux=open("Auxiliar.txt","w")
        fileaux.close()
        line=file.readline()
        while line:
            if line=="":
                line=file.readline()
            else:
                field=line.split(" ")
                clientfile=Client(int(field[0]),field[1],field[2])
                if clientfile==key_client:
                    print(clientfile)
                    exista=True
                    line=file.readline()
                else:
                    fileaux=open("Auxiliar.txt","a")
                    linie=str(clientfile.get_id_client())+" "+clientfile.get_nume()+" "+clientfile.get_cnp()+" "
                    fileaux.write(linie)
                    fileaux.write("\n")
                    fileaux.close()
                    line=file.readline()
        file.close()
        if exista==False:
            raise RepoException("element inexistent!\n")
        file=open(self.__numefisier,"w")
        file.close()
        if os.stat("Auxiliar.txt").st_size != 0:
            fileaux=open("Auxiliar.txt")
            line=fileaux.readline()
            while line:
                if line=='\n':
                    line=fileaux.readline()
                else:
                    file=open(self.__numefisier,"a")
                    file.write(line)
                    file.close()
                    line=fileaux.readline()
            fileaux.close()
    
    def get_all(self):
        file=open(self.__numefisier)
        elems=[]
        line=file.readline()
        while line:
            if line=="":
                line=file.readline()
            else:
                field=line.split(" ")
                clientfile=Client(int(field[0]),field[1],field[2])
                elems.append(clientfile)
                line=file.readline()
        file.close()
        return elems
    
    def search_id(self,id_client):
        exista=False
        file=open(self.__numefisier)
        line=file.readline()
        while line:
            if line=="":
                line=file.readline()
            else:
                field=line.split(" ")
                clientfile=Client(int(field[0]),field[1],field[2])
                if clientfile.get_id_client()==id_client:
                    exista=True
                    return clientfile
                line=file.readline()
        file.close()
        if exista==False:
            raise RepoException("element inexistent!\n")
        
    def search_nume(self,nume_client):
        exista=False
        lista_aux=[]
        file=open(self.__numefisier)
        line=file.readline()
        while line:
            if line=="":
                line=file.readline()
            else:
                field=line.split(" ")
                clientfile=Client(int(field[0]),field[1],field[2])
                if nume_client.lower() in clientfile.get_nume().lower():
                    lista_aux.append(clientfile.get_client())
                    exista=True
                line=file.readline()
        file.close()
        if exista==False:
            raise RepoException("element inexistent!\n")
        return lista_aux
        
    def search_cnp(self,cnp):
        exista=False
        lista_aux=[]
        file=open(self.__numefisier)
        line=file.readline()
        while line:
            if line=="":
                line=file.readline()
            else:
                field=line.split(" ")
                clientfile=Client(int(field[0]),field[1],field[2])
                if cnp in clientfile.get_cnp():
                    lista_aux.append(clientfile.get_client())
                    exista=True
                line=file.readline()
        file.close()
        if exista==False:
            raise RepoException("element inexistent!\n")
        return lista_aux
    
    def __len__(self):
        return len(self.get_all())
    