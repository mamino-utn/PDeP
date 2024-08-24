noticia(artVandelay,articulo("Nuevo Titulo para Lloyd Braun",deportista(lloydBraun,5)),25).

noticia(elaineBenes,articulo("Primicia",farandula(jerrySeinfield,kennyBania)),16).
noticia(elaineBenes,articulo("El dólar bajó! … de un arbolito",farandula(jerrySeinfield,newman)),150).

noticia(bobSacamano,articulo("No consigue ganar ni una carrera",deportista(davidPuddy,0)),10).
noticia(bobSacamano,articulo("Cosmo Kramer encabeza las elecciones",politico(cosmoKramer,amigosDelPoder)),155).


noticia(georgeConstanza, articulo(Titulo,Personaje), Visitas):- 
    robaArticulo(georgeConstanza, Autor),
    noticia(Autor, articulo(Titulo, PersonajeOriginal),VisitasOriginal),
    personajeRobado(PersonajeOriginal,Personaje),
    visitasArticuloRobado(VisitasOriginal,PersonajeOriginal,Visitas).

robaArticulo(georgeConstanza,bobSacamano).
robaArticulo(georgeConstanza,elaineBenes).

personajeRobado(farandula(Persona,_), politico(Persona,amigosDelPoder)).
personajeRobado(Personaje,Personaje):- Personaje \= farandula(_,_).

visitasArticuloRobado(VisitasOriginal,farandula(_,_),Visitas):- Visitas is VisitasOriginal / 2.
visitasArticuloRobado(Visitas,Personaje,Visitas):- Personaje \= farandula(_,_).

% por principio de universo cerrado -> todo lo que se presume falso no se agrega a la base de conocimiento

% Punto 2 
articuloAmarrillista(Articulo):-
    articulo(Articulo),
    esAmarrillista(Articulo).

articulo(Articulo):- noticia(_,Articulo,_).

esAmarrillista(articulo("Primicia",_)).
esAmarrillista(articulo(_,Personaje)):-estaComplicado(Personaje).

estaComplicado(deportista(_,Titulos)):- Titulos < 3.
estaComplicado(farandula(_,jerrySeinfield)).
estaComplicado(politico(_,_)).

% Punto 3
% 3.1
autorNoLeImportaNada(Autor):- autor(Autor),
    forall(muyVisitada(Autor,Articulo),esAmarrillista(Articulo)).
    
muyVisitada(Autor,Articulo):- noticia(Autor,Articulo,Visitas), Visitas > 15.
autor(Autor):- distinct(Autor,noticia(Autor,_,_)).

%3.2

autorMuyOriginal(Autor):- autor(Autor),
    not((
        noticia(Autor,articulo(Titulo,_),_),
        noticia(OtroAutor,articulo(Titulo,_),_),
        Autor \= OtroAutor
    )).

%3.3

autorTuvoTraspie(Autor):-
    distinct(Autor, noticia(Autor,Articulo,_)),
    not(muyVisitada(Autor,Articulo)).

% Punto 4

edicionLoca(Articulos,Visitas):-
    findall(Articulo,articuloAmarrillista(Articulo),ArticulosPosibles),
    combinar(ArticulosPosibles,Articulos,Visitas),
    Visitas < 50.

combinar([],[],0).
combinar([Articulo|ArticulosPosibles],[Articulo|Articulos],TotalVisitas):-
    combinar(ArticulosPosibles,Articulos,TotalRestoVisitas),
    noticia(_,Articulo,CantidadVisitas),
    TotalVisitas is CantidadVisitas + TotalRestoVisitas.

combinar([_|ArticulosPosibles],Articulos,TotalVisitas):-
    combinar(ArticulosPosibles,Articulos,TotalVisitas).
