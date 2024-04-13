#include <stdio.h>
#include <math.h>

void convertToNormals(unsigned char *data, size_t size) {
    for (size_t i = 0; i < size; i += 4) {
        float r = data[i] / 255.0f;
        float g = data[i + 1] / 255.0f;

        float x = (r * 2) - 1;
        float y = (g * 2) - 1;
        float z = sqrt(1 - x * x - y * y);

        float length = sqrt(x * x + y * y + z * z);
        x /= length;
        y /= length;
        z /= length;

        data[i] = (unsigned char)((x + 1) / 2 * 255);
        data[i + 1] = (unsigned char)((y + 1) / 2 * 255);
        data[i + 2] = (unsigned char)((z + 1) / 2 * 255);
    }
}

int main() {
    // Aquí se supone que tienes una variable "data" que contiene los datos de la imagen
    // convertToNormals(data, tamaño_de_datos);
    return 0;
}
