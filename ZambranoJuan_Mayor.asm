.data
    texto1:  .asciiz "Ingrese el primer numero: "
    texto2:  .asciiz "Ingrese el segundo numero: "
    texto3:  .asciiz "Ingrese el tercer numero: "
    salto:  .asciiz "\n"
    resultado: .asciiz "El numero mayor es: "
    num1:     .word 0
    num2:     .word 0
    num3:     .word 0
    max_num:  .word 0

.text
    # Pedir el primer numero
    li $v0, 4                # imprimir cadena
    la $a0, texto1           # cargar el mensaje
    syscall                   # imprimir

    li $v0, 5                
    syscall                   # Llamada al sistema para leer
    sw $v0, num1              # Guardar el valor leído en num1

    # Salto de línea
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

    # Salto de línea
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

    # Salto de línea
    li $v0, 4
    la $a0, salto
    syscall

    # Comparar los tres números para encontrar el mayor
    lw $t0, num1             # Cargar num1 en $t0
    lw $t1, num2             # Cargar num2 en $t1
    lw $t2, num3             # Cargar num3 en $t2

    move $t3, $t0            # Inicialmente, asumimos que num1 es el mayor

    # Comparar num1 y num2
    ble $t3, $t1, second_is_max # Si num1 <= num2, entonces num2 es mayor
    b check_num3              # De lo contrario, comprobar con num3

second_is_max:
    move $t3, $t1            # Ahora num2 es el mayor
    b check_num3

check_num3:
    ble $t3, $t2, third_is_max # Si el mayor actual <= num3, num3 es el mayor
    b print_max

third_is_max:
    move $t3, $t2            # Num3 es el mayor

print_max:
    sw $t3, max_num          # Guardar el mayor número en max_num

    # Mostrar el resultado
    li $v0, 4                # Imprimir cadena
    la $a0, resultado       # Cargar el mensaje "El numero mayor es: "
    syscall                   # Imprimir el mensaje

    lw $a0, max_num           # Cargar el valor de max_num en $a0
    li $v0, 1                
    syscall                   # Imprimir el mayor número

    # Terminar programa
    li $v0, 10               
    syscall
