Knowledge.destroy_all
Answer.destroy_all
Option.destroy_all
Question.destroy_all
Topic.destroy_all
User.destroy_all

# CREACION DE TOPICS

topic1 = Topic.create(:name => "Secuencial", :amount_questions_L1 => 3, :amount_questions_L2 => 3, :amount_questions_L3 => 3) 
topic2 = Topic.create(:name => "Condicional", :amount_questions_L1 => 3, :amount_questions_L2 => 3, :amount_questions_L3 => 3)
topic3 = Topic.create(:name => "Ciclos", :amount_questions_L1 => 3, :amount_questions_L2 => 3, :amount_questions_L3 => 3)
topic4 = Topic.create(:name => "Funciones", :amount_questions_L1 => 3, :amount_questions_L2 => 3, :amount_questions_L3 => 3)

topics = [topic1, topic2, topic3, topic4]

# TOPIC: SECUENCIAL
# NIVEL 1

#Pregunta 1
question = Question.create(:content => "¿Qué es un algoritmo?", :topic_id => topic1.id, :level => 1)
option1 = Option.create(:content => "Un error en un programa.", :question_id => question.id)
option2 = Option.create(:content => "Una secuencia de instrucciones para resolver un problema.", :question_id => question.id)
option3 = Option.create(:content => "Una variable en un programa.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

#Pregunta 2
question = Question.create(:content => "¿Qué es la asignación de variables en programación?", :topic_id => topic1.id, :level => 1)
option1 = Option.create(:content => "Declarar una variable sin asignarle un valor.", :question_id => question.id)
option2 = Option.create(:content => "Asignar un valor a una variable.", :question_id => question.id)
option3 = Option.create(:content => "Definir el tipo de una variable.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

#Pregunta 3
question = Question.create(:content => "¿Qué es una constante en programación?", :topic_id => topic1.id, :level => 1)
option1 = Option.create(:content => "Una variable cuyo valor puede cambiar durante la ejecución del programa.", :question_id => question.id)
option2 = Option.create(:content => "Un valor que se asigna a una variable y no puede cambiar durante la ejecución del programa.", :question_id => question.id)
option3 = Option.create(:content => "Un tipo de dato utilizado para almacenar números enteros.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

#NIVEL 2
#Pregunta 1
question = Question.create(:content => "¿Cuál es la diferencia entre una variable local y una variable global?", :topic_id => topic1.id, :level => 2)
option1 = Option.create(:content => "Una variable local es accesible desde cualquier parte del programa, mientras que una variable global solo es accesible dentro de una función.", :question_id => question.id)
option2 = Option.create(:content => "Las variables locales y globales son términos que se utilizan indistintamente y no tienen diferencias en su alcance.", :question_id => question.id)
option3 = Option.create(:content => "Una variable local solo es accesible dentro de una función, mientras que una variable global es accesible desde cualquier parte del programa.", :question_id => question.id)

option3.update(:correct => true)
#question.update(correct_option_id: option3.id)

#Pregunta 2
question = Question.create(:content => "¿Qué es el ámbito de una variable en programación?", :topic_id => topic1.id, :level => 2)
option1 = Option.create(:content => "La vida útil de una variable durante la ejecución del programa.", :question_id => question.id)
option2 = Option.create(:content => "La región del programa donde una variable es accesible.", :question_id => question.id)
option3 = Option.create(:content => "El tipo de dato que se asigna a una variable.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

#Pregunta 3
question = Question.create(:content => "¿Cuál es el operador de comparación utilizado para verificar si un valor es mayor o igual que otro en una condición?", :topic_id => topic1.id, :level => 2)
option1 = Option.create(:content => ">=", :question_id => question.id)
option2 = Option.create(:content => "<", :question_id => question.id)
option3 = Option.create(:content => "<=", :question_id => question.id)

option1.update(:correct => true)
#question.update(correct_option_id: option1.id)

#NIVEL 3
#Pregunta 1
question = Question.create(:content => "¿A qué nos referimos con asignación múltiple?", :topic_id => topic1.id, :level => 3)
option1 = Option.create(:content => "La asignación múltiple es cuando se asigna el mismo valor a varias variables en una sola instrucción.", :question_id => question.id)
option2 = Option.create(:content => "La asignación múltiple es la capacidad de asignar diferentes valores a diferentes variables en una sola instrucción.", :question_id => question.id)
option3 = Option.create(:content => "La asignación múltiple no es una práctica común en programación.", :question_id => question.id)

option1.update(:correct => true)
#question.update(correct_option_id: option1.id)

#Pregunta 2
question = Question.create(:content => "En programación, ¿qué hace el operador de concatenación de cadenas?", :topic_id => topic1.id, :level => 3)
option1 = Option.create(:content => "Combina dos cadenas en una sola.", :question_id => question.id)
option2 = Option.create(:content => "Divide una cadena en múltiples subcadenas.", :question_id => question.id)
option3 = Option.create(:content => "Compara dos cadenas y devuelve un valor booleano.", :question_id => question.id)

option1.update(:correct => true)
#question.update(correct_option_id: option1.id)

#Pregunta 3
question = Question.create(:content => "¿Cuál de las siguientes opciones es un ejemplo de una función de salida en programación?", :topic_id => topic1.id, :level => 3)
option1 = Option.create(:content => "scanf()", :question_id => question.id)
option2 = Option.create(:content => "sqrt()", :question_id => question.id)
option3 = Option.create(:content => "printf()", :question_id => question.id)

option3.update(:correct => true)
#question.update(correct_option_id: option3.id)

# TOPIC: CONDICIONAL
# NIVEL 1

#Pregunta 1
question = Question.create(:content => "¿Qué es una declaración if-else?", :topic_id => topic2.id, :level => 1)
option1 = Option.create(:content => "Una estructura de control que permite repetir una porción de código mientras se cumple una condición.", :question_id => question.id)
option2 = Option.create(:content => "Una estructura de control que permite ejecutar un bloque de código si se cumple una condición, y otro bloque si no se cumple.", :question_id => question.id)
option3 = Option.create(:content => "Una estructura de control que permite saltar a una sección específica de código si se cumple una condición.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

#Pregunta 2
question = Question.create(:content => "¿Qué es una declaración if en programación?", :topic_id => topic2.id, :level => 1)
option1 = Option.create(:content => "Una declaración que se ejecuta siempre, independientemente de la condición.", :question_id => question.id)
option2 = Option.create(:content => "Una declaración que se ejecuta solo si una condición específica se cumple.", :question_id => question.id)
option3 = Option.create(:content => "Una declaración que se ejecuta solo si una condición específica no se cumple.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

#Pregunta 3
question = Question.create(:content => "¿Cuál es el operador de comparación utilizado para verificar si dos valores son iguales en una condición?", :topic_id => topic2.id, :level => 1)
option1 = Option.create(:content => "==", :question_id => question.id)
option2 = Option.create(:content => ">", :question_id => question.id)
option3 = Option.create(:content => "!=", :question_id => question.id)

option1.update(:correct => true)
#question.update(correct_option_id: option1.id)

# NIVEL 2

#Pregunta 1
question = Question.create(:content => "¿Cuál es la diferencia entre los operadores lógicos AND (&&) y OR (||)?", :topic_id => topic2.id, :level => 2)
option1 = Option.create(:content => "AND (&&) y OR (||) son operadores que realizan la misma función y se pueden utilizar indistintamente.", :question_id => question.id)
option2 = Option.create(:content => "AND (&&) devuelve verdadero si al menos uno de los operandos es verdadero, mientras que OR (||) devuelve verdadero si ambos operandos son verdaderos.", :question_id => question.id)
option3 = Option.create(:content => "AND (&&) devuelve verdadero si ambos operandos son verdaderos, mientras que OR (||) devuelve verdadero si al menos uno de los operandos es verdadero.", :question_id => question.id)

option3.update(:correct => true)
#question.update(correct_option_id: option3.id)

#Pregunta 2
question = Question.create(:content => "En programación, ¿qué es una condición compuesta?", :topic_id => topic2.id, :level => 2)
option1 = Option.create(:content => "Una condición que siempre se evalúa como verdadera.", :question_id => question.id)
option2 = Option.create(:content => "Una condición que se utiliza para definir variables booleanas.", :question_id => question.id)
option3 = Option.create(:content => "Una condición que combina múltiples condiciones utilizando operadores lógicos.", :question_id => question.id)

option3.update(:correct => true)
#question.update(correct_option_id: option3.id)

#Pregunta 3
question = Question.create(:content => "En programación, ¿qué es un bloque 'else' en una sentencia 'if-else'?", :topic_id => topic2.id, :level => 2)
option1 = Option.create(:content => "Un bloque de código que se ejecuta si la condición del 'if' es verdadera.", :question_id => question.id)
option2 = Option.create(:content => "Un bloque de código que se ejecuta si la condición del 'if' es falsa.", :question_id => question.id)
option3 = Option.create(:content => "Un bloque de código que se ejecuta antes de la evaluación de la condición del 'if'.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

# NIVEL 3

#Pregunta 1
question = Question.create(:content => "¿Cuál de las siguientes descripciones se corresponde con el concepto de condicional anidado?", :topic_id => topic2.id, :level => 3)
option1 = Option.create(:content => "Un condicional anidado es una técnica que consiste en combinar múltiples condiciones utilizando operadores lógicos para evaluar una única expresión booleana.", :question_id => question.id)
option2 = Option.create(:content => "Un condicional anidado es una estructura de control en la que se evalúan múltiples condiciones en cascada, donde cada condición se verifica solo si la anterior es falsa.", :question_id => question.id)
option3 = Option.create(:content => "Un condicional anidado es una estructura de control que permite ejecutar un bloque de código si se cumple una condición, y otro bloque si no se cumple.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

#Pregunta 2
question = Question.create(:content => "¿Qué es una declaración switch en programación?", :topic_id => topic2.id, :level => 3)
option1 = Option.create(:content => "Una declaración que se utiliza para repetir un bloque de código mientras se cumple una condición.", :question_id => question.id)
option2 = Option.create(:content => "Una declaración que permite ejecutar diferentes bloques de código dependiendo del valor de una variable o expresión.", :question_id => question.id)
option3 = Option.create(:content => "Una declaración que permite realizar operaciones matemáticas en un programa.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

#Pregunta 3
question = Question.create(:content => "¿Cuál es el operador lógico utilizado para negar una condición en programación?", :topic_id => topic2.id, :level => 3)
option1 = Option.create(:content => "!", :question_id => question.id)
option2 = Option.create(:content => "&&", :question_id => question.id)
option3 = Option.create(:content => "||", :question_id => question.id)

option1.update(:correct => true)
#question.update(correct_option_id: option1.id)

# TOPIC: CICLOS
# NIVEL 1

#Pregunta 1
question = Question.create(:content => "¿Qué es un ciclo en programación?", :topic_id => topic3.id, :level => 1)
option1 = Option.create(:content => "Una estructura de control que se repite un número específico de veces.", :question_id => question.id)
option2 = Option.create(:content => "Una estructura de control que repite un bloque de código mientras se cumple una condición.", :question_id => question.id)
option3 = Option.create(:content => "Una estructura de control que permite seleccionar entre múltiples opciones.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

#Pregunta 2
question = Question.create(:content => "¿Cuál es la diferencia entre el ciclo while y el ciclo do-while?", :topic_id => topic3.id, :level => 1)
option1 = Option.create(:content => "El ciclo do-while se ejecuta al menos una vez, mientras que el ciclo while puede no ejecutarse nunca.", :question_id => question.id)
option2 = Option.create(:content => "El ciclo while no existe en programación, solo existe el ciclo do-while.", :question_id => question.id)
option3 = Option.create(:content => "El ciclo while evalúa la condición al final del ciclo, mientras que el ciclo do-while la evalúa al principio.", :question_id => question.id)

option1.update(:correct => true)
#question.update(correct_option_id: option1.id)

#Pregunta 3
question = Question.create(:content => "En programación, ¿qué es un ciclo 'for'?", :topic_id => topic3.id, :level => 1)
option1 = Option.create(:content => "Una estructura utilizada para tomar decisiones basadas en una condición específica.", :question_id => question.id)
option2 = Option.create(:content => "Una estructura utilizada para definir variables y asignarles valores.", :question_id => question.id)
option3 = Option.create(:content => "Una estructura utilizada para repetir un bloque de código un número específico de veces.", :question_id => question.id)

option3.update(:correct => true)
#question.update(correct_option_id: option3.id)

# NIVEL 2

#Pregunta 1
question = Question.create(:content => "¿Cuál es la diferencia entre el ciclo while y el ciclo for?", :topic_id => topic3.id, :level => 2)
option1 = Option.create(:content => "El ciclo while y el ciclo for son estructuras de control idénticas y se pueden utilizar indistintamente.", :question_id => question.id)
option2 = Option.create(:content => "El ciclo while se utiliza cuando se conoce de antemano el número de veces que se repetirá el bloque de código, mientras que el ciclo for se utiliza cuando no se conoce el número de repeticiones.",
                        :question_id => question.id)
option3 = Option.create(:content => "El ciclo while se utiliza para repetir un bloque de código mientras se cumple una condición, mientras que el ciclo for se utiliza para repetir un bloque de código un número específico de veces.",
                        :question_id => question.id)
option3.update(:correct => true)
#question.update(correct_option_id: option3.id)

#Pregunta 2
question = Question.create(:content => "¿Qué es una iteración en programación?", :topic_id => topic3.id, :level => 2)
option1 = Option.create(:content => "Una variable que se utiliza en un ciclo para contar el número de repeticiones.", :question_id => question.id)
option2 = Option.create(:content => "Cada vez que se ejecuta el cuerpo de un ciclo se llama una iteración.", :question_id => question.id)
option3 = Option.create(:content => "Una operación matemática que se realiza dentro de un ciclo.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

#Pregunta 3
question = Question.create(:content => "¿Cuál es el propósito de utilizar la sentencia 'continue' en un ciclo?", :topic_id => topic3.id, :level => 2)
option1 = Option.create(:content => "Finalizar la ejecución del ciclo y continuar con la siguiente instrucción fuera del ciclo.", :question_id => question.id)
option2 = Option.create(:content => "Ignorar una iteración del ciclo y pasar a la siguiente.", :question_id => question.id)
option3 = Option.create(:content => "Reiniciar el ciclo desde el principio.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

# NIVEL 3

#Pregunta 1
question = Question.create(:content => "¿Qué es un ciclo anidado?", :topic_id => topic3.id, :level => 3)
option1 = Option.create(:content => "Un ciclo que se repite indefinidamente hasta que se cumpla una condición.", :question_id => question.id)
option2 = Option.create(:content => "Un ciclo que se ejecuta solo si una condición específica se cumple.", :question_id => question.id)
option3 = Option.create(:content => "Un ciclo que contiene otro ciclo dentro de su bloque de código.", :question_id => question.id)

option3.update(:correct => true)
#question.update(correct_option_id: option3.id)

#Pregunta 2
question = Question.create(:content => "¿Qué es la instrucción break en programación?", :topic_id => topic3.id, :level => 3)
option1 = Option.create(:content => "Una instrucción que finaliza el ciclo actual y continúa con la siguiente iteración.", :question_id => question.id)
option2 = Option.create(:content => "Una instrucción que finaliza por completo la ejecución del programa.", :question_id => question.id)
option3 = Option.create(:content => "Una instrucción que permite cambiar el flujo de ejecución a una sección específica del código.", :question_id => question.id)

option1.update(:correct => true)
#question.update(correct_option_id: option1.id)

#Pregunta 3
question = Question.create(:content => "En programación, ¿qué es un ciclo 'foreach'?", :topic_id => topic3.id, :level => 3)
option1 = Option.create(:content => "Una estructura utilizada para iterar sobre una colección de elementos, como un arreglo o una lista.", :question_id => question.id)
option2 = Option.create(:content => "Una estructura utilizada para tomar decisiones basadas en múltiples condiciones secuenciales.", :question_id => question.id)
option3 = Option.create(:content => "Una estructura utilizada para repetir un bloque de código un número específico de veces.", :question_id => question.id)

option1.update(:correct => true)
#question.update(correct_option_id: option1.id)

# TOPIC: FUNCIONES
# NIVEL 1

#Pregunta 1
question = Question.create(:content => "¿Qué es una función en programación?", :topic_id => topic4.id, :level => 1)
option1 = Option.create(:content => "Un conjunto de variables.", :question_id => question.id)
option2 = Option.create(:content => "Un bloque de código que realiza una tarea específica.", :question_id => question.id)
option3 = Option.create(:content => "Un tipo de dato numérico.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

#Pregunta 2
question = Question.create(:content => "¿Cuál es el propósito principal de una función en programación?", :topic_id => topic4.id, :level => 1)
option1 = Option.create(:content => "Organizar el código en secciones lógicas y reutilizables.", :question_id => question.id)
option2 = Option.create(:content => "Definir variables locales.", :question_id => question.id)
option3 = Option.create(:content => "Realizar operaciones matemáticas complejas.", :question_id => question.id)

option1.update(:correct => true)
#question.update(correct_option_id: option1.id)

#Pregunta 3
question = Question.create(:content => "En programación, ¿qué es un parámetro en una función?", :topic_id => topic4.id, :level => 1)
option1 = Option.create(:content => "Una variable utilizada para almacenar el resultado de una operación matemática.", :question_id => question.id)
option2 = Option.create(:content => "Una variable utilizada para almacenar datos temporales dentro de una función.", :question_id => question.id)
option3 = Option.create(:content => "Una variable utilizada para pasar valores a una función cuando se invoca.", :question_id => question.id)

option3.update(:correct => true)
#question.update(correct_option_id: option3.id)

# NIVEL 2

#Pregunta 1
question = Question.create(:content => "¿Qué es el 'alcance' de una función en programación?", :topic_id => topic4.id, :level => 2)
option1 = Option.create(:content => "El número de veces que se puede llamar a una función.", :question_id => question.id)
option2 = Option.create(:content => "El área del programa donde una variable es visible y puede ser utilizada.", :question_id => question.id)
option3 = Option.create(:content => "El tiempo que tarda una función en ejecutarse.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

#Pregunta 2
question = Question.create(:content => "¿Qué es la 'recursividad' en programación?", :topic_id => topic4.id, :level => 2)
option1 = Option.create(:content => "La capacidad de una función de llamarse a sí misma.", :question_id => question.id)
option2 = Option.create(:content => "La habilidad de una función para recibir múltiples parámetros.", :question_id => question.id)
option3 = Option.create(:content => "Un error que ocurre cuando una función se llama demasiadas veces.", :question_id => question.id)

option1.update(:correct => true)
#question.update(correct_option_id: option1.id)

#Pregunta 3
question = Question.create(:content => "En programación, ¿qué es el 'valor de retorno' de una función?", :topic_id => topic4.id, :level => 2)
option1 = Option.create(:content => "El valor que se pasa como argumento a una función.", :question_id => question.id)
option2 = Option.create(:content => "El valor que una función devuelve después de realizar su tarea.", :question_id => question.id)
option3 = Option.create(:content => "El valor predeterminado que se asigna a una variable dentro de una función.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)


# NIVEL 3

#Pregunta 1
question = Question.create(:content => "¿Qué es una 'función anónima' en programación?", :topic_id => topic4.id, :level => 3)
option1 = Option.create(:content => "Una función sin nombre que se asigna a una variable o se pasa como argumento a otra función.", :question_id => question.id)
option2 = Option.create(:content => "Una función que solo puede ser utilizada dentro de otra función.", :question_id => question.id)
option3 = Option.create(:content => "Una función que no devuelve ningún valor.", :question_id => question.id)

option1.update(:correct => true)
#question.update(correct_option_id: option1.id)

#Pregunta 2
question = Question.create(:content => "¿Qué son las 'funciones de orden superior' en programación?", :topic_id => topic4.id, :level => 3)
option1 = Option.create(:content => "Funciones que operan exclusivamente en números enteros.", :question_id => question.id)
option2 = Option.create(:content => "Funciones que pueden recibir otras funciones como parámetros o devolverlas como resultado.", :question_id => question.id)
option3 = Option.create(:content => "Funciones que solo pueden ser utilizadas por programadores experimentados.", :question_id => question.id)

option2.update(:correct => true)
#question.update(correct_option_id: option2.id)

#Pregunta 3
question = Question.create(:content => "En programación, ¿qué es la 'recursión de cola' (tail recursion)?", :topic_id => topic4.id, :level => 3)
option1 = Option.create(:content => "Un tipo especial de recursión que utiliza una estructura de datos en forma de cola.", :question_id => question.id)
option2 = Option.create(:content => "Un enfoque de programación que utiliza ciclos en lugar de recursión.", :question_id => question.id)
option3 = Option.create(:content => "Una forma optimizada de recursión en la que la llamada recursiva es la última operación en la función.", :question_id => question.id)

option3.update(:correct => true)
#question.update(correct_option_id: option3.id)

# Obtengo todos los topics y los usuarios
users = User.all
topics = Topic.all

# Para cada usuario, crear registros relacionados en otra tabla
# Además inicializo la puntuación de cada usuario con 0 puntos
users.each do |user|
    topics.each do |topic|
        Knowledge.create(:user_id => user.id, :topic_id => topic.id, :level => 1, :correct_answers_count => 0)
    end
    user.points = 0
    user.save
end
# Cargo en cada topic la cantidad de preguntas que hay en cada nivel
# (Dadas las nuevas validaciones, sí o sí, hay que crear el tema con una cantidad de respuestas válida)
# (El código que sigue no daña nada pero es innenecesario)

#topics.each do |topic|
#  topic.update(amount_questions_L1: 3,
#  	           amount_questions_L2: 3,
#  	           amount_questions_L3: 3)
#end