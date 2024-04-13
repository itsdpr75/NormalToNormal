.section .data
    data:
        .byte 100, 150, 200, 250  # Suponiendo datos de la imagen aquí

.section .text
    .globl _Z14convertToNormalsRSt6vectorIhSaIhEE
    _Z14convertToNormalsRSt6vectorIhSaIhEE:
        pushl   %ebp
        movl    %esp, %ebp
        movl    8(%ebp), %eax         # [ebp + 8] contiene la dirección del vector
        movl    12(%ebp), %ecx        # [ebp + 12] contiene el tamaño del vector
        xorl    %edx, %edx
        jmp     .L2

    .L3:
        movzbl  (%eax,%edx), %eax     # Cargando un byte del vector
        cvtsi2ss %eax, %xmm0          # Convertir a flotante en xmm0
        movzbl  1(%eax,%edx), %eax
        cvtsi2ss %eax, %xmm1

        movss   %xmm0, %xmm2
        mulss   .LC0(%ebx), %xmm2     # Multiplicar por 2
        subss   .LC1(%ebx), %xmm2     # Restar 1

        movss   %xmm1, %xmm3
        mulss   .LC0(%ebx), %xmm3
        subss   .LC1(%ebx), %xmm3

        movss   %xmm2, %xmm4
        mulss   %xmm2, %xmm4          # x * x
        movss   %xmm3, %xmm5
        mulss   %xmm3, %xmm5          # y * y

        movss   %xmm4, %xmm6
        addss   %xmm5, %xmm6
        movss   .LC2(%ebx), %xmm7
        subss   %xmm6, %xmm7          # 1 - x*x - y*y
        sqrtsd  %xmm7, %xmm7          # Raíz cuadrada

        movss   %xmm2, %xmm0
        mulss   %xmm0, %xmm0
        movss   %xmm3, %xmm1
        mulss   %xmm1, %xmm1
        movss   %xmm7, %xmm2
        mulss   %xmm2, %xmm2
        addss   %xmm0, %xmm1
        addss   %xmm1, %xmm2
        sqrtsd  %xmm2, %xmm2          # Longitud

        divss   %xmm2, %xmm7          # x / length
        divss   %xmm2, %xmm6          # y / length
        divss   %xmm2, %xmm0          # z / length

        addss   .LC1(%ebx), %xmm7     # x + 1
        divss   .LC0(%ebx), %xmm7     # (x + 1) / 2
        mulss   .LC0(%ebx), %xmm7     # ((x + 1) / 2) * 255
        cvttss2si %xmm7, %eax         # Convertir a entero
        mov     %al, (%eax,%edx)

        addss   .LC1(%ebx), %xmm6
        divss   .LC0(%ebx), %xmm6
        mulss   .LC0(%ebx), %xmm6
        cvttss2si %xmm6, %eax
        mov     %al, 1(%eax,%edx)

        addss   .LC1(%ebx), %xmm0
        divss   .LC0(%ebx), %xmm0
        mulss   .LC0(%ebx), %xmm0
        cvttss2si %xmm0, %eax
        mov     %al, 2(%eax,%edx)

        addl    $4, %edx               # Incremento del índice
    .L2:
        cmpl    %ecx, %edx             # Comprobación de fin de bucle
        jb      .L3

        popl    %ebp
        ret

.section .rodata
    .LC0:
        .long 0x3f800000               # Representación binaria de 1.0f
    .LC1:
        .long 0x3f000000               # Representación binaria de 0.5f
    .LC2:
        .long 0x3f800000               # Representación binaria de 1.0f
