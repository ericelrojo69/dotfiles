#!/usr/bin/env python3

import random
import hashlib

def main():
    directorios = [ 'sistema-operativo', 'Linux', 'administracion', 'virtualizacion', 'hardware', 'usuario', 'grupo', 'proceso', 'hilo', 'thread', 'buffer', 'fichero', 'directorio', 'link', 'disco', 'particion', 'volumen-logico', 'ordenador', 'CPU', 'core', 'memoria', 'RAM', 'cache', 'bus-de-ES', 'controladora', 'SSD', 'NVM', 'RAID', 'LVM', 'SCSI', 'SATA', 'USB', 'maquina-virtual', 'contenedor', 'big-data' ]
    
    separador = ','
    numdir=25
    numfich=100
    
    print(separador.join(['directorio', 'fichero', 'contenido-del-fichero']))
    for d in random.sample(directorios, k=numdir):
        for i in random.sample(range(1000), k=numfich):
            f = 'f%(n)04d' % {"n":i}
            datos = hashlib.sha256(bytes(d + '/'+ f, 'utf-8')).hexdigest()
            print(separador.join([d, f, datos]))

if __name__ == "__main__":
  main()    
   
