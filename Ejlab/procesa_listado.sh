#!/bin/bash

# Leer la entrada estándar
# Usamos IFS como variable de entorno para separar los parametros de entrada por el coma
while IFS=',' read -r directorio fichero contenido; do
  # Ignorar el encabezado
  if [[ "$directorio" == "directorio" ]]; then
    continue
  fi

  # Crear el directorio si no existe
  if [[ ! -d "$directorio" ]]; then
    mkdir "$directorio"
  fi

  # Crear el archivo dentro del directorio
  echo -n "$contenido" > "$directorio/$fichero"
done

