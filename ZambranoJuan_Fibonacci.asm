.data
    texto:         .asciiz "Ingrese cuantos numeros de la serie Fibonacci desea generar: "
    salto:        .asciiz "\n"
    fibo:        .asciiz "Serie Fibonacci: "
    Ms_suma:        .asciiz "\nLa suma de los numeros es: "
    n:              .word 0          # Cantidad de números a generar
    sum:            .word 0          # Suma total de la serie

.text
    main:
        # Solicitar al usuario la cantidad de números a generar
        li $v0, 4                    # Imprimir cadena
        la $a0, texto                # Cargar el mensaje
        syscall                       # Llamada al sistema para imprimir

        li $v0, 5                    # leer entero
        syscall                       # Leer cantidad de números
        sw $v0, n                     # Guardar el valor en la variable 'n'

        # Inicialización de los primeros dos valores de Fibonacci
        li $t0, 0                    # fib(0)
        li $t1, 1                    # fib(1)
        li $t2, 0                    # Inicializar el contador
        li $t3, 0                    # Para la suma de la serie

        # Imprimir el mensaje de la serie
        li $v0, 4                    # Imprimir cadena
        la $a0, fibo              # Cargar el mensaje "Serie Fibonacci: "
        syscall                       # Llamada al sistema para imprimir

        # Imprimir fib(0)
        li $v0, 1                    # Imprimir entero
        move $a0, $t0                 # Pasar fib(0) a $a0
        syscall                       # Imprimir fib(0)

        # Salto de linea
        li $v0, 4
        la $a0, salto
        syscall

        # Sumar fib(0) a la suma total
        add $t3, $t3, $t0

        # Comprobar si el numero de elementos solicitados es 1
        lw $t4, n                     # Cargar la cantidad de numeros
        li $t5, 1
        beq $t4, $t5, print_sum       # Si es 1, salta directamente a imprimir la suma

        # Imprimir fib(1)
        li $v0, 1                    # Imprimir
        move $a0, $t1                 # Pasar fib(1) a $a0
        syscall                       # Imprimir fib(1)

        # Salto de línea
        li $v0, 4
        la $a0, salto
        syscall

        # Sumar fib(1) a la suma total
        add $t3, $t3, $t1

        # Ciclo para generar el resto de la serie
    fibonacci_loop:
        addi $t2, $t2, 1              # Incrementar el contador
        bge $t2, $t4, print_sum       # Si el contador >= n, termina

        # Generar el siguiente número de Fibonacci
        add $t6, $t0, $t1             # t6 = fib(i) + fib(i-1)
        move $t0, $t1                 # fib(i-1) = fib(i)
        move $t1, $t6                 # fib(i) = fib(i+1)

        # Imprimir el siguiente número de Fibonacci
        li $v0, 1                    # Imprimir
        move $a0, $t1                 # Pasar fib(i+1) a $a0
        syscall                       # Imprimir fib(i+1)

        # Salto de línea
        li $v0, 4
        la $a0, salto
        syscall

        # Sumar el valor de fib(i+1) a la suma total
        add $t3, $t3, $t1

        # Repetir iteracion
        b fibonacci_loop

    print_sum:
        # Imprimir la suma total de la serie
        li $v0, 4                    # Imprimir cadena
        la $a0, Ms_suma               # Cargar el mensaje "La suma de los numeros es: "
        syscall                       # Imprimir el mensaje

        li $v0, 1                    # Imprimir
        move $a0, $t3                 # Pasar la suma total a $a0
        syscall                       # Imprimir la suma total

        # Terminar el programa
        li $v0, 10                   
        syscall
