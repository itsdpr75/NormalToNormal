#include <iostream>
#include <cmath>
#include <vector>

void convertToNormals(std::vector<unsigned char>& data) {
    for (size_t i = 0; i < data.size(); i += 4) {
        float r = data[i] / 255.0f;
        float g = data[i + 1] / 255.0f;

        float x = (r * 2) - 1;
        float y = (g * 2) - 1;
        float z = std::sqrt(1 - x * x - y * y);

        float length = std::sqrt(x * x + y * y + z * z);
        x /= length;
        y /= length;
        z /= length;

        data[i] = static_cast<unsigned char>((x + 1) / 2 * 255);
        data[i + 1] = static_cast<unsigned char>((y + 1) / 2 * 255);
        data[i + 2] = static_cast<unsigned char>((z + 1) / 2 * 255);
    }
}

int main() {
    // Aquí se supone que tienes una variable "data" que contiene los datos de la imagen
    // vector<unsigned char> data = obtenerDatosDeImagen();
    // convertToNormals(data);
    return 0;
}
