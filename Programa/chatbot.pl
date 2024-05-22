% D

% Hechos
chiste("¿Por qué los pájaros no usan Facebook? Porque ya tienen Twitter.").
refran("Más vale tarde que nunca.").
consejo("Organiza tu tiempo de estudio para ser más eficiente.").

% Predicado de busqueda en la BC
buscar_en_base_conocimiento(Tipo, Resultado) :-
    (Tipo == chiste -> chiste(Resultado) ;
     Tipo == refran -> refran(Resultado) ;
     Tipo == consejo -> consejo(Resultado)).

% carga hechos en un archivo
cargar_hechos :-
    consult('base_conocimiento.pl').


% guardar hechos
guardar_hechos :-
    tell('base_conocimiento.pl'),
    listing(chiste),
    listing(refran),
    listing(consejo),
    told.

% Manejo de errores
operacion_aritmetica(_, Argumentos, _) :-
    member(Arg, Argumentos),
    \+ number(Arg),
    write("Chatbot: Error, uno de los argumentos no es un número."), nl, fail.

operacion_aritmetica(division, [_, 0], _) :-
    write("Chatbot: Error, no se puede dividir por cero."), nl, fail.


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


% Operaciones con listas
% Longitud de la lista
longitud_lista(Lista, Longitud) :-
    length(Lista, Longitud).

% Concatenación de listas
concatenar_listas(Listas, Resultado) :-
    flatten(Listas, Resultado).

% Reverso de una lista
reverso_lista(Lista, Reverso) :-
    reverse(Lista, Reverso).

% Primer elemento de la lista
primero_lista([Primero|_], Primero).

% Último elemento de la lista
ultimo_lista(Lista, Ultimo) :-
    last(Lista, Ultimo).

% Máximo de una lista
maximo_lista(Lista, Maximo) :-
    max_list(Lista, Maximo).

% Mínimo de una lista
minimo_lista(Lista, Minimo) :-
    min_list(Lista, Minimo).

% N-ésimo elemento de una lista
enesimo_elemento(N, Lista, Elemento) :-
    nth1(N, Lista, Elemento).

% Verifica si un elemento existe en una lista
existe_elemento(Elemento, Lista) :-
    member(Elemento, Lista).

% Elimina un elemento de una lista
eliminar_elemento(Elemento, Lista, Resultado) :-
    delete(Lista, Elemento, Resultado).

% ******************
% Generacion de codigo para operaciones aritmeticas

generar_codigo_aritmetica(suma, Argumentos, Codigo) :-
    format(atom(Codigo), "Resultado is ~w + ~w.", Argumentos).
generar_codigo_aritmetica(resta, Argumentos, Codigo) :-
    format(atom(Codigo), "Resultado is ~w - ~w.", Argumentos).
generar_codigo_aritmetica(multiplicacion, Argumentos, Codigo) :-
    format(atom(Codigo), "Resultado is ~w * ~w.", Argumentos).
generar_codigo_aritmetica(division, Argumentos, Codigo) :-
    format(atom(Codigo), "Resultado is ~w / ~w.", Argumentos).
generar_codigo_aritmetica(modulo, Argumentos, Codigo) :-
    format(atom(Codigo), "Resultado is ~w mod ~w.", Argumentos).
generar_codigo_aritmetica(potencia, Argumentos, Codigo) :-
    format(atom(Codigo), "Resultado is ~w ** ~w.", Argumentos).
generar_codigo_aritmetica(raiz, [X], Codigo) :-
    format(atom(Codigo), "Resultado is sqrt(~w).", [X]).



%**********
% Generacion de codigo para operaciones con listas

generar_codigo_lista(longitud, [Lista], Codigo) :-
    format(atom(Codigo), "longitud_lista(~w, Longitud).", [Lista]).
generar_codigo_lista(concatenar, Listas, Codigo) :-
    format(atom(Codigo), "concatenar_listas(~w, Resultado).", [Listas]).
generar_codigo_lista(reverso, [Lista], Codigo) :-
    format(atom(Codigo), "reverso_lista(~w, Reverso).", [Lista]).
generar_codigo_lista(primero, [Lista], Codigo) :-
    format(atom(Codigo), "primero_lista(~w, Primero).", [Lista]).
generar_codigo_lista(ultimo, [Lista], Codigo) :-
    format(atom(Codigo), "ultimo_lista(~w, Ultimo).", [Lista]).
generar_codigo_lista(maximo, [Lista], Codigo) :-
    format(atom(Codigo), "maximo_lista(~w, Maximo).", [Lista]).
generar_codigo_lista(minimo, [Lista], Codigo) :-
    format(atom(Codigo), "minimo_lista(~w, Minimo).", [Lista]).
generar_codigo_lista(enesimo, [N, Lista], Codigo) :-
    format(atom(Codigo), "enesimo_elemento(~w, ~w, Elemento).", [N, Lista]).
generar_codigo_lista(existe, [Elemento, Lista], Codigo) :-
    format(atom(Codigo), "existe_elemento(~w, ~w).", [Elemento, Lista]).
generar_codigo_lista(eliminar, [Elemento, Lista], Codigo) :-
    format(atom(Codigo), "eliminar_elemento(~w, ~w, Resultado).", [Elemento, Lista]).


%***********
% Predicado principal para la conversación
conversar :-
    saludar,
    repeat,
        write("Tu: "),
        read_line_to_string(user_input, Entrada),
        (   despedida(Entrada) -> ! ;
            procesar_entrada(Entrada),
            fail
        ).

procesar_entrada(Entrada) :-
    (   
        % Operaciones aritméticas
        sub_atom(Entrada, _, _, _, 'suma') -> 
            extraer_argumentos(Entrada, Argumentos),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_aritmetica(suma, Argumentos, Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                operacion_aritmetica(suma, Argumentos, Resultado),
                write("Chatbot: El resultado es "), write(Resultado), nl) ;
        sub_atom(Entrada, _, _, _, 'resta') -> 
            extraer_argumentos(Entrada, Argumentos),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_aritmetica(resta, Argumentos, Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                operacion_aritmetica(resta, Argumentos, Resultado),
                write("Chatbot: El resultado es "), write(Resultado), nl) ;
        sub_atom(Entrada, _, _, _, 'multiplicacion') -> 
            extraer_argumentos(Entrada, Argumentos),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_aritmetica(multiplicacion, Argumentos, Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                operacion_aritmetica(multiplicacion, Argumentos, Resultado),
                write("Chatbot: El resultado es "), write(Resultado), nl) ;
        sub_atom(Entrada, _, _, _, 'division') -> 
            extraer_argumentos(Entrada, Argumentos),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_aritmetica(division, Argumentos, Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                operacion_aritmetica(division, Argumentos, Resultado),
                write("Chatbot: El resultado es "), write(Resultado), nl) ;
        sub_atom(Entrada, _, _, _, 'modulo') -> 
            extraer_argumentos(Entrada, Argumentos),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_aritmetica(modulo, Argumentos, Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                operacion_aritmetica(modulo, Argumentos, Resultado),
                write("Chatbot: El resultado es "), write(Resultado), nl) ;
        sub_atom(Entrada, _, _, _, 'potencia') -> 
            extraer_argumentos(Entrada, Argumentos),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_aritmetica(potencia, Argumentos, Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                operacion_aritmetica(potencia, Argumentos, Resultado),
                write("Chatbot: El resultado es "), write(Resultado), nl) ;
        sub_atom(Entrada, _, _, _, 'raiz') -> 
            extraer_argumentos(Entrada, Argumentos),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_aritmetica(raiz, Argumentos, Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                operacion_aritmetica(raiz, Argumentos, Resultado),
                write("Chatbot: El resultado es "), write(Resultado), nl) ;

        % Operaciones con listas
        sub_atom(Entrada, _, _, _, 'longitud') -> 
            extraer_lista(Entrada, Lista),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_lista(longitud, [Lista], Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                longitud_lista(Lista, Resultado),
                write("Chatbot: La longitud de la lista es "), write(Resultado), nl) ;
        sub_atom(Entrada, _, _, _, 'concatenar') -> 
            extraer_listas(Entrada, Listas),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_lista(concatenar, Listas, Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                concatenar_listas(Listas, Resultado),
                write("Chatbot: La lista concatenada es "), write(Resultado), nl) ;
        sub_atom(Entrada, _, _, _, 'reverso') -> 
            extraer_lista(Entrada, Lista),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_lista(reverso, [Lista], Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                reverso_lista(Lista, Resultado),
                write("Chatbot: La lista en reverso es "), write(Resultado), nl) ;
        sub_atom(Entrada, _, _, _, 'primero') -> 
            extraer_lista(Entrada, Lista),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_lista(primero, [Lista], Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                primero_lista(Lista, Resultado),
                write("Chatbot: El primer elemento es "), write(Resultado), nl) ;
        sub_atom(Entrada, _, _, _, 'ultimo') -> 
            extraer_lista(Entrada, Lista),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_lista(ultimo, [Lista], Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                ultimo_lista(Lista, Resultado),
                write("Chatbot: El último elemento es "), write(Resultado), nl) ;
        sub_atom(Entrada, _, _, _, 'maximo') -> 
            extraer_lista(Entrada, Lista),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_lista(maximo, [Lista], Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                maximo_lista(Lista, Resultado),
                write("Chatbot: El elemento máximo es "), write(Resultado), nl) ;
        sub_atom(Entrada, _, _, _, 'minimo') -> 
            extraer_lista(Entrada, Lista),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_lista(minimo, [Lista], Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                minimo_lista(Lista, Resultado),
                write("Chatbot: El elemento mínimo es "), write(Resultado), nl) ;
        sub_atom(Entrada, _, _, _, 'enesimo') -> 
            extraer_elemento_y_lista(Entrada, N, Lista),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_lista(enesimo, [N, Lista], Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                enesimo_elemento(N, Lista, Resultado),
                write("Chatbot: El elemento en la posición "), write(N), write(" es "), write(Resultado), nl) ;
        sub_atom(Entrada, _, _, _, 'existe') -> 
            extraer_elemento_y_lista(Entrada, Elemento, Lista),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_lista(existe, [Elemento, Lista], Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                (existe_elemento(Elemento, Lista) -> 
                    write("Chatbot: El elemento "), write(Elemento), write(" existe en la lista."), nl ;
                    write("Chatbot: El elemento "), write(Elemento), write(" no existe en la lista."), nl)) ;
        sub_atom(Entrada, _, _, _, 'eliminar') -> 
            extraer_elemento_y_lista(Entrada, Elemento, Lista),
            (   sub_atom(Entrada, _, _, _, 'codigo') -> 
                generar_codigo_lista(eliminar, [Elemento, Lista], Codigo),
                write("Chatbot: El código Prolog es: "), write(Codigo), nl ;
                eliminar_elemento(Elemento, Lista, Resultado),
                write("Chatbot: La lista después de eliminar el elemento es "), write(Resultado), nl) ;

        % Saludo y despedida
        (sub_atom(Entrada, _, _, _, 'adiós') ; sub_atom(Entrada, _, _, _, 'hasta luego')) -> 
            write("Chatbot: Hasta luego, ¡cuídate!"), nl, halt ;

        % Otros temas triviales
        sub_atom(Entrada, _, _, _, 'chiste') -> 
            buscar_en_base_conocimiento(chiste, Chiste),
            write("Chatbot: "), write(Chiste), nl ;
        sub_atom(Entrada, _, _, _, 'refran') -> 
            buscar_en_base_conocimiento(refran, Refran),
            write("Chatbot: "), write(Refran), nl ;
        sub_atom(Entrada, _, _, _, 'consejo') -> 
            buscar_en_base_conocimiento(consejo, Consejo),
            write("Chatbot: "), write(Consejo), nl ;

        % No se entiende la entrada
        write("Chatbot: Lo siento, no entiendo tu solicitud. Por favor, inténtalo de nuevo."), nl
    ).


% Predicados auxiliares para extraer listas y elementos de la entrada
extraer_lista(Entrada, Lista) :-
    sub_atom(Entrada, _, _, A, 'lista'),
    sub_atom(Entrada, A, _, 0, ArgumentosAtom),
    atomic_list_concat(Argumentos, ' ', ArgumentosAtom),
    maplist(atom_number, Argumentos, Lista).

extraer_listas(Entrada, Listas) :-
    sub_atom(Entrada, _, _, A, 'listas'),
    sub_atom(Entrada, A, _, 0, ArgumentosAtom),
    atomic_list_concat(Argumentos, ' ', ArgumentosAtom),
    findall(Lista, (member(SubArgumento, Argumentos), atomic_list_concat(SubArgumentos, ',', SubArgumento), maplist(atom_number, SubArgumentos, Lista)), Listas).

extraer_elemento_y_lista(Entrada, Elemento, Lista) :-
    sub_atom(Entrada, _, _, A, 'elemento'),
    sub_atom(Entrada, A, _, 0, ArgumentosAtom),
    atomic_list_concat(Argumentos, ' ', ArgumentosAtom),
    maplist(atom_number, Argumentos, [Elemento|Lista]).



inicio :-
    cargar_hechos,
    write("Chatbot: ¡Hola! ¿En qué puedo ayudarte hoy?"), nl,
    repeat,
    read(Entrada),
    procesar_entrada(Entrada),
    (sub_atom(Entrada, _, _, _, 'adiós') ; sub_atom(Entrada, _, _, _, 'hasta luego')) -> 
    guardar_hechos, halt.
