from exceptions.exceptii import RepoException
class UI():

    
    def __sterge_emisiune(self):
        nume=input("Dati numele emisiunii pe care doriti sa o stergeti:")
        tip=input("Dati tipul emisiunii pe care doriti sa o stergeti:")
        if self.__service.verificare_blocare(tip)==True:
            print("emisiune blocata")
            return 
        else:
            self.__service.sterge(nume,tip)
    
    def __actualizeaza_emisiune(self):
        nume=input("Dati numele emisiunii pe care doriti sa o actualizati:")
        tip=input("Dati tipul emisiunii pe care doriti sa o actualizati:")
        if self.__service.verificare_blocare(tip)==True:
            print("emisiune blocata")
            return 
        else:
            durata=int(input("Dati durata emisiunii actualizate:"))
            descriere=input("Dati descrierea emisiunii actualizate:")
            self.__service.actualizare(nume,tip,durata,descriere)
    
    def __genereaza_program_aleator(self):
        pass
    
    
    def __blocheaza_tip_emisiuni(self):
        tip=input("Dati tipul de emisiune pe care doriti sa il blocati/deblocati:")
        if self.__service.verificare_blocare(tip)==True:
            self.__service.deblocheaza(tip)
        else:
            self.__service.blocheaza(tip)
    
    
    def __init__(self,service):
        self.__service=service
        self.__comenzi={
            "Sterge":self.__sterge_emisiune,
            "Actualizeaza":self.__actualizeaza_emisiune,
            "Program_generat":self.__genereaza_program_aleator,
            "Blocheaza":self.__blocheaza_tip_emisiuni
            }
        
        
    def run(self):
        cmd=input("Comenzile disponibile sunt:\nSterge\nActualizeaza\nProgram_generat\nBlocheaza\nExit\nIntroduceti comanda dorita:")
        if cmd=="Exit":
            return 
        else:
            if cmd not in self.__comenzi.keys():
                print("Comanda invalida!")
                self.run()
            try:
                self.__comenzi[cmd]()
            except RepoException as re:
                print(re)
            except ValueError as ve:
                print("Durata trebuie sa fie un numar natural!")
            self.run()