#!/bin/bash
# Solicita al usuario que introduzca un número y lo guarda en la variable N
read -p "Introduce un número (mayor que 0 pero tampoco muy alto por favor) > " N

# Inicializa la variable fakeN en 1 para usarla como contador
fakeN=1

# Se verifica si N es mayor que 0 usando la variable con $ y corchetes dobles para evaluar la expresión
if [[ $N -gt 0 ]]; then
  # Imprime el primer número antes del bucle
  echo "1"

  # Mientras fakeN sea diferente a N y N mayor que 0, ejecuta el bucle
  while [[ $fakeN -ne $N && $N -gt 0 ]]; do
    # Incrementa el contador fakeN en 1
    fakeN=$((fakeN+1))
    # Imprime el valor actual de fakeN
    echo "$fakeN"
  done
else
  echo "Que sea mayor que 0 la próxima vez por favor."
 exit 1
fi

# Indica que el contador ha finalizado mostrando cuántos números se imprimieron
echo "Contador finalizado. Se han mostrado $N números"
