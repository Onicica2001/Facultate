'''
Created on Nov 8, 2020

@author: Calin
'''
from testing.tests import TestsCarte
from presentation.console import UI
from testing.tests_client import TestsClient
from infrastructure.repositories import RepositoryCarte
from validation.validators import ValidatorCarte
from infrastructure.repositories_client import RepositoryClient
from validation.validators_client import ValidatorClient
from business.services_client import ServiceClient
from business.services import ServiceCarte
from testing.tests_inchiriere import TestsInchiriere
from business.services_inchiriere import ServiceInchiriere
from infrastructure.repositories_inchiriere import RepositoryInchiriere
from validation.validators_inchiriere import ValidatorInchiriere
from infrastructure.File_repository_client import FileRepositoryClient
from infrastructure.File_repository_carte import FileRepositoryCarte
from infrastructure.File_repository_inchiriere import FileRepositoryInchiriere
from testing.Pyunit_test_carte import TesteCarte
from testing.Pyunit_test_client import TesteClient
from testing.Pyunit_test_inchiriere import TesteInchiriere
from infrastructure.FileRepository import FileRepositoryClient2

if __name__=='__main__':
    testscarte=TestsCarte()
    testscarte.run_all_carte_tests()
    testsclient=TestsClient()
    testsclient.run_all_client_tests()
    testinchiriere=TestsInchiriere()
    testinchiriere.run_all_inchiriere_tests()
    #testscarte=TesteCarte()
    #testscarte.rulare()
    #testsclient=TesteClient()
    #testsclient.rulare()
    #testsinchiriere=TesteInchiriere()
    #testsinchiriere.rulare()
    #repo_carte=RepositoryCarte()
    repo_carte=FileRepositoryCarte("Lab10_carte.txt")
    valid_carte=ValidatorCarte()
    #repo_client=RepositoryClient()
    #repo_client=FileRepositoryClient("Lab10_client.txt")
    repo_client=FileRepositoryClient2("Lab10_client.txt")
    valid_client=ValidatorClient()
    #repo_inchiriere=RepositoryInchiriere()
    repo_inchiriere=FileRepositoryInchiriere("Lab10_inchiriere.txt")
    valid_inchiriere=ValidatorInchiriere()
    service_client=ServiceClient(repo_client,valid_client)
    service_carte=ServiceCarte(repo_carte,valid_carte)
    service_inchiriere=ServiceInchiriere(service_client,service_carte,repo_inchiriere,valid_inchiriere)
    cons=UI(service_carte,service_client,service_inchiriere)
    cons.run()