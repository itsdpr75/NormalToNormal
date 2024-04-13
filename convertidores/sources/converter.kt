import kotlin.math.sqrt

fun convertToNormals(data: ByteArray) {
    for (i in data.indices step 4) {
        val r = data[i].toFloat() / 255.0f
        val g = data[i + 1].toFloat() / 255.0f

        var x = (r * 2) - 1
        var y = (g * 2) - 1
        val z = sqrt(1 - x * x - y * y)

        val length = sqrt(x * x + y * y + z * z)
        x /= length
        y /= length

        data[i] = ((x + 1) / 2 * 255).toByte()
        data[i + 1] = ((y + 1) / 2 * 255).toByte()
        data[i + 2] = ((z + 1) / 2 * 255).toByte()
    }
}

fun main() {
    // Aquí se supone que tienes una variable "data" que contiene los datos de la imagen
    // val data: ByteArray = obtenerDatosDeImagen()
    // convertToNormals(data)
}
