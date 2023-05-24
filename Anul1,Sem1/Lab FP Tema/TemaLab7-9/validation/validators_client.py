from errors.exceptions import ValidationException
class ValidatorClient:
    
    
    def valideaza_client(self, client):
        errors=""
        try:
            int(client.get_cnp())
        except:
            raise ValidationException("cnp invalid!\n")
        if client.get_id_client()<0:
            errors+="id invalid!\n"
        if client.get_nume()=="":
            errors+="nume invalid\n"
        if len(client.get_cnp())<13  or int(client.get_cnp())<0 or len(client.get_cnp())>13 or client.get_cnp()[0]>"6" or client.get_cnp()[0]=="0" :
            errors+="cnp invalid\n"
        if len(errors)>0:
            raise ValidationException(errors)
    



