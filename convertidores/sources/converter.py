from lib import numpy as np


def convert_to_normals(data):
    for i in range(0, len(data), 4):
        r = data[i] / 255
        g = data[i + 1] / 255

        x = (r * 2) - 1
        y = (g * 2) - 1
        z = np.sqrt(1 - x * x - y * y)

        length = np.sqrt(x * x + y * y + z * z)
        x /= length
        y /= length
        z /= length

        data[i] = int((x + 1) / 2 * 255)
        data[i + 1] = int((y + 1) / 2 * 255)
        data[i + 2] = int((z + 1) / 2 * 255)

# Aquí se supone que tienes una variable "data" que contiene los datos de la imagen
# convert_to_normals(data)
