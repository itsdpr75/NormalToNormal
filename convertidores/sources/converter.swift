import Foundation

func convertToNormals(data: inout [UInt8]) {
    for i in stride(from: 0, to: data.count, by: 4) {
        let r = Float(data[i]) / 255.0
        let g = Float(data[i + 1]) / 255.0
        
        var x = (r * 2) - 1
        var y = (g * 2) - 1
        let z = sqrt(1 - x * x - y * y)
        
        let length = sqrt(x * x + y * y + z * z)
        x /= length
        y /= length
        
        data[i] = UInt8((x + 1) / 2 * 255)
        data[i + 1] = UInt8((y + 1) / 2 * 255)
        data[i + 2] = UInt8((z + 1) / 2 * 255)
    }
}

// Aquí se supone que tienes una variable "data" que contiene los datos de la imagen
// var data: [UInt8] = obtenerDatosDeImagen()
// convertToNormals(data: &data)
