Answer.destroy_all
Option.destroy_all
Question.destroy_all

# TOPIC: SECUENCIAL
# NIVEL 1

#Pregunta 1
question = Question.create(content: "¿Qué es un algoritmo?", topic_id: 2, level: 1)
option1 = Option.create(content: "Un error en un programa.", question_id: question.id)
option2 = Option.create(content: "Una secuencia de instrucciones para resolver un problema.", question_id: question.id)
option3 = Option.create(content: "Una variable en un programa.", question_id: question.id)

question.update(correct_option_id: option1.id)

#Pregunta 2
question = Question.create(content: "¿Qué es la asignación de variables en programación?", topic_id: 2, level: 1)
option1 = Option.create(content: "Declarar una variable sin asignarle un valor.", question_id: question.id)
option2 = Option.create(content: "Asignar un valor a una variable.", question_id: question.id)
option3 = Option.create(content: "Definir el tipo de una variable.", question_id: question.id)

question.update(correct_option_id: option2.id)

#Pregunta 3
question = Question.create(content: "¿Qué es una constante en programación?", topic_id: 2, level: 1)
option1 = Option.create(content: "Una variable cuyo valor puede cambiar durante la ejecución del programa.", question_id: question.id)
option2 = Option.create(content: "Un valor que se asigna a una variable y no puede cambiar durante la ejecución del programa.", question_id: question.id)
option3 = Option.create(content: "Un tipo de dato utilizado para almacenar números enteros.", question_id: question.id)

question.update(correct_option_id: option2.id)

#NIVEL 2
#Pregunta 1
question = Question.create(content: "¿Cuál es la diferencia entre una variable local y una variable global?", topic_id: 2, level: 2)
option1 = Option.create(content: "Una variable local es accesible desde cualquier parte del programa, mientras que una variable global solo es accesible dentro de una función.", question_id: question.id)
option2 = Option.create(content: "Las variables locales y globales son términos que se utilizan indistintamente y no tienen diferencias en su alcance.", question_id: question.id)
option3 = Option.create(content: "Una variable local solo es accesible dentro de una función, mientras que una variable global es accesible desde cualquier parte del programa.", question_id: question.id)

question.update(correct_option_id: option3.id)

#Pregunta 2
question = Question.create(content: "¿Qué es el ámbito de una variable en programación?", topic_id: 2, level: 2)
option1 = Option.create(content: "La vida útil de una variable durante la ejecución del programa.", question_id: question.id)
option2 = Option.create(content: "La región del programa donde una variable es accesible.", question_id: question.id)
option3 = Option.create(content: "El tipo de dato que se asigna a una variable.", question_id: question.id)

question.update(correct_option_id: option2.id)

#Pregunta 3
question = Question.create(content: "¿Cuál es el operador de comparación utilizado para verificar si un valor es mayor o igual que otro en una condición?", topic_id: 2, level: 2)
option1 = Option.create(content: ">=", question_id: question.id)
option2 = Option.create(content: "<", question_id: question.id)
option3 = Option.create(content: "<=", question_id: question.id)

question.update(correct_option_id: option1.id)

#NIVEL 3
#Pregunta 1
question = Question.create(content: "¿A qué nos referimos con asignación múltiple?", topic_id: 2, level: 3)
option1 = Option.create(content: "La asignación múltiple es cuando se asigna el mismo valor a varias variables en una sola instrucción.", question_id: question.id)
option2 = Option.create(content: "La asignación múltiple es la capacidad de asignar diferentes valores a diferentes variables en una sola instrucción.", question_id: question.id)
option3 = Option.create(content: "La asignación múltiple no es una práctica común en programación.", question_id: question.id)

question.update(correct_option_id: option1.id)

# TOPIC: CONDICIONAL
# NIVEL 1

#Pregunta 1
question = Question.create(content: "¿Qué es una declaración if-else?", topic_id: 3, level: 1)
option1 = Option.create(content: "Una estructura de control que permite repetir una porción de código mientras se cumple una condición.", question_id: question.id)
option2 = Option.create(content: "Una estructura de control que permite ejecutar un bloque de código si se cumple una condición, y otro bloque si no se cumple.", question_id: question.id)
option3 = Option.create(content: "Una estructura de control que permite saltar a una sección específica de código si se cumple una condición.", question_id: question.id)

question.update(correct_option_id: option2.id)

#Pregunta 2
question = Question.create(content: "¿Qué es una declaración if en programación?", topic_id: 3, level: 1)
option1 = Option.create(content: "Una declaración que se ejecuta siempre, independientemente de la condición.", question_id: question.id)
option2 = Option.create(content: "Una declaración que se ejecuta solo si una condición específica se cumple.", question_id: question.id)
option3 = Option.create(content: "Una declaración que se ejecuta solo si una condición específica no se cumple.", question_id: question.id)

question.update(correct_option_id: option2.id)

#Pregunta 3
question = Question.create(content: "¿Cuál es el operador de comparación utilizado para verificar si dos valores son iguales en una condición?", topic_id: 3, level: 1)
option1 = Option.create(content: "==", question_id: question.id)
option2 = Option.create(content: ">", question_id: question.id)
option3 = Option.create(content: "!=", question_id: question.id)

question.update(correct_option_id: option1.id)

# NIVEL 2

#Pregunta 1
question = Question.create(content: "¿Cuál es la diferencia entre los operadores lógicos AND (&&) y OR (||)?", topic_id: 3, level: 2)
option1 = Option.create(content: "AND (&&) y OR (||) son operadores que realizan la misma función y se pueden utilizar indistintamente.", question_id: question.id)
option2 = Option.create(content: "AND (&&) devuelve verdadero si al menos uno de los operandos es verdadero, mientras que OR (||) devuelve verdadero si ambos operandos son verdaderos.", question_id: question.id)
option3 = Option.create(content: "AND (&&) devuelve verdadero si ambos operandos son verdaderos, mientras que OR (||) devuelve verdadero si al menos uno de los operandos es verdadero.", question_id: question.id)

question.update(correct_option_id: option3.id)

# NIVEL 3

#Pregunta 1
question = Question.create(content: "¿Cuál de las siguientes descripciones se corresponde con el concepto de condicional anidado?", topic_id: 3, level: 3)
option1 = Option.create(content: "Un condicional anidado es una técnica que consiste en combinar múltiples condiciones utilizando operadores lógicos para evaluar una única expresión booleana.", question_id: question.id)
option2 = Option.create(content: "Un condicional anidado es una estructura de control en la que se evalúan múltiples condiciones en cascada, donde cada condición se verifica solo si la anterior es falsa.", question_id: question.id)
option3 = Option.create(content: "Un condicional anidado es una estructura de control que permite ejecutar un bloque de código si se cumple una condición, y otro bloque si no se cumple.", question_id: question.id)

question.update(correct_option_id: option2.id)

#Pregunta 2
question = Question.create(content: "¿Qué es una declaración switch en programación?", topic_id: 3, level: 3)
option1 = Option.create(content: "Una declaración que se utiliza para repetir un bloque de código mientras se cumple una condición.", question_id: question.id)
option2 = Option.create(content: "Una declaración que permite ejecutar diferentes bloques de código dependiendo del valor de una variable o expresión.", question_id: question.id)
option3 = Option.create(content: "Una declaración que permite realizar operaciones matemáticas en un programa.", question_id: question.id)

question.update(correct_option_id: option2.id)

#Pregunta 3
question = Question.create(content: "¿Cuál es el operador lógico utilizado para negar una condición en programación?", topic_id: 3, level: 3)
option1 = Option.create(content: "!", question_id: question.id)
option2 = Option.create(content: "&&", question_id: question.id)
option3 = Option.create(content: "||", question_id: question.id)

question.update(correct_option_id: option1.id)

# TOPIC: CICLOS
# NIVEL 1

#Pregunta 1
question = Question.create(content: "¿Qué es un ciclo en programación?", topic_id: 4, level: 1)
option1 = Option.create(content: "Una estructura de control que se repite un número específico de veces.", question_id: question.id)
option2 = Option.create(content: "Una estructura de control que repite un bloque de código mientras se cumple una condición.", question_id: question.id)
option3 = Option.create(content: "Una estructura de control que permite seleccionar entre múltiples opciones.", question_id: question.id)

question.update(correct_option_id: option2.id)

#Pregunta 2
question = Question.create(content: "¿Cuál es la diferencia entre el ciclo while y el ciclo do-while?", topic_id: 4, level: 1)
option1 = Option.create(content: "El ciclo do-while se ejecuta al menos una vez, mientras que el ciclo while puede no ejecutarse nunca.", question_id: question.id)
option2 = Option.create(content: "El ciclo while no existe en programación, solo existe el ciclo do-while.", question_id: question.id)
option3 = Option.create(content: "El ciclo while evalúa la condición al final del ciclo, mientras que el ciclo do-while la evalúa al principio.", question_id: question.id)

question.update(correct_option_id: option1.id)

# NIVEL 2

#Pregunta 1
question = Question.create(content: "¿Cuál es la diferencia entre el ciclo while y el ciclo for?", topic_id: 4, level: 2)
option1 = Option.create(content: "El ciclo while y el ciclo for son estructuras de control idénticas y se pueden utilizar indistintamente.", question_id: question.id)
option2 = Option.create(content: "El ciclo while se utiliza cuando se conoce de antemano el número de veces que se repetirá el bloque de código, mientras que el ciclo for se utiliza cuando no se conoce el número de repeticiones.", question_id: question.id)
option3 = Option.create(content: "El ciclo while se utiliza para repetir un bloque de código mientras se cumple una condición, mientras que el ciclo for se utiliza para repetir un bloque de código un número específico de veces.", question_id: question.id)

question.update(correct_option_id: option3.id)

#Pregunta 2
question = Question.create(content: "¿Qué es una iteración en programación?", topic_id: 4, level: 2)
option1 = Option.create(content: "Una variable que se utiliza en un ciclo para contar el número de repeticiones.", question_id: question.id)
option2 = Option.create(content: "Cada vez que se ejecuta el cuerpo de un ciclo se llama una iteración.", question_id: question.id)
option3 = Option.create(content: "Una operación matemática que se realiza dentro de un ciclo.", question_id: question.id)

question.update(correct_option_id: option2.id)

# NIVEL 3

#Pregunta 1
question = Question.create(content: "¿Qué es un ciclo anidado?", topic_id: 4, level: 3)
option1 = Option.create(content: "Un ciclo que se repite indefinidamente hasta que se cumpla una condición.", question_id: question.id)
option2 = Option.create(content: "Un ciclo que se ejecuta solo si una condición específica se cumple.", question_id: question.id)
option3 = Option.create(content: "Un ciclo que contiene otro ciclo dentro de su bloque de código.", question_id: question.id)

question.update(correct_option_id: option3.id)

#Pregunta 2
question = Question.create(content: "¿Qué es la instrucción break en programación?", topic_id: 4, level: 3)
option1 = Option.create(content: "Una instrucción que finaliza el ciclo actual y continúa con la siguiente iteración.", question_id: question.id)
option2 = Option.create(content: "Una instrucción que finaliza por completo la ejecución del programa.", question_id: question.id)
option3 = Option.create(content: "Una instrucción que permite cambiar el flujo de ejecución a una sección específica del código.", question_id: question.id)

question.update(correct_option_id: option1.id)

# TOPIC: FUNCIONES
# NIVEL 1

#Pregunta 1
question = Question.create(content: "¿Qué es una función en programación?", topic_id: 5, level: 1)
option1 = Option.create(content: "Un conjunto de variables.", question_id: question.id)
option2 = Option.create(content: "Un bloque de código que realiza una tarea específica.", question_id: question.id)
option3 = Option.create(content: "Un tipo de dato numérico.", question_id: question.id)

question.update(correct_option_id: option2.id)

#Pregunta 2
question = Question.create(content: "¿Cuál es el propósito principal de una función en programación?", topic_id: 5, level: 1)
option1 = Option.create(content: "Organizar el código en secciones lógicas y reutilizables.", question_id: question.id)
option2 = Option.create(content: "Definir variables locales.", question_id: question.id)
option3 = Option.create(content: "Realizar operaciones matemáticas complejas.", question_id: question.id)

question.update(correct_option_id: option1.id)

# NIVEL 2

#Pregunta 1
question = Question.create(content: "¿Qué es el 'alcance' de una función en programación?", topic_id: 5, level: 2)
option1 = Option.create(content: "El número de veces que se puede llamar a una función.", question_id: question.id)
option2 = Option.create(content: "El área del programa donde una variable es visible y puede ser utilizada.", question_id: question.id)
option3 = Option.create(content: "El tiempo que tarda una función en ejecutarse.", question_id: question.id)

question.update(correct_option_id: option2.id)

#Pregunta 2
question = Question.create(content: "¿Qué es la 'recursividad' en programación?", topic_id: 5, level: 2)
option1 = Option.create(content: "La capacidad de una función de llamarse a sí misma.", question_id: question.id)
option2 = Option.create(content: "La habilidad de una función para recibir múltiples parámetros.", question_id: question.id)
option3 = Option.create(content: "Un error que ocurre cuando una función se llama demasiadas veces.", question_id: question.id)

question.update(correct_option_id: option1.id)


# NIVEL 3

#Pregunta 1
question = Question.create(content: "¿Qué es una 'función anónima' en programación?", topic_id: 5, level: 3)
option1 = Option.create(content: "Una función sin nombre que se asigna a una variable o se pasa como argumento a otra función.", question_id: question.id)
option2 = Option.create(content: "Una función que solo puede ser utilizada dentro de otra función.", question_id: question.id)
option3 = Option.create(content: "Una función que no devuelve ningún valor.", question_id: question.id)

question.update(correct_option_id: option1.id)

#Pregunta 2
question = Question.create(content: "¿Qué son las 'funciones de orden superior' en programación?", topic_id: 5, level: 3)
option1 = Option.create(content: "Funciones que operan exclusivamente en números enteros.", question_id: question.id)
option2 = Option.create(content: "Funciones que pueden recibir otras funciones como parámetros o devolverlas como resultado.", question_id: question.id)
option3 = Option.create(content: "Funciones que solo pueden ser utilizadas por programadores experimentados.", question_id: question.id)

question.update(correct_option_id: option2.id)

