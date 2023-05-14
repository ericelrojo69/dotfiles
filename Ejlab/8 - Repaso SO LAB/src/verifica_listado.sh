#!/bin/bash

SEPARADOR=","
NUM_DIRECTORIOS=25
NUM_FICHEROS=100
NUM_FICHEROS_TOTAL=$((NUM_DIRECTORIOS*NUM_FICHEROS))

error()
{
    echo "ERROR: $*"
    echo ":-("
    exit 1
}

nd=$(find * -type d | wc -l)
[[ $nd = $NUM_DIRECTORIOS ]] || error "Número incorrecto de directorios: $nd (debería ser $NUM_DIRECTORIOS)"
nf=$(find * -type f | wc -l)
[[ $nf = $NUM_FICHEROS_TOTAL ]] || error "Número incorrecto de ficheros: $nf (debería ser $NUM_FICHEROS_TOTAL)"

n=0
read encabezado
while IFS="$SEPARADOR" read d f c
do
    [[ -d "$d" ]] || error "No existe el directorio: $d"
    fich="$d/$f"
    [[ -f "$fich" ]] || error "No existe el fichero: $fich"
    [[ -r "$fich" ]] || error "No se puede leer el fichero: $fich"
    cksum1=$(IFS=' ' sha256sum $fich | cut -d' ' -f 1)
    cksum2=$(echo -n $c | sha256sum | cut -d' ' -f 1)
    [[ "$cksum1" = "$cksum2" ]] || error "Contenido inválido en el fichero: $fich"
    n=$((++n))
done
[[ $n = $NUM_FICHEROS_TOTAL ]] || error "Número incorrecto de elementos procesados: $n (debería ser $NUM_FICHEROS_TOTAL)"

echo "Comprobación correcta de $n ficheros :-)"
exit 0
