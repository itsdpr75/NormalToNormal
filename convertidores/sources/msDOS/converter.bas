REM Función para calcular la raíz cuadrada
DEF FNsqrt(n) = SQR(n)

REM Función para redondear un número
DEF FNround(n) = INT(n + 0.5)

REM Subrutina para convertir los datos a normales
SUB ConvertToNormals(data())
    FOR i = 0 TO UBOUND(data) STEP 4
        r = data(i) / 255
        g = data(i + 1) / 255

        x = (r * 2) - 1
        y = (g * 2) - 1
        z = FNsqrt(1 - x * x - y * y)

        length = FNsqrt(x * x + y * y + z * z)
        x = x / length
        y = y / length
        z = z / length

        data(i) = FNround((x + 1) / 2 * 255)
        data(i + 1) = FNround((y + 1) / 2 * 255)
        data(i + 2) = FNround((z + 1) / 2 * 255)
    NEXT i
END SUB

REM Aquí se supone que tienes una matriz "data" que contiene los datos de la imagen
REM ConvertToNormals data
