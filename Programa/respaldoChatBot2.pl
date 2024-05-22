% Predicado para el saludo inicial
saludar :-
    write("¡Hola! Soy tu chatbot. ¿En qué puedo ayudarte hoy?"), nl,
    write("Puedes pedirme que realice operaciones aritméticas (suma, resta, multiplicación, división) o que manipule listas."), nl,
    write("Por ejemplo, puedes escribir 'suma 5 3' o 'longitud lista 1 2 3 4'."), nl.

% Predicado para verificar si la entrada es una despedida
despedida(Entrada) :-
    sub_atom(Entrada, _, _, _, 'adios') ; % Verifica si contiene 'adios'
    sub_atom(Entrada, _, _, _, 'hasta luego') ; % Verifica si contiene 'hasta luego'
    sub_atom(Entrada, _, _, _, 'adiós mi lindo chatbot'). % Verifica si contiene 'adiós mi lindo chatbot'

% Predicado para realizar operaciones aritméticas
operacion_aritmetica(suma, [X, Y], Resultado) :- Resultado is X + Y.
operacion_aritmetica(resta, [X, Y], Resultado) :- Resultado is X - Y.
operacion_aritmetica(multiplicacion, [X, Y], Resultado) :- Resultado is X * Y.
operacion_aritmetica(division, [X, Y], Resultado) :- Y =\= 0, Resultado is X / Y.
operacion_aritmetica(modulo, [X, Y], Resultado) :- Resultado is X mod Y.
operacion_aritmetica(potencia, [X, Y], Resultado) :- Resultado is X ** Y.
operacion_aritmetica(raiz, [X], Resultado) :- Resultado is sqrt(X).

% Predicado para extraer los argumentos de una entrada
extraer_argumentos(Entrada, Argumentos) :-
    atomic_list_concat(ListaPalabras, ' ', Entrada),
    include(atom_is_number, ListaPalabras, ArgumentosAtom),
    maplist(atom_number, ArgumentosAtom, Argumentos).

% Verifica si un átomo representa un número
atom_is_number(Atom) :-
    atom_number(Atom, _).

% Predicado principal para la conversación
conversar :-
    saludar,
    repeat,
        write("Tu: "),
        read_line_to_string(user_input, Entrada),
        (   despedida(Entrada) -> ! ;
            sub_atom(Entrada, _, _, _, 'suma') -> 
                extraer_argumentos(Entrada, Argumentos),
                operacion_aritmetica(suma, Argumentos, Resultado),
                write("Chatbot: El resultado es "), write(Resultado), nl ;
            sub_atom(Entrada, _, _, _, 'resta') -> 
                extraer_argumentos(Entrada, Argumentos),
                operacion_aritmetica(resta, Argumentos, Resultado),
                write("Chatbot: El resultado es "), write(Resultado), nl ;
            sub_atom(Entrada, _, _, _, 'multiplicacion') -> 
                extraer_argumentos(Entrada, Argumentos),
                operacion_aritmetica(multiplicacion, Argumentos, Resultado),
                write("Chatbot: El resultado es "), write(Resultado), nl ;
            sub_atom(Entrada, _, _, _, 'division') -> 
                extraer_argumentos(Entrada, Argumentos),
                operacion_aritmetica(division, Argumentos, Resultado),
                write("Chatbot: El resultado es "), write(Resultado), nl ;
            sub_atom(Entrada, _, _, _, 'modulo') -> 
                extraer_argumentos(Entrada, Argumentos),
                operacion_aritmetica(modulo, Argumentos, Resultado),
                write("Chatbot: El resultado es "), write(Resultado), nl ;
            sub_atom(Entrada, _, _, _, 'potencia') -> 
                extraer_argumentos(Entrada, Argumentos),
                operacion_aritmetica(potencia, Argumentos, Resultado),
                write("Chatbot: El resultado es "), write(Resultado), nl ;
            sub_atom(Entrada, _, _, _, 'raiz') -> 
                extraer_argumentos(Entrada, Argumentos),
                operacion_aritmetica(raiz, Argumentos, Resultado),
                write("Chatbot: El resultado es "), write(Resultado), nl ;
            write("Chatbot: Lo siento, aún no sé cómo responder a eso."), nl
        ),
        fail. % Fuerza el fallo para que repeat continúe
