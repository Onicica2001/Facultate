from domain.entities import Emisiune

class ServiceEmisiune():
    def __init__(self,repo):
        self.__repo=repo
        self.__elemsblocate=[]
        
    def sterge(self,nume,tip):
        """
        Deletes an entity emisiune
        emisiune- Emisiune
        raise Repoexception if element not in list
        update file
        """
        emisiune=Emisiune(nume,tip,None,None)
        self.__repo.sterge(emisiune)
        
    def actualizare(self,nume,tip,durata,descriere):
        """
        Updates an entity emisiune
        emisiune- Emisiune
        raise Repoexception if element not in list
        update file
        """
        emisiune=Emisiune(nume,tip,durata,descriere)
        self.__repo.actualizeaza(emisiune)
        
    def blocheaza(self,tip):
        """
        Blocks the specified tip 
        tip- string
        adds tip to the list
        """        
        self.__elemsblocate.append(tip)
                
    def deblocheaza(self,tip):
        """
        Unblocks the specified tip
        tip-string
        removes tip from the list
        """
        i=0
        while i<len(self.__elemsblocate):
            if self.__elemsblocate[i]==tip:
                del self.__elemsblocate[i]
                i=i-1
            i+=1            
    
    def blocare_emisiune(self,tip):
        """
        Blocks/unblocks the specified tip
        tip-string
        adds to/removes from the list
        """
        if tip not in self.__elemsblocate:
            self.blocheaza(tip)
        else:
            self.deblocheaza(tip)
            
    def verificare_blocare(self,tip):
        """
        Checks if the tip is blocked or not
        tip-string
        returns True is the tip is blocked an False otherwise
        """
        if tip in self.__elemsblocate:
            return True
        else:
            return False