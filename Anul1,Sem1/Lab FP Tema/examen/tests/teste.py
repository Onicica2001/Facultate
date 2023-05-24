from domain.entities import Emisiune
from infrastructure.repository import RepositoryEmisiuni
from bussiness.service import ServiceEmisiune
from exceptions.exceptii import RepoException
class Teste():
    def TesteDomain(self):
        nume="Digi24"
        tip="stiri"
        durata=4
        descriere="buletin de stiri"
        emisiune=Emisiune(nume,tip,durata,descriere)
        assert(str(emisiune)=="Digi24,stiri,4,buletin de stiri\n")
        
    def TesteRepository(self):
        file=open("Teste.txt")
        continut=file.read()
        lines=continut.split('\n')
        assert(lines[0]=="Digi24,stiri,2,buletin de stiri")
        assert(lines[1]=="HBO,filme,7,filme de groaza")
        assert(lines[2]=="RealitateaPlus,stiri,3,stirile zilei")
        assert(lines[3]=="KanalD,filme,8,seriale turcesti")
        assert(lines[4]=="Happy,filme,18,seriale turcesti si indiene")
        assert(lines[5]=="AXN,filme,24,filme politiste si de groaza")
        assert(lines[6]=="Disney Channel,entertainment,16,desene animate si filme pentru copii")
        assert(lines[7]=="Cartoon Network,entertainment,20,desene animate")
        assert(lines[8]=="History,istorie,14,emisiuni despre istorie")
        assert(lines[9]=="TVR1,stiri,6,stirile televiziunii romane")
        repo=RepositoryEmisiuni("Teste.txt")
        emisiune=Emisiune("Digi24","stiri",4,"stiri")
        repo.actualizeaza(emisiune)
        file=open("Teste.txt")
        continut=file.read()
        lines=continut.split('\n')
        assert(lines[0]=="Digi24,stiri,4,stiri")
        assert(lines[1]=="HBO,filme,7,filme de groaza")
        assert(lines[2]=="RealitateaPlus,stiri,3,stirile zilei")
        assert(lines[3]=="KanalD,filme,8,seriale turcesti")
        assert(lines[4]=="Happy,filme,18,seriale turcesti si indiene")
        assert(lines[5]=="AXN,filme,24,filme politiste si de groaza")
        assert(lines[6]=="Disney Channel,entertainment,16,desene animate si filme pentru copii")
        assert(lines[7]=="Cartoon Network,entertainment,20,desene animate")
        assert(lines[8]=="History,istorie,14,emisiuni despre istorie")
        assert(lines[9]=="TVR1,stiri,6,stirile televiziunii romane")
        emisiune=Emisiune("Digi24","stiri",4,"stiri")
        repo.sterge(emisiune)
        file=open("Teste.txt")
        continut=file.read()
        lines=continut.split('\n')
        assert(lines[0]=="HBO,filme,7,filme de groaza")
        assert(lines[1]=="RealitateaPlus,stiri,3,stirile zilei")
        assert(lines[2]=="KanalD,filme,8,seriale turcesti")
        assert(lines[3]=="Happy,filme,18,seriale turcesti si indiene")
        assert(lines[4]=="AXN,filme,24,filme politiste si de groaza")
        assert(lines[5]=="Disney Channel,entertainment,16,desene animate si filme pentru copii")
        assert(lines[6]=="Cartoon Network,entertainment,20,desene animate")
        assert(lines[7]=="History,istorie,14,emisiuni despre istorie")
        assert(lines[8]=="TVR1,stiri,6,stirile televiziunii romane")
        try: 
            repo.actualizeaza(emisiune)
            assert(False)
        except RepoException as re:
            assert(True)
        try: 
            repo.sterge(emisiune)
            assert(False)
        except RepoException as re:
            assert(True)
        
    def TesteService(self):
        repo=RepositoryEmisiuni("Teste.txt")
        service=ServiceEmisiune(repo)
        tip="stiri"
        service.blocheaza(tip)
        assert(service.verificare_blocare(tip)==True)
        assert(service.verificare_blocare("filme")==False)
        
    def run_all_tests(self):
        self.TesteDomain()
        self.TesteRepository()
        self.TesteService()