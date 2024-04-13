#!/bin/bash

# Función para calcular la raíz cuadrada usando `bc`
sqrt() {
    echo "sqrt($1)" | bc -l
}

# Función para normalizar los valores RGB
normalize() {
    echo "scale=4; ($1 + 1) / 2 * 255" | bc -l | cut -d '.' -f1
}

# Función principal para convertir los datos a normales
convertToNormals() {
    for ((i = 0; i < ${#data[@]}; i += 4)); do
        r=$(echo "${data[i]} / 255" | bc -l)
        g=$(echo "${data[i + 1]} / 255" | bc -l)

        x=$(echo "($r * 2) - 1" | bc -l)
        y=$(echo "($g * 2) - 1" | bc -l)
        z=$(sqrt "1 - $x * $x - $y * $y")

        length=$(sqrt "$x * $x + $y * $y + $z * $z")
        x=$(echo "$x / $length" | bc -l)
        y=$(echo "$y / $length" | bc -l)
        z=$(echo "$z / $length" | bc -l)

        data[i]=$(normalize "$x")
        data[i + 1]=$(normalize "$y")
        data[i + 2]=$(normalize "$z")
    done
}

# Aquí se supone que tienes una variable "data" que contiene los datos de la imagen
# data=(100 150 200 250 ...)  # Suponiendo datos de la imagen aquí
# convertToNormals
