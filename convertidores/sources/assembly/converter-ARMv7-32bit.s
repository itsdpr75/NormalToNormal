.syntax unified

.data
    data:
        .byte 100, 150, 200, 250  @ Suponiendo datos de la imagen aquí

.text
    .global convertToNormals
    convertToNormals:
        push    {r4, lr}
        mov     r4, r0               @ r0 contiene la dirección del vector
        ldr     r0, [r4]             @ Cargando el tamaño del vector
        mov     r1, #0
        b       .L2

    .L3:
        ldrb    r2, [r4, r1]         @ Cargando un byte del vector
        vmov    s0, r2                @ Moviendo el byte a un registro de punto flotante
        vmov.f32 s1, #255.0           @ Moviendo el valor 255.0 a un registro de punto flotante
        vdiv.f32 s0, s0, s1           @ Dividiendo el byte por 255.0

        vmul.f32 s2, s0, s0           @ Multiplicar por sí mismo (x * x)
        vmul.f32 s3, s0, s0           @ Multiplicar por sí mismo (y * y)

        vadd.f32 s4, s2, s3           @ Sumar (x * x) + (y * y)
        vsub.f32 s4, #1.0             @ Restar 1

        vsqrt.f32 s4, s4              @ Calcular la raíz cuadrada

        vmov    r2, s0                @ Moviendo el valor de s0 a r2
        vdiv.f32 s5, s0, s4           @ Dividir x entre la longitud
        vdiv.f32 s6, s1, s4           @ Dividir y entre la longitud
        vdiv.f32 s0, s4               @ Dividir z entre la longitud

        vadd.f32 s5, #1.0             @ x + 1
        vdiv.f32 s5, s5, s1           @ (x + 1) / 2
        vmul.f32 s5, s5, s1           @ ((x + 1) / 2) * 255

        vcvt.s32.f32 s5, s5           @ Convertir a entero
        vmov    r2, s5                @ Mover el resultado a r2
        strb    r2, [r4, r1]          @ Almacenar el resultado en el vector

        add     r1, r1, #1            @ Incremento del índice
    .L2:
        cmp     r0, r1                @ Comprobación de fin de bucle
        bgt     .L3

        pop     {r4, pc}
