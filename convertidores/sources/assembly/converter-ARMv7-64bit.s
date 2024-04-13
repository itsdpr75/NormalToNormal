.syntax unified

.data
    data:
        .byte 100, 150, 200, 250  @ Suponiendo datos de la imagen aquí

.text
    .global convertToNormals
    convertToNormals:
        stp     x29, x30, [sp, -16]!  @ Guardar los registros de enlace y base
        mov     x29, sp                @ Establecer el nuevo puntero de marco

        ldr     x0, [x0]               @ Cargando el tamaño del vector
        mov     x1, #0
        b       .L2

    .L3:
        ldrb    w2, [x29, x1]          @ Cargando un byte del vector
        scvtf   s0, w2                 @ Convertir a flotante
        mov     w2, #255                @ Cargar el valor 255
        scvtf   s1, w2                 @ Convertir a flotante
        fdiv    s0, s0, s1             @ Dividir por 255.0

        fmul    s2, s0, s0             @ Multiplicar por sí mismo (x * x)
        fmul    s3, s0, s0             @ Multiplicar por sí mismo (y * y)

        fadd    s4, s2, s3             @ Sumar (x * x) + (y * y)
        fsub    s4, s4, #1             @ Restar 1

        fsqrt   s4, s4                 @ Calcular la raíz cuadrada

        fdiv    s5, s0, s4             @ Dividir x entre la longitud
        fdiv    s6, s1, s4             @ Dividir y entre la longitud
        fdiv    s0, s4                 @ Dividir z entre la longitud

        fadd    s5, s5, #1             @ x + 1
        fdiv    s5, s5, s1             @ (x + 1) / 2
        fmul    s5, s5, s1             @ ((x + 1) / 2) * 255

        fcvtzs  w2, s5, #0             @ Convertir a entero
        strb    w2, [x29, x1]          @ Almacenar el resultado en el vector

        add     x1, x1, #1             @ Incremento del índice
    .L2:
        cmp     x0, x1                 @ Comprobación de fin de bucle
        b.gt    .L3

        ldp     x29, x30, [sp], 16     @ Restaurar los registros de enlace y base
        ret
