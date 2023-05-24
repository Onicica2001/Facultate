from domain.entities_client import Client
from validation.validators_client import ValidatorClient
from errors.exceptions import ValidationException,RepoException
from infrastructure.repositories_client import RepositoryClient
from business.services_client import ServiceClient
class TestsClient:
    
    
    def __run_domain_tests(self):
        id_client=23
        nume="Ion"
        cnp="5041126784653"
        client=Client(id_client,nume,cnp)
        assert(client.get_id_client()==23)
        assert(client.get_nume()=="Ion")
        assert(client.get_cnp()=="5041126784653")
        assert(str(client)=="23 Ion 5041126784653")
        client0=Client(id_client,nume,cnp)
        assert(client==client0)
        
    
    
    def __run_validation_tests(self):
        client=Client(-230,"","7983542")
        validator_client=ValidatorClient()
        try:
            validator_client.valideaza_client(client)
            assert(False)
        except ValidationException as ve:
            assert(str(ve)=="id invalid!\nnume invalid\ncnp invalid\n")
        client_valid=Client(20,"Mara","6020603908721")
        validator_client.valideaza_client(client_valid)
        assert(True)
    
    
    def __run_repository_client_tests(self):
        client=Client(23,"Ion","5041126784653")
        repo_client=RepositoryClient()
        assert(len(repo_client)==0)
        repo_client.store(client)
        assert(len(repo_client)==1)
        key_client=Client(23,None,None)
        result_client=repo_client.search_id(key_client)
        assert(client.get_nume()==result_client.get_nume())
        assert(client.get_cnp()==result_client.get_cnp())
        client0=Client(23,None,None)
        try:
            repo_client.store(client0)
            assert(False)
        except RepoException as re:
            assert(str(re)=="element existent!\n")
        client1=Client(20,"Mara","6020603908721")
        try:
            repo_client.update(client1)
            assert(False)
        except RepoException as re:
            assert(str(re)=="element inexistent!\n")
        client2=Client(23,"Daniel","5121212097856")
        repo_client.update(client2)
        result_client=repo_client.search_id(key_client)
        assert("Daniel"==result_client.get_nume())
        assert("5121212097856"==result_client.get_cnp())
        repo_client.remove(key_client)
        assert(len(repo_client)==0)
        try:
            repo_client.remove(key_client)
            assert(False)
        except RepoException as re:
            assert(str(re)=="element inexistent!\n")
        client=Client(23,"Ion","5041126784653")
        repo_client=RepositoryClient()
        repo_client.store(client)
        nume_client="Ion"
        result_client=repo_client.search_nume(nume_client)
        for i in range(len(result_client)):
            assert client.get_client()==result_client[i]
        cnp_client="5041126784653"
        result_client=repo_client.search_cnp(cnp_client)
        for i in range(len(result_client)):
            assert client.get_client()==result_client[i]
        
    
    
    def __run_service_client_tests(self):
        repo_client=RepositoryClient()
        valid_client=ValidatorClient()
        service_client=ServiceClient(repo_client,valid_client)
        id_client=23
        nume="Ion"
        cnp="5041126784653"
        service_client.add_client(id_client,nume,cnp)
        assert(service_client.get_no_client()==1)
        try:
            service_client.add_client(id_client,nume,cnp)
            assert(False)
        except RepoException as re:
            assert(str(re)=="element existent!\n")
        try:
            service_client.add_client(-id_client,"","7352")
            assert(False)
        except ValidationException as ve:
            assert(str(ve)=="id invalid!\nnume invalid\ncnp invalid\n")
        
    
    
    def run_all_client_tests(self):
        self.__run_domain_tests()
        self.__run_validation_tests()
        self.__run_repository_client_tests()
        self.__run_service_client_tests()
    
    



