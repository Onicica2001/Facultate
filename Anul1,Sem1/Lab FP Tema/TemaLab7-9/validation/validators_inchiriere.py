from errors.exceptions import ValidationException
class ValidatorInchiriere(object):
    
    
    def valideaza(self,inchiriere):
        errors=""
        if inchiriere.get_id_client()<0:
            errors+="id client invalid!\n"
        if inchiriere.get_id_carte()<0:
            errors+="id carte invalid!\n"
        if len(errors)>0:
            raise ValidationException(errors)
    
    



