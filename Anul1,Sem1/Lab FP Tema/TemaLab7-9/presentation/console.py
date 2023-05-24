from errors.exceptions import ValidationException, RepoException,\
    ServiceException
class UI:

    
    def __ui_add_carte(self):
        id_carte=int(input("Introduceti id carte: "))
        titlu=input("Introduceti titlul cartii: ")
        descriere=input("Introduceti o scurta descriere a cartii: ")
        autor=input("Introduceti autorul cartii: ")
        self.__service_carte.add_carte(id_carte,titlu,descriere,autor)
    
    
    def __ui_print_carte(self):
        carti= self.__service_carte.get_carti()
        if len(carti)==0:
            print("Nu exista carti!")
            return
        for carte in carti:
            print(carte)
    
    
    def __ui_add_client(self):
        id_client=int(input("Introduceti id client: "))
        nume=input("Introduceti numele clientului: ")
        cnp=input("Introduceti CNP-ul clientului: ")
        self.__service_client.add_client(id_client,nume,cnp)
    
    
    def __ui_print_client(self):
        clienti= self.__service_client.get_clienti()
        if len(clienti)==0:
            print("Nu exista clienti!")
            return
        for client in clienti:
            print(client)
    
    
    
    def __ui_actualizare_client(self):
        id_client=int(input("Introduceti id pentru clientul caruia ii actualizati datele: "))
        nume=input("Introduceti numele clientului: ")
        cnp=input("Introduceti CNP-ul clientului: ")
        self.__service_client.update_clienti(id_client,nume,cnp)
    
    
    def __ui_actualizare_carte(self):
        id_carte=int(input("Introduceti id pentru cartea careia ii actualizati datele: "))
        titlu=input("Introduceti titlul cartii: ")
        descriere=input("Introduceti o scurta descriere a cartii: ")
        autor=input("Introduceti autorul cartii: ")
        self.__service_carte.update_carte(id_carte,titlu,descriere,autor)
    
    
    def __ui_sterge_carte(self):
        id_carte=int(input("Introduceti id pentru cartea pe care doriti sa o stergeti: "))
        try:
            self.__service_inchiriere.cauta_inchiriere_carte(id_carte)
            self.__service_inchiriere.remove_by_ID_carte(id_carte)
        finally:
            self.__service_inchiriere.sterge_numar_inchirieri_carte(id_carte)
            self.__service_carte.remove_carte(id_carte)
    
    
    def __ui_sterge_client(self):
        id_client=int(input("Introduceti id pentru clientul pe care doriti sa il stergeti: "))
        try:
            self.__service_inchiriere.cauta_inchiriere_client(id_client)
            self.__service_inchiriere.remove_by_ID_client(id_client)
        finally:
            self.__service_inchiriere.sterge_numar_inchirieri_client(id_client)
            self.__service_client.remove_client(id_client)
    
    
    def __ui_cauta_carte_id(self):
        id_carte=int(input("Introduceti id pentru cartea pe care o cautati: "))
        print(self.__service_carte.search_id(id_carte))
    
    
    def __ui_cauta_client_id(self):
        id_client=int(input("Introduceti id pentru clientul pe care il cautati: "))
        print(self.__service_client.search_id(id_client))
    
    
    def __ui_cauta_carte_titlu(self):
        titlu_carte=input("Introduceti titlul sau fragmente din titlul cartii pe care o cautati:")
        print(self.__service_carte.search_titlu(titlu_carte))
    
    
    def __ui_cauta_carte_autor(self):
        autor_carte=input("Introduceti autorul sau o parte din numele autorului cartii pe care o cautati: ")
        print(self.__service_carte.search_autor(autor_carte))
    
    
    def __ui_cauta_client_nume(self):
        nume_client=input("Introduceti numele sau o parte din numele clientului pe care il cautati: ")
        print(self.__service_client.search_nume(nume_client))
    
    
    def __ui_cauta_client_cnp(self):
        cnp_client=input("Introduceti CNP-ul sau o parte a CNP-ului clientului pe care il cautati: ")
        print(self.__service_client.search_cnp(cnp_client))
    
    
    def __ui_genereaza_carte(self):
        nr_carti=int(input("Introduceti numarul de carti pe care doriti sa le generati: "))
        self.__service_carte.generate_carti(nr_carti)
    
    
    def __ui_genereaza_client(self):
        nr_clienti=int(input("Introduceti numarul de clienti pe care doriti sa ii generati: "))
        self.__service_client.generate_client(nr_clienti)
    
    
    def __ui_inchiriaza_carte(self):
        self.__service_inchiriere.check_client()
        self.__service_inchiriere.check_carti()
        print("\nCine vrea sa inchirieze o carte?\n")
        self.__ui_print_client()
        id_client=int(input("ID client: "))
        print("\nCe carte doriti sa inchiriati?\n")
        self.__ui_print_carte()
        id_carte=int(input("ID carte: "))
        self.__service_inchiriere.add_inchiriere(id_carte,id_client)
    
    
    def __ui_returneaza_carte(self):
        self.__service_inchiriere.check_inchiriere_carte()
        self.__ui_print_carti_inchiriate()
        self.__service_inchiriere.check_client()
        self.__service_inchiriere.check_carti()
        print("\nCe carte doriti sa returnati?\n")
        id_carte=int(input("ID carte: "))
        self.__service_inchiriere.returnare(id_carte)

    def __ui_print_carti_inchiriate(self):
        carti_inchiriate=self.__service_inchiriere.get_list()
        if len(carti_inchiriate)==0:
            return
        else:
            for carte in carti_inchiriate:
                print(carte)
    
    
    
    def __ui_cele_mai_inchiriate_carti(self):
        carti= self.__service_inchiriere.cartile_cele_mai_inchiriate()
        for carte in carti:
            print(carte)
    
    
    def __ui_clienti_cu_inchirieri_sortati_dupa_nume(self):
        clients=self.__service_inchiriere.sorteaza_client_nume()
        for client in clients:
            print(client)
    
    
    def __ui_clienti_cu_inchirieri_sortati_dupa_nr_inchirieri(self):
        clients=self.__service_inchiriere.sorteaza_client_dupa_inchirieri()
        for client in clients:
            print(client)

    
    def __ui_cei_mai_activi_clienti(self):
        clients=self.__service_inchiriere.active_clients_20()
        for client in clients:
            print(client)
    
    
    def __ui_autori_carti_inchiriate_dupa_inchirieri(self):
        autori=self.__service_inchiriere.autori_carti_inchiriate_dupa_inchirieri()
        print(autori)
    
    
    def __init__(self,service_carte,service_client,service_inchiriere):
        self.__service_carte = service_carte
        self.__service_client=service_client
        self.__service_inchiriere=service_inchiriere
        self.__comenzi={
            "Adauga carte":self.__ui_add_carte,
            "Adauga client":self.__ui_add_client,
            "Print carte":self.__ui_print_carte,
            "Print client":self.__ui_print_client,
            "Actualizeaza carte":self.__ui_actualizare_carte,
            "Actualizeaza client":self.__ui_actualizare_client,
            "Sterge carte":self.__ui_sterge_carte,
            "Sterge client":self.__ui_sterge_client,
            "Cauta carte id":self.__ui_cauta_carte_id,
            "Cauta client id":self.__ui_cauta_client_id,
            "Cauta carte titlu":self.__ui_cauta_carte_titlu,
            "Cauta carte autor":self.__ui_cauta_carte_autor,
            "Cauta client nume":self.__ui_cauta_client_nume,
            "Cauta client cnp":self.__ui_cauta_client_cnp,
            "Genereaza carte":self.__ui_genereaza_carte,
            "Genereaza client":self.__ui_genereaza_client,
            "Inchiriaza carte":self.__ui_inchiriaza_carte,
            "Returneaza carte":self.__ui_returneaza_carte,
            "Print carti inchiriate":self.__ui_print_carti_inchiriate,
            "Cele mai inchiriate carti":self.__ui_cele_mai_inchiriate_carti,
            "Clienti cu inchirieri dupa nume":self.__ui_clienti_cu_inchirieri_sortati_dupa_nume,
            "Clienti cu inchirieri dupa inchirieri":self.__ui_clienti_cu_inchirieri_sortati_dupa_nr_inchirieri,
            "20% cei mai activi clienti":self.__ui_cei_mai_activi_clienti,
            "Autori cu carti inchiriate dupa inchirieri":self.__ui_autori_carti_inchiriate_dupa_inchirieri
            }
    
    
    
    
    def run(self):
        while True:
            cmd=input("\nIntroduceti comanda pe care doriti sa o efectuati:\nComenzile disponibile sunt:\nAdauga carte\nAdauga client\nPrint carte\nPrint client\nActualizeaza carte\nActualizeaza client\nSterge carte\nSterge client\nCauta carte id\nCauta carte titlu\nCauta carte autor\nCauta client id\nCauta client nume\nCauta client cnp\nGenereaza carte\nGenereaza client\nInchiriaza carte\nReturneaza carte\nPrint carti inchiriate\nCele mai inchiriate carti\nClienti cu inchirieri dupa nume\nClienti cu inchirieri dupa inchirieri\n20% cei mai activi clienti\nAutori cu carti inchiriate dupa inchirieri\nExit\n")
            if cmd=="Exit":
                print("La revedere!")
                return
            if cmd in self.__comenzi:
                try:
                    self.__comenzi[cmd]()
                    print("Comanda efectuata!\n")
                except ValueError:
                    print("Valoare numerica invalida!")
                except ValidationException as ve:
                    print(ve)
                except RepoException as re:
                    print(re)
                except ServiceException as se:
                    print(se)
            else:
                print("Comanda invalida!")
    
    



