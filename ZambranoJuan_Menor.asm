.data
    texto1:  .asciiz "Ingrese el primer numero: "
    texto2:  .asciiz "Ingrese el segundo numero: "
    texto3:  .asciiz "Ingrese el tercer numero: "
    salto:  .asciiz "\n"
    resultado: .asciiz "El numero menor es: "
    num1:     .word 0
    num2:     .word 0
    num3:     .word 0
    min_num:  .word 0

.text
    # Pedir el primer numero
    li $v0, 4                # Imprimir texto1
    la $a0, texto1           # Cargar el mensaje
    syscall                   # Llamada al sistema para imprimir

    li $v0, 5                
    syscall                   # Llamada al sistema para leer
    sw $v0, num1              # Guardar el valor leído en num1

    # Salto de linea
    li $v0, 4
    la $a0, salto
    syscall

    # Pedir el segundo numero
    li $v0, 4
    la $a0, texto2
    syscall

    li $v0, 5
    syscall
    sw $v0, num2

    # Salto de linea
    li $v0, 4
    la $a0, salto
    syscall

    # Pedir el tercer numero
    li $v0, 4
    la $a0, texto3
    syscall

    li $v0, 5
    syscall
    sw $v0, num3

    # Salto de linea
    li $v0, 4
    la $a0, salto
    syscall

    # Comparar los tres números para encontrar el menor
    lw $t0, num1             # Cargar num1 en $t0
    lw $t1, num2             # Cargar num2 en $t1
    lw $t2, num3             # Cargar num3 en $t2

    move $t3, $t0            # Inicialmente, asumimos que num1 es el menor

    # Comparar num1 y num2
    bge $t3, $t1, second_is_min # Si num1 >= num2, entonces num2 es menor
    b check_num3              # De lo contrario, comprobar con num3

second_is_min:
    move $t3, $t1            # Ahora num2 es el menor
    b check_num3

check_num3:
    bge $t3, $t2, third_is_min # Si el menor actual >= num3, num3 es el menor
    b print_min

third_is_min:
    move $t3, $t2            # Num3 es el menor

print_min:
    sw $t3, min_num          # Guardar el menor número en min_num

    # Mostrar el resultado
    li $v0, 4                # Imprimir cadena
    la $a0, resultado        # Cargar el mensaje "El numero menor es: "
    syscall                   # Imprimir el mensaje

    lw $a0, min_num           # Cargar el valor de min_num en $a0
    li $v0, 1                # Imprimir entero
    syscall                   # Imprimir el menor número

    # Terminar programa
    li $v0, 10               
    syscall
