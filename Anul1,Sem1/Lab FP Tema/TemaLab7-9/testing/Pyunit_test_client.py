import unittest
from domain.entities_client import Client
from validation.validators_client import ValidatorClient
from errors.exceptions import ValidationException, RepoException
from infrastructure.repositories_client import RepositoryClient
from business.services_client import ServiceClient
from infrastructure.File_repository_client import FileRepositoryClient
from testing.testutils import clearFileContent
class TestDomainClient(unittest.TestCase):
    def setUp(self):
        id_client=1
        nume="Ion"
        cnp="5647362514231"
        self.client=Client(id_client,nume,cnp)
        
    def tearDown(self):
        unittest.TestCase.tearDown(self)  
        
    def testCreare(self):
        self.assertTrue(self.client.get_id_client() == 1)
        self.assertEqual(self.client.get_id_client(), 1)
        self.assertEqual(self.client.get_nume(), "Ion")
        self.assertEqual(self.client.get_cnp(), "5647362514231")
        self.assertEqual(str(self.client), "1 Ion 5647362514231")
        
    def test_client_egal(self):

        client1=Client(1, "Bob", "5647362514232")
        self.assertEqual(client1, self.client)

        client2=Client(2, "Bob", "5647362514232")
        self.assertNotEqual(client1, client2)
        
    def test_validare(self):

        valid=ValidatorClient()

        client_gresit=Client(-1, "", "")
        try:
            valid.valideaza_client(client_gresit)
            assert (False)
        except ValidationException as ve:
            self.assertEqual(str(ve), "cnp invalid!\n")
            
        client_gresit2=Client(-1, "", "34")
        try:
            valid.valideaza_client(client_gresit2)
            assert (False)
        except ValidationException as ve:
            self.assertEqual(str(ve), "id invalid!\nnume invalid\ncnp invalid\n")

        client_gresit3 = Client(1, "Ion", "7436")
        try:
            valid.valideaza_client(client_gresit3)
            assert (False)
        except ValidationException as ve:
            self.assertEqual(str(ve), "cnp invalid\n")
    
    
class TestRepositoryClient(unittest.TestCase):
    def setUp(self):
        self.repo=RepositoryClient()
        #self.repo=FileRepositoryClient("Test_client.txt")
        client=Client(1,"Ion","5041126784653")
        self.repo.store(client)
    
    def tearDown(self):
        unittest.TestCase.tearDown(self)
        clearFileContent("Test_client.txt")
     
    def test_adaugare(self):
        self.assertEqual(len(self.repo), 1)
        gasit=self.repo.search_id(1)
        self.assertEqual(gasit.get_nume(), "Ion")
        self.assertEqual(gasit.get_id_client(), 1)
        self.assertEqual(gasit.get_cnp(), "5041126784653")
        client=Client(1,"Bob","5041126784623")
        try:
            self.repo.store(client)
            assert (False)
        except RepoException as re:
            self.assertEqual(str(re), "element existent!\n")
            
    def test_cautare(self):
        result_client=self.repo.search_id(1)
        self.assertEqual(result_client.get_nume(), "Ion")
        self.assertEqual(result_client.get_id_client(), 1)
        self.assertEqual(result_client.get_cnp(), "5041126784653") 
        try:
            self.repo.search_id(3)   
            assert (False)
        except RepoException as re:
            self.assertEqual(str(re), "element inexistent!\n")    
        
    def test_update(self):
        client_nou=Client(1,"Dan","5043246784653")
        self.repo.update(client_nou)
        gasit = self.repo.search_id(1)
        self.assertEqual(gasit.get_nume(), "Dan")
        self.assertEqual(gasit.get_id_client(), 1)
        self.assertEqual(gasit.get_cnp(), "5043246784653")    
        client_nou_gresit = Client(3, "Max", "5635241324132")
        try:
            self.repo.update(client_nou_gresit)
            assert (False)
        except RepoException as re:
            self.assertEqual(str(re), "element inexistent!\n") 
            
    def test_get_all(self):
        lista = self.repo.get_all()
        self.assertEqual(len(lista), 1)
        self.assertEqual(lista[0].get_nume(), "Ion")
        self.assertEqual(lista[0].get_id_client(), 1)
        self.assertEqual(lista[0].get_cnp(), "5041126784653")

    def test_stergere(self):
        self.repo.remove(1)
        self.assertEqual(len(self.repo), 0)
        try:
            self.repo.remove(1)
            assert (False)
        except RepoException as re:
            self.assertEqual(str(re), "element inexistent!\n")
    
    
class TestServiceClient(unittest.TestCase):
    def setUp(self):
        val = ValidatorClient()
        self.service = ServiceClient(RepositoryClient(),val)
        #self.service = ServiceClient(FileRepositoryClient("Test_client.txt"),val)
        self.service.add_client(1, "Ion", "5041126784653")
     
    def tearDown(self):
        unittest.TestCase.tearDown(self)
        clearFileContent("Test_client.txt")
       
    def test_creare(self):
        self.assertTrue(len(self.service.get_clienti()) == 1)
        self.assertEqual(len(self.service.get_clienti()), 1)
        self.assertTrue(self.service.get_no_client() == 1)
        self.assertEqual(self.service.get_no_client(), 1)
        
    def test_adaugare(self):
        try:
            self.service.add_client(1,"Dan","5041126787253")
            assert(False)
        except RepoException as re:
            self.assertEqual(str(re), "element existent!\n")
        try:
            self.service.add_client(-1,"Max", "5041126787253")
            assert (False)
        except ValidationException as ve:
            self.assertEqual(str(ve), "id invalid!\n")
    
    def test_update(self):
        self.service.update_clienti(1, "Daniel", "5041126787262")
        gasit=self.service.search_id(1)
        self.assertEqual(gasit.get_nume(), "Daniel")
        self.assertEqual(gasit.get_cnp(), "5041126787262")
        
    def test_stergere(self):
        self.service.remove_client(1)
        clienti=self.service.get_clienti()
        self.assertEqual(len(clienti), 0)


class TesteClient(unittest.TestCase):
    def test_service(self):
        TestServiceClient()

    def test_domain(self):
        TestDomainClient()

    def test_repo(self):
        TestRepositoryClient()

    def rulare(self):
        unittest.main()
    
    