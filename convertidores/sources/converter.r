convertToNormals <- function(data) {
  for (i in seq(1, length(data), by=4)) {
    r <- data[i] / 255
    g <- data[i + 1] / 255
    
    x <- (r * 2) - 1
    y <- (g * 2) - 1
    z <- sqrt(1 - x * x - y * y)
    
    length <- sqrt(x * x + y * y + z * z)
    x <- x / length
    y <- y / length
    z <- z / length
    
    data[i] <- as.integer((x + 1) / 2 * 255)
    data[i + 1] <- as.integer((y + 1) / 2 * 255)
    data[i + 2] <- as.integer((z + 1) / 2 * 255)
  }
  return(data)
}

# Aquí se supone que tienes una variable "data" que contiene los datos de la imagen
# data <- obtenerDatosDeImagen()
# convertToNormals(data)
