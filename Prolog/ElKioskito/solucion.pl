% Punto 1

%turno(Atiende,Dia,HoraIncio,HoraFinal).
%turnos de Dodain
turno(dodain,lunes,9,15).
turno(dodain,miercoles,9,15).
turno(dodain,viernes,9,15).
%turnos de Lucas
turno(lucas,martes,10,20).
%turnos de JuanC
turno(juanC,sabados,18,22).
turno(juanC,domingos,18,22).
%turnos de JuanFds 
turno(juanFds,jueves,10,20).
turno(juanFds,viernes,12,20).
%turnos de leoC
turno(leoC,lunes,14,18).
turno(leoC,miercoles,14,18).
%turnos de martu
turno(martu,miercoles,23,24).

%turnos de vale
turno(vale,Dias,HoraIncio,HoraFinal):- mismoHorarioQue(vale,Persona),turno(Persona,Dias,HoraIncio,HoraFinal).

mismoHorarioQue(vale,dodain).
mismoHorarioQue(vale,juanC).

% nadie hace el mismo horario que leoC
% maiu está pensando si hace el horario de 0 a 8 los martes y miércoles

% Por principio de universo cerrado -> no hace falta agregar a nuestra base de conocimiento lo que se presume falso,
% por lo tanto no se agregan lo pensado por maiu y que nadie hace el mismo horario que leoC

% Punto 2
quienAtiende(Dia,Hora,Persona):- %diasQueSeAtiende(Dia),empleados(Persona),
   turno(Persona,Dia,HoraIncio,HoraFinal), %Hora >= HoraIncio, Hora =< HoraFinal.
   between(HoraIncio, HoraFinal, Hora).
    

diasQueSeAtiende(Dia):- distinct(Dia,turno(_,Dia,_,_)).
empleados(Persona):- distinct(Persona,turno(Persona,_,_,_)).

% Punto 3

foreverAlone(Dia,Horario,Persona):- empleados(Persona), 
    quienAtiende(Dia,Horario,Persona),
    not((quienAtiende(Dia,Horario,OtraPersona),OtraPersona \= Persona)).

% Punto 4

posibilidadDeAtencion(Dia,Personas):- 
    findall(Persona , distinct(Persona,quienAtiende(Dia,_,Persona)) , PersonasPosibles),
    combinaciones(PersonasPosibles,Personas).

% Paso base en caso de que ambas listas esten vacias.
combinaciones([],[]).

% ?? No importa el primer elemento de la lista le pasa la cola de Personas Posibles.ç
% Modulo 7 Explosion combinatoria puedo decidir que un elemento no entre en la lista
combinaciones([ _ | PersonasPosibles],Personas):-
    combinaciones(PersonasPosibles,Personas).

% Unifica el primer elemento de personas posibles con el primer elemento de la lista a "mostrar"
% luego se llama a si misma pasandole la cola de ambas listas
combinaciones([Persona | PersonasPosibles],[Persona | Personas]):-
    combinaciones(PersonasPosibles,Personas).



% fiandall predicado de orden superior que genera una lista de soluciones posibles a partir de satisfacer otro predicado
% recursividad llamadas recursivas de un predicado y mecanismo de backtracking de prolog que permite buscar/encontrar todas las soluciones posibles