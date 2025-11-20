#!/bin/bash

# Pedimos al usuario que introduzca su nota
read -p "Introduce tu nota (de 0 a 10) > " nota

# Validar que la nota sea un número entero en rango válido (0 a 10)
if ! [[ "$nota" =~ ^[0-9]+$ ]] || (( nota < 0 || nota > 10 )); then
  resultado="Inválida"
else
  # Evaluamos en orden descendente para asignar bien los rangos
  if (( nota >= 9 )); then
    resultado="Sobresaliente"
  elif (( nota >= 7 )); then
    resultado="Notable"
  elif (( nota >= 6 )); then
    resultado="Bien"
  elif (( nota >= 5 )); then
    resultado="Aprobado"
  else
    resultado="Suspenso"
  fi
fi

# Mostramos el resultado final
echo "Tu calificación es: $resultado"
