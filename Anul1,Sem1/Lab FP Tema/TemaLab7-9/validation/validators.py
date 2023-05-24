from errors.exceptions import ValidationException
class ValidatorCarte:
    
    
    def valideaza(self, carte):
        errors=""
        if carte.get_id_carte()<0:
            errors+="id invalid!\n"
        if carte.get_titlu()=="":
            errors+="titlu invalid\n"
        if carte.get_autor()=="":
            errors+="autor invalid"
        if len(errors)>0:
            raise ValidationException(errors)
    
    



