package main

import (
	"math"
)

func convertToNormals(data []byte) {
	for i := 0; i < len(data); i += 4 {
		r := float32(data[i]) / 255.0
		g := float32(data[i+1]) / 255.0

		x := (r * 2) - 1
		y := (g * 2) - 1
		z := float32(math.Sqrt(float64(1 - x*x - y*y)))

		length := float32(math.Sqrt(float64(x*x + y*y + z*z)))
		x /= length
		y /= length
		z /= length

		data[i] = byte((x + 1) / 2 * 255)
		data[i+1] = byte((y + 1) / 2 * 255)
		data[i+2] = byte((z + 1) / 2 * 255)
	}
}

func main() {
	// Aquí se supone que tienes una variable "data" que contiene los datos de la imagen
	// data := obtenerDatosDeImagen()
	// convertToNormals(data)
}
