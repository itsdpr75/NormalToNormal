def convert_to_normals(data)
    data.each_index do |i|
        next if i % 4 != 0

        r = data[i].to_f / 255.0
        g = data[i + 1].to_f / 255.0

        x = (r * 2) - 1
        y = (g * 2) - 1
        z = Math.sqrt(1 - x * x - y * y)

        length = Math.sqrt(x * x + y * y + z * z)
        x /= length
        y /= length
        z /= length

        data[i] = ((x + 1) / 2 * 255).round
        data[i + 1] = ((y + 1) / 2 * 255).round
        data[i + 2] = ((z + 1) / 2 * 255).round
    end
end

# Aquí se supone que tienes una variable "data" que contiene los datos de la imagen
# data = obtener_datos_de_imagen()
# convert_to_normals(data)
