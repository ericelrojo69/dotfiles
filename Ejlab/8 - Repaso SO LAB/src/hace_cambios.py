#!/usr/bin/env python3

import random
import os

CAMBIOS_MIN=1
CAMBIOS_MAX=2

def fich_borra(d, f):
    p = os.path.join(d, f)
    os.unlink(p)
    return

def fich_cambia_contenido(d, f, contenido = ';-)'):
    p = os.path.join(d, f)
    with open(p, "w") as f:
        f.write(contenido)
    return

def fich_cambia_nombre(d, f, fnuevo = 'nuevo'):
    p = os.path.join(d, f)
    pnuevo = os.path.join(d, fnuevo)
    os.rename(p, pnuevo)
    return
    
def dir_cambia_nombre(d, dnuevo):
    os.rename(d, dnuevo)
    return
    
def dir_haz_cambio(d):
    #print(d)
    f = random.choice(os.listdir(d))
    #print(f)
    cambio = random.choice(cambios)
    #print(cambio)
    cambio(d, f)
    return

cambios = [fich_borra, fich_cambia_contenido, fich_cambia_nombre, dir_cambia_nombre]    
def main():
    directorios = os.listdir()
    num_cambios = random.randrange(CAMBIOS_MIN, CAMBIOS_MAX)
    for i in range(num_cambios):
        d = random.choice(directorios)
        dir_haz_cambio(d)
    return

if __name__ == "__main__":
  main()    
   
