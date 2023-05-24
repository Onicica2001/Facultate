import unittest
from domain.entities import Carte
from validation.validators import ValidatorCarte
from errors.exceptions import ValidationException, RepoException
from infrastructure.repositories import RepositoryCarte
from business.services import ServiceCarte
from infrastructure.File_repository_carte import FileRepositoryCarte
from testing.testutils import clearFileContent
class TestDomainCarte(unittest.TestCase):
    def setUp(self):
        id_carte=1
        titlu="Ion"
        descriere="roman"
        autor="Liviu Rebreanu"
        self.carte=Carte(id_carte,titlu,descriere,autor)
        
    def tearDown(self):
        unittest.TestCase.tearDown(self)  
        
    def testCreare(self):
        self.assertTrue(self.carte.get_id_carte() == 1)
        self.assertEqual(self.carte.get_id_carte(), 1)
        self.assertEqual(self.carte.get_titlu(), "Ion")
        self.assertEqual(self.carte.get_descriere(), "roman")
        self.assertEqual(self.carte.get_autor(), "Liviu Rebreanu")
        self.assertEqual(str(self.carte), "1 Ion roman Liviu Rebreanu")
        
    def test_client_egal(self):

        carte1=Carte(1, "Mara", "roman","Ioan Slavici")
        self.assertEqual(carte1, self.carte)

        carte2=Carte(2, "Moara", "nuvela","Ioan Slavici")
        self.assertNotEqual(carte1, carte2)
        
    def test_validare(self):

        valid=ValidatorCarte()

        carte_gresita=Carte(-1, "", "desc","autor")
        try:
            valid.valideaza(carte_gresita)
            assert (False)
        except ValidationException as ve:
            self.assertEqual(str(ve), "id invalid!\ntitlu invalid\n")
            
        carte_gresita2=Carte(-1, "", "","")
        try:
            valid.valideaza(carte_gresita2)
            assert (False)
        except ValidationException as ve:
            self.assertEqual(str(ve), "id invalid!\ntitlu invalid\nautor invalid")

        carte_gresita3 = Carte(1, "Ion", "roman","")
        try:
            valid.valideaza(carte_gresita3)
            assert (False)
        except ValidationException as ve:
            self.assertEqual(str(ve), "autor invalid")
    
    
class TestRepositoryCarte(unittest.TestCase):
    def setUp(self):
        self.repo=RepositoryCarte()
        #self.repo=FileRepositoryCarte("Test_carte.txt")
        carte=Carte(1,"Ion","roman","Liviu Rebreanu")
        self.repo.store(carte)
    
    def tearDown(self):
        unittest.TestCase.tearDown(self)
        clearFileContent("Test_carte.txt")
     
    def test_adaugare(self):
        self.assertEqual(len(self.repo), 1)
        gasit=self.repo.search_id(1)
        self.assertEqual(gasit.get_titlu(), "Ion")
        self.assertEqual(gasit.get_descriere(), "roman")
        self.assertEqual(gasit.get_id_carte(), 1)
        self.assertEqual(gasit.get_autor(), "Liviu Rebreanu")
        carte=Carte(1,"Mara","roman","Ioan Slavici")
        try:
            self.repo.store(carte)
            assert (False)
        except RepoException as re:
            self.assertEqual(str(re), "element existent!\n")
            
    def test_cautare(self):
        result_carte=self.repo.search_id(1)
        self.assertEqual(result_carte.get_titlu(), "Ion")
        self.assertEqual(result_carte.get_id_carte(), 1)
        self.assertEqual(result_carte.get_descriere(), "roman") 
        self.assertEqual(result_carte.get_autor(), "Liviu Rebreanu")
        try:
            self.repo.search_id(3)   
            assert (False)
        except RepoException as re:
            self.assertEqual(str(re), "element inexistent!\n")    
        
    def test_update(self):
        carte_noua=Carte(1,"Mara","roman","Ioan Slavici")
        self.repo.update(carte_noua)
        gasit = self.repo.search_id(1)
        self.assertEqual(gasit.get_titlu(), "Mara")
        self.assertEqual(gasit.get_id_carte(), 1)
        self.assertEqual(gasit.get_descriere(), "roman") 
        self.assertEqual(gasit.get_autor(), "Ioan Slavici")    
        carte_noua_gresita = Carte(3, "Moara cu noroc", "nuvela","Ioan Slavici")
        try:
            self.repo.update(carte_noua_gresita)
            assert (False)
        except RepoException as re:
            self.assertEqual(str(re), "element inexistent!\n") 
            
    def test_get_all(self):
        lista = self.repo.get_all()
        self.assertEqual(len(lista), 1)
        self.assertEqual(lista[0].get_titlu(), "Ion")
        self.assertEqual(lista[0].get_id_carte(), 1)
        self.assertEqual(lista[0].get_descriere(), "roman")
        self.assertEqual(lista[0].get_autor(), "Liviu Rebreanu")

    def test_stergere(self):
        self.repo.remove(1)
        self.assertEqual(len(self.repo), 0)
        try:
            self.repo.remove(1)
            assert (False)
        except RepoException as re:
            self.assertEqual(str(re), "element inexistent!\n")
    
    
class TestServiceCarte(unittest.TestCase):
    def setUp(self):
        val = ValidatorCarte()
        self.service = ServiceCarte(RepositoryCarte(),val)
        #self.service = ServiceCarte(FileRepositoryCarte("Test_carte.txt"),val)
        self.service.add_carte(1, "Ion", "roman", "Liviu Rebreanu")
     
    def tearDown(self):
        unittest.TestCase.tearDown(self)
        clearFileContent("Test_carte.txt")
       
    def test_creare(self):
        self.assertTrue(len(self.service.get_carti()) == 1)
        self.assertEqual(len(self.service.get_carti()), 1)
        self.assertTrue(self.service.get_no_carte() == 1)
        self.assertEqual(self.service.get_no_carte(), 1)
        
    def test_adaugare(self):
        try:
            self.service.add_carte(1,"Mara","roman","Ioan Slavici")
            assert(False)
        except RepoException as re:
            self.assertEqual(str(re), "element existent!\n")
        try:
            self.service.add_carte(-1,"Moara cu noroc", "nuvela","Ioan Slavici")
            assert (False)
        except ValidationException as ve:
            self.assertEqual(str(ve), "id invalid!\n")
    
    def test_update(self):
        self.service.update_carte(1, "Moara cu noroc", "nuvela", "Ioan Slavici")
        gasit=self.service.search_id(1)
        self.assertEqual(gasit.get_titlu(), "Moara cu noroc")
        self.assertEqual(gasit.get_descriere(), "nuvela")
        self.assertEqual(gasit.get_autor(), "Ioan Slavici")
        
    def test_stergere(self):
        self.service.remove_carte(1)
        carti=self.service.get_carti()
        self.assertEqual(len(carti), 0)


class TesteCarte(unittest.TestCase):
    def test_service(self):
        TestServiceCarte()

    def test_domain(self):
        TestDomainCarte()

    def test_repo(self):
        TestRepositoryCarte()

    def rulare(self):
        unittest.main()
    
    