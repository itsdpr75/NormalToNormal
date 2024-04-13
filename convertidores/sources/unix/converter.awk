#!/bin/awk -f

function convertToNormals(data,    i, r, g, x, y, z, length) {
    for (i = 1; i <= length(data); i += 4) {
        r = data[i] / 255
        g = data[i + 1] / 255
        
        x = (r * 2) - 1
        y = (g * 2) - 1
        z = sqrt(1 - x * x - y * y)
        
        length = sqrt(x * x + y * y + z * z)
        x /= length
        y /= length
        z /= length
        
        data[i] = int((x + 1) / 2 * 255)
        data[i + 1] = int((y + 1) / 2 * 255)
        data[i + 2] = int((z + 1) / 2 * 255)
    }
    return data
}

# Aquí se supone que tienes una variable "data" que contiene los datos de la imagen
# convertToNormals(data)
