from domain.entities import Carte
from validation.validators import ValidatorCarte
from errors.exceptions import ValidationException,RepoException
from infrastructure.repositories import RepositoryCarte
from business.services import ServiceCarte
class TestsCarte:
    
    
    def __run_domain_tests(self):
        id_carte=23
        titlu="Ion"
        descriere="roman social"
        autor="Liviu Rebreanu"
        carte=Carte(id_carte,titlu,descriere,autor)
        assert(carte.get_id_carte()==23)
        assert(carte.get_titlu()=="Ion")
        assert(carte.get_descriere()=="roman social")
        assert(carte.get_autor()=="Liviu Rebreanu")
        assert(str(carte)=="23 Ion roman social Liviu Rebreanu")
        carte0=Carte(id_carte,titlu,None,autor)
        assert(carte==carte0)
        
    
    
    def __run_validation_tests(self):
        carte=Carte(-230,"","","")
        validator_carte=ValidatorCarte()
        try:
            validator_carte.valideaza(carte)
            assert(False)
        except ValidationException as ve:
            assert(str(ve)=="id invalid!\ntitlu invalid\nautor invalid")
        carte_valida=Carte(20,"Mara","","Ioan Slavici")
        validator_carte.valideaza(carte_valida)
        assert(True)
    
    
    def __run_repository_carte_tests(self):
        carte=Carte(23,"Ion","roman social","Liviu Rebreanu")
        repo_carte=RepositoryCarte()
        assert(len(repo_carte)==0)
        repo_carte.store(carte)
        assert(len(repo_carte)==1)
        key_carte=Carte(23,None,None,None)
        result_carte=repo_carte.search_id(key_carte)
        assert(carte.get_titlu()==result_carte.get_titlu())
        assert(carte.get_descriere()==result_carte.get_descriere())
        assert(carte.get_autor()==result_carte.get_autor())
        carte0=Carte(23,None,None,None)
        try:
            repo_carte.store(carte0)
            assert(False)
        except RepoException as re:
            assert(str(re)=="element existent!\n")
        carte1=Carte(20,"Mara","","Ioan Slavici")
        try:
            repo_carte.update(carte1)
            assert(False)
        except RepoException as re:
            assert(str(re)=="element inexistent!\n")
        carte2=Carte(23,"Moara cu noroc","nuvela psihologica","Ioan Slavici")
        repo_carte.update(carte2)
        result_carte=repo_carte.search_id(key_carte)
        assert("Moara cu noroc"==result_carte.get_titlu())
        assert("nuvela psihologica"==result_carte.get_descriere())
        assert("Ioan Slavici"==result_carte.get_autor())
        repo_carte.remove(key_carte)
        assert(len(repo_carte)==0)
        try:
            repo_carte.remove(key_carte)
            assert(False)
        except RepoException as re:
            assert(str(re)=="element inexistent!\n")
        carte=Carte(23,"Ion","roman social","Liviu Rebreanu")
        repo_carte=RepositoryCarte()
        repo_carte.store(carte)
        titlu_carte="Ion"
        result_carte=repo_carte.search_titlu(titlu_carte)
        for i in range(len(result_carte)):
            assert carte.get_carte()==result_carte[i]
        autor_carte="Liviu Rebreanu"
        result_carte=repo_carte.search_autor(autor_carte)
        for i in range(len(result_carte)):
            assert carte.get_carte()==result_carte[i]
            
    
    
    def __run_service_carte_tests(self):
        repo_carte=RepositoryCarte()
        valid_carte=ValidatorCarte()
        service_carte=ServiceCarte(repo_carte,valid_carte)
        id_carte=23
        titlu="Ion"
        descriere="roman social"
        autor="Liviu Rebreanu"
        service_carte.add_carte(id_carte,titlu,descriere,autor)
        assert(service_carte.get_no_carte()==1)
        try:
            service_carte.add_carte(id_carte,titlu,descriere,autor)
            assert(False)
        except RepoException as re:
            assert(str(re)=="element existent!\n")
        try:
            service_carte.add_carte(-id_carte,"",descriere,"")
            assert(False)
        except ValidationException as ve:
            assert(str(ve)=="id invalid!\ntitlu invalid\nautor invalid")
        
    
    
    def run_all_carte_tests(self):
        self.__run_domain_tests()
        self.__run_validation_tests()
        self.__run_repository_carte_tests()
        self.__run_service_carte_tests()
    
    



