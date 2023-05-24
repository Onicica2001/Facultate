'''
Created on Dec 1, 2020

@author: Calin
'''
def clearFileContent(fileName):
    """
      Clear the content of the file
      Post: the given file exist and is empty
    """
    f = open(fileName, "w")
    f.close()