from domain.entities_inchiriere import Inchiriere
from domain.entities_client import Client
from domain.entities import Carte
from validation.validators_inchiriere import ValidatorInchiriere
from errors.exceptions import ValidationException,RepoException,\
    ServiceException
from infrastructure.repositories_inchiriere import RepositoryInchiriere
from business.services_inchiriere import ServiceInchiriere
from infrastructure.repositories import RepositoryCarte
from infrastructure.repositories_client import RepositoryClient
from business.services_client import ServiceClient
from business.services import ServiceCarte
from validation.validators import ValidatorCarte
from validation.validators_client import ValidatorClient

class TestsInchiriere:
    
    
    def __run_domain_tests(self):
        client=Client(23,"Ion","5041126784653")
        carte=Carte(23,"Ion","roman social","Liviu Rebreanu")
        inchiriere=Inchiriere(carte.get_id_carte(),client.get_id_client())
        assert(inchiriere.get_id_client()==23)
        assert(inchiriere.get_id_carte()==23)
        inchiriere0=Inchiriere(carte.get_id_carte(),client.get_id_client())
        assert(inchiriere0.get_id_client()==23)
        assert(inchiriere0.get_id_carte()==23)
        assert(inchiriere0==inchiriere)
        
    
    
    def __run_validation_tests(self):
        client=Client(-23,"Ion","5041126784653")
        carte=Carte(-23,"Ion","roman social","Liviu Rebreanu")
        inchiriere=Inchiriere(carte.get_id_carte(),client.get_id_client())
        validator_inchiriere=ValidatorInchiriere()
        try:
            validator_inchiriere.valideaza(inchiriere)
            assert(False)
        except ValidationException as ve:
            assert(str(ve)=="id client invalid!\nid carte invalid!\n")
        client=Client(23,"Ion","5041126784653")
        carte=Carte(23,"Ion","roman social","Liviu Rebreanu")
        inchiriere_valida=Inchiriere(carte.get_id_carte(),client.get_id_client())
        validator_inchiriere.valideaza(inchiriere_valida)
        assert(True)
    
    def __run_repository_inchiriere_tests(self):
        client=Client(23,"Ion","5041126784653")
        repo_client=RepositoryClient()
        repo_client.store(client)
        carte=Carte(23,"Ion","roman social","Liviu Rebreanu")
        repo_carte=RepositoryCarte()
        repo_carte.store(carte)
        inchiriere=Inchiriere(carte.get_id_carte(),client.get_id_client())
        repo_inchiriere=RepositoryInchiriere()
        assert(len(repo_inchiriere)==0)
        repo_inchiriere.store(inchiriere)
        assert(len(repo_inchiriere)==1)
        key_carte=23
        result_inchiriere=repo_inchiriere.cauta_inchiriere(key_carte)
        assert(carte.get_id_carte()==result_inchiriere.get_id_carte())
        assert(client.get_id_client()==result_inchiriere.get_id_client())
        inchiriere0=Inchiriere(23,23)
        lista=repo_inchiriere.get_all()
        try:
            repo_client.store(inchiriere0)
            assert(False)
        except RepoException as re:
            assert(str(re)=="element existent!\n")
        key_carte=45
        try:
            repo_inchiriere.returnare(key_carte)
            assert(False)
        except RepoException as re:
            assert(str(re)=="Cartea nu a fost inchiriata!\n")
        inchiriere=Inchiriere(14,18)
        key_carte=10
        try:
            repo_inchiriere.cauta_inchiriere(key_carte)
            assert(False)
        except RepoException as re:
            assert(str(re)=="Cartea nu a fost inchiriata!\n")
        repo_inchiriere.remove_by_ID_client(23)
        assert(len(lista)==1)
            
         
    
    
    def __run_service_inchiriere_tests(self):
        repo_carte=RepositoryCarte()
        repo_client=RepositoryClient()
        valid_carte=ValidatorCarte()
        valid_client=ValidatorClient()
        service_client=ServiceClient(repo_client,valid_client)
        service_carte=ServiceCarte(repo_carte,valid_carte)
        repo_inchiriere=RepositoryInchiriere()
        valid_inchiriere=ValidatorInchiriere()
        service_inchiriere=ServiceInchiriere(service_client,service_carte,repo_inchiriere,valid_inchiriere)
        id_carte=23
        id_client=23
        service_carte.add_carte(id_carte,"Ion","","Liviu Rebreanu")
        service_client.add_client(id_client,"Ion","5041126784653")
        service_inchiriere.add_inchiriere(id_carte,id_client)
        assert(service_inchiriere.get_no_inchirieri()==1)
        try:
            service_inchiriere.add_inchiriere(id_carte,id_client)
            assert(False)
        except RepoException as re:
            assert(str(re)=="Cartea nu este disponibila momentan. Va rugam reveniti!\n")
        try:
            service_inchiriere.add_inchiriere(-id_carte,-id_client)
            assert(False)
        except ValidationException as ve:
            assert(str(ve)=="id client invalid!\nid carte invalid!\n")
        try:
            service_inchiriere.returnare(-19)
            assert(False)
        except RepoException as re:
            assert(str(re)=="element inexistent!\n")
        try:
            service_inchiriere.returnare(19)
            assert(False)
        except RepoException as re:
            assert(str(re)=="element inexistent!\n")
        service_carte.add_carte(1,"Ion","roman social","Liviu Rebreanu")
        service_carte.add_carte(2,"Harap-Alb","basm","Ion Creanga")
        service_carte.add_carte(3,"Iona","roman","Marin Sorescu")
        service_carte.add_carte(4,"Moara cu noroc","nuvela","Ioan Slavici")
        service_client.add_client(1,"Ion","5485149321765")
        service_client.add_client(2,"Dan","5051746289512")
        service_client.add_client(3,"Max","5102485621032")
        repo_inchiriere=RepositoryInchiriere()
        service_inchiriere.add_inchiriere(1,1)
        service_inchiriere.add_inchiriere(2,1)
        service_inchiriere.add_inchiriere(3,1)
        service_inchiriere.returnare(1)
        service_inchiriere.add_inchiriere(1,2)
        service_inchiriere.add_inchiriere(4,2)
        service_inchiriere.returnare(4)
        service_inchiriere.returnare(2)
        service_inchiriere.add_inchiriere(4,3)
        carti_inchiriate_acum=repo_inchiriere.get_all()
        for elem in carti_inchiriate_acum:
            assert(elem==1 or elem==4)
        cele_mai_inchiriate=service_inchiriere.cartile_cele_mai_inchiriate()
        for elem in cele_mai_inchiriate:
            assert(elem==1 or elem==4 or elem==2)
        try:
            service_inchiriere.active_clients_20()
            assert(False)
        except ServiceException as se:
            assert(str(se)=="Trebuie sa existe cel putin 5 clienti cu carti inchiriate!")


    def run_all_inchiriere_tests(self):
        self.__run_domain_tests()
        self.__run_validation_tests()
        self.__run_repository_inchiriere_tests()
        self.__run_service_inchiriere_tests()
    