import unittest
from validation.validators_inchiriere import ValidatorInchiriere
from errors.exceptions import ValidationException, RepoException,\
    ServiceException
from infrastructure.repositories_inchiriere import RepositoryInchiriere
from business.services_inchiriere import ServiceInchiriere
from infrastructure.File_repository_inchiriere import FileRepositoryInchiriere
from testing.testutils import clearFileContent
from domain.entities_inchiriere import Inchiriere
from business.services_client import ServiceClient
from business.services import ServiceCarte
from infrastructure.repositories_client import RepositoryClient
from validation.validators_client import ValidatorClient
from infrastructure.repositories import RepositoryCarte
from validation.validators import ValidatorCarte
class TestDomainInchiriere(unittest.TestCase):
    def setUp(self):
        id_client=1
        id_carte=1
        self.inchiriere=Inchiriere(id_client,id_carte)
        
    def tearDown(self):
        unittest.TestCase.tearDown(self)  
        
    def testCreare(self):
        self.assertTrue(self.inchiriere.get_id_client() == 1)
        self.assertEqual(self.inchiriere.get_id_client(), 1)
        self.assertEqual(self.inchiriere.get_id_carte(), 1)
        self.assertTrue(self.inchiriere.get_id_carte() == 1)
        
    def test_inchiriere_egal(self):

        inchiriere1=Inchiriere(1,1)
        self.assertEqual(inchiriere1, self.inchiriere)

        inchiriere2=Inchiriere(2,1)
        self.assertNotEqual(inchiriere1, inchiriere2)
        
    def test_validare(self):

        valid=ValidatorInchiriere()

        inchiriere_gresita=Inchiriere(-1, 1)
        try:
            valid.valideaza(inchiriere_gresita)
            assert (False)
        except ValidationException as ve:
            self.assertEqual(str(ve), "id carte invalid!\n")
            
        inchiriere_gresita2=Inchiriere(1,-1)
        try:
            valid.valideaza(inchiriere_gresita2)
            assert (False)
        except ValidationException as ve:
            self.assertEqual(str(ve), "id client invalid!\n")

        inchiriere_gresita3 = Inchiriere(-1, -1)
        try:
            valid.valideaza(inchiriere_gresita3)
            assert (False)
        except ValidationException as ve:
            self.assertEqual(str(ve), "id client invalid!\nid carte invalid!\n")
    
    
class TestRepositoryInchiriere(unittest.TestCase):
    def setUp(self):
        #self.repo=RepositoryInchiriere()
        self.repo=FileRepositoryInchiriere("Test_inchiriere.txt")
        inchiriere=Inchiriere(1,1)
        self.repo.store(inchiriere)
    
    def tearDown(self):
        unittest.TestCase.tearDown(self)
        clearFileContent("Test_inchiriere.txt")
     
    def test_adaugare(self):
        self.assertEqual(len(self.repo), 1)
        gasit=self.repo.cauta_inchiriere(1)
        self.assertEqual(gasit.get_id_carte(), 1)
        self.assertEqual(gasit.get_id_client(), 1)
        inchiriere=Inchiriere(1,2)
        try:
            self.repo.store(inchiriere)
            assert (False)
        except RepoException as re:
            self.assertEqual(str(re), "Cartea nu este disponibila momentan. Va rugam reveniti!\n")
            
    def test_cautare(self):
        result_inchiriere=self.repo.cauta_inchiriere(1)
        self.assertEqual(result_inchiriere.get_id_carte(), 1)
        self.assertEqual(result_inchiriere.get_id_client(), 1)
        result_inchiriere=self.repo.cauta_inchiriere_client(1)
        self.assertEqual(result_inchiriere.get_id_carte(), 1)
        self.assertEqual(result_inchiriere.get_id_client(), 1)
        try:
            self.repo.cauta_inchiriere(3)
            assert (False)
        except RepoException as re:
            self.assertEqual(str(re), "Cartea nu a fost inchiriata!\n")  
        try:
            self.repo.cauta_inchiriere_client(3)
            assert (False)
        except RepoException as re:
            self.assertEqual(str(re), "Clientul nu a inchiriat nicio carte\n")    
            
    def test_get_all(self):
        lista = self.repo.get_all()
        self.assertEqual(len(lista), 1)
        self.assertEqual(lista[0].get_id_carte(), 1)
        self.assertEqual(lista[0].get_id_client(), 1)

    def test_stergere(self):
        self.repo.remove_by_ID_carte(1)
        self.assertEqual(len(self.repo), 0)
        self.assertEqual(self.repo.remove_by_ID_carte(1), None)
        self.assertEqual(self.repo.remove_by_ID_client(1), None)
    
    
class TestServiceInchiriere(unittest.TestCase):
    def setUp(self):
        val = ValidatorInchiriere()
        self.service_client=ServiceClient(RepositoryClient(),ValidatorClient())
        self.service_carte=ServiceCarte(RepositoryCarte(),ValidatorCarte())
        self.service = ServiceInchiriere(self.service_client,self.service_carte,RepositoryInchiriere(),val)
        #self.service = ServiceInchiriere(self.service_client,self.service_carte,FileRepositoryInchiriere("Test_inchiriere.txt"),val)
        self.service_client.add_client(1, "Ion", "5041126784653")
        self.service_client.add_client(2, "Dan", "5041126784873")
        self.service_client.add_client(3, "Nicolae", "5041126784963")
        self.service_client.add_client(4, "Marian", "5041126784753")
        self.service_client.add_client(5, "Stefan", "5041126784343")
        self.service_carte.add_carte(1, "Ion", "roman", "Liviu Rebreanu")
        self.service_carte.add_carte(2, "Mara", "roman", "Ioan Slavici")
        self.service_carte.add_carte(3, "Moara cu noroc", "nuvela", "Ioan Slavici")
        self.service_carte.add_carte(4, "Enigma Otiliei", "roman", "George Calinescu")
        self.service_carte.add_carte(5, "Povestea lui Harap-Alb", "nuvela", "Ion Creanga")
        self.service.add_inchiriere(1, 1)
     
    def tearDown(self):
        unittest.TestCase.tearDown(self)
        clearFileContent("Test_inchiriere.txt")
       
    def test_creare(self):
        self.assertTrue(len(self.service.get_list()) == 1)
        self.assertEqual(len(self.service.get_list()), 1)
        self.assertTrue(self.service.get_no_inchirieri() == 1)
        self.assertEqual(self.service.get_no_inchirieri(), 1)
        
    def test_adaugare(self):
        try:
            self.service.add_inchiriere(1, 2)
            assert(False)
        except RepoException as re:
            self.assertEqual(str(re), "Cartea nu este disponibila momentan. Va rugam reveniti!\n")
        try:
            self.service.add_inchiriere(-1, 2)
            assert (False)
        except ValidationException as ve:
            self.assertEqual(str(ve), "id carte invalid!\n")
        try:
            self.service.add_inchiriere(2, -2)
            assert (False)
        except ValidationException as ve:
            self.assertEqual(str(ve), "id client invalid!\n")
            
    def test_cele_mai_inchiriate_carti(self):
        self.assertEqual(len(self.service.cartile_cele_mai_inchiriate()), 1)
        self.assertEqual(self.service.cartile_cele_mai_inchiriate(), { 1:1})
        self.service.remove_by_ID_carte(1)
        try:
            self.service.cartile_cele_mai_inchiriate()
            assert (False)
        except ServiceException as se:
            self.assertEqual(str(se), "Nu exista carti inchiriate!")
        
    def test_sorteaza(self):
        self.service.add_inchiriere(2, 1)
        self.service.add_inchiriere(3, 2)
        self.service.add_inchiriere(4, 1)
        self.assertEqual(self.service.sorteaza_client_dupa_inchirieri(), [["Ion",3],["Dan",1]])
        self.assertEqual(self.service.sorteaza_client_nume(),['2 Dan 5041126784873','1 Ion 5041126784653'])
        self.assertEqual(self.service.autori_carti_inchiriate_dupa_inchirieri(),[["Ioan Slavici",2],["Liviu Rebreanu",1],["George Calinescu",1]])
        
    def test_stergere(self):
        self.service.remove_by_ID_client(1)
        inchirieri=self.service.get_list()
        self.assertEqual(len(inchirieri), 0)
        self.service.add_inchiriere(1, 1)
        self.service.remove_by_ID_carte(1)
        inchirieri=self.service.get_list()
        self.assertEqual(len(inchirieri), 0)
        
    def test_returnare(self):
        self.assertEqual(len(self.service.get_list()), 1)
        self.service.returnare(1)
        self.assertEqual(len(self.service.get_list()), 0)
        try:
            self.service.returnare(1)
            assert(False)
        except RepoException as re:
            self.assertEqual(str(re),"Cartea nu a fost inchiriata!\n")
            
    def test_clienti_activi(self):
        try:
            self.service.active_clients_20()
            assert(False)
        except ServiceException as se:
            self.assertEqual(str(se),"Trebuie sa existe cel putin 5 clienti cu carti inchiriate!")
        self.service.add_inchiriere(2, 2)
        self.service.add_inchiriere(3, 3)
        self.service.add_inchiriere(4, 4)
        self.service.add_inchiriere(5, 5)
        self.assertEqual(self.service.active_clients_20(), [["Ion",1]])
        self.service.returnare(1)
        self.service.add_inchiriere(1, 2)
        self.assertEqual(self.service.active_clients_20(), [["Dan",2]])


class TesteInchiriere(unittest.TestCase):
    def test_service(self):
        TestServiceInchiriere()

    def test_domain(self):
        TestDomainInchiriere()

    def test_repo(self):
        TestRepositoryInchiriere()

    def rulare(self):
        unittest.main()
    
    