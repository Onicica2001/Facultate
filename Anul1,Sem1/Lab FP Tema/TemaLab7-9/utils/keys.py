from domain.entities_client import Client    

def key_sortare_nume(client):
    return client.get_nume()

def key_sortare_inchirieri(client):
    return client[1]

def key_sortare_nume_inchirieri(client):
    return client[0]