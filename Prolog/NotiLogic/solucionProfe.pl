% Art Vandelay publicó una noticia con 25 visitas cuyo artículo es titulado
%  “Nuevo título para Lloyd Braun”, que es un deportista con 5 títulos ya ganados.
% noticia(autor, articulo (functor), visitas)
% 
noticia(artVandelay, articulo("Nuevo título para Lloyd Braun",
   deportista(lloydBraun, 5)), 25).

% Elaine Benes publicó una noticia con 16 visitas con su artículo titulado 
% “Primicia” involucrando a Jerry Seinfeld, quién tiene pica con Kenny Bania.
noticia(elaineBenes, articulo("Primicia", farandula(jerrySeinfield, kennyBania)), 16).

% También sacó una noticia muy popular de 150 visitas con el artículo titulado
% “El dólar bajó! … de un arbolito”, también del farandulero Jerry Seinfeld pero 
% en este caso con bronca contra Newman.
noticia(elaineBenes, articulo("El dólar bajó! … de un arbolito", 
  farandula(jerrySeinfield, newman)), 150).

% Bob Sacamano, un poco más modesto tiene una noticia de 10 visitas para su artículo titulado
% “No consigue ganar ni una carrera”, castigando al pobre David Puddy que tiene
% cero títulos ganados.
noticia(bobSacamano, articulo("No consigue ganar ni una carrera", 
  deportista(davidPuddy, 0)), 10).

% Bob Sacamano también tiene una gran publicación de 155 visitas donde en su
% artículo destaca al político “Cosmo Kramer encabeza las elecciones”
% perteneciente al partido los amigos del poder.
noticia(bobSacamano, articulo("Cosmo Kramer encabeza las elecciones", 
  politico(cosmoKramer, "los amigos del poder")), 155).

% George Costanza, un personaje muy audaz, roba las noticias de Bob Sacamano
% y de Elaine Benes obteniendo la misma cantidad de visitas y todas las noticias 
% de farándula las transforma en noticias de política involucrando al famoso como
% político perteneciente al partido amigos del poder, pero como la noticia es puro
% chamuyo obtiene la mitad de las visitas que la original.
% Por ejemplo, para el caso de la noticia "Primicia" de Elaine Benes, George Constanza
% obtendría 8 visitas, porque se trata de un artículo de alguien de la farándula. 
% En el caso de "No consigue ganar una carrera" de Bob Sacamano, tendría 10 visitas
% como la historia original.
noticia(georgeCostanza, articulo(Titulo, Personaje), Visitas):-
  robaArticulo(georgeCostanza, Persona),
  noticia(Persona, articulo(Titulo, PersonajeOriginal), VisitasOriginal),
  personajeRobado(PersonajeOriginal, Personaje),
  visitasDeArticuloRobado(VisitasOriginal, PersonajeOriginal, Visitas).

robaArticulo(georgeCostanza, bobSacamano).
robaArticulo(georgeCostanza, elaineBenes).

personajeRobado(farandula(Persona, _), politico(Persona, "los amigos del poder")).
personajeRobado(Personaje, Personaje):-Personaje \= farandula(_, _).

visitasDeArticuloRobado(VisitasOriginal, farandula(_, _), Visitas):-
  Visitas is VisitasOriginal / 2.
visitasDeArticuloRobado(Visitas, Personaje, Visitas):-Personaje \= farandula(_, _).

% principio de universo cerrado -> todo lo que se presume falso no se escribe

%  Punto 2
% Ahora empezamos a pensar en qué sitios de noticias podríamos publicar. 
% Entonces nos interesa saber si un artículo es amarillista. 
% Esto ocurre si el título es "Primicia" o si la persona involucrada en 
% dicha noticia está complicada. Los deportistas con menos de tres títulos, 
% los personajes de farándula que tienen problemas contra Jerry Seinfeld y
% todos los políticos están complicados.
articuloAmarillista(Articulo):-
  articulo(Articulo),
  esAmarillista(Articulo).

articulo(Articulo):-noticia(_, Articulo, _).

esAmarillista(articulo("Primicia", _)).
esAmarillista(articulo(_, Personaje)):-estaComplicado(Personaje).

estaComplicado(deportista(_, Titulos)):-Titulos < 3.
estaComplicado(farandula(_, jerrySeinfield)).
estaComplicado(politico(_, _)).

% Punto 3
% 3.1
% Si a un autor no le importa nada. 
% Esto ocurre cuando todas sus noticias que fueron muy visitadas son amarillistas. 
% Que una noticia sea muy visitada implica que tenga más de 15 visitas. 
autorNoLeImportaNada(Autor):-
  autor(Autor),
  forall(muyVisitada(Autor, Articulo), esAmarillista(Articulo)).

autor(Autor):-distinct(Autor, noticia(Autor, _, _)).

muyVisitada(Autor, Articulo):-
  noticia(Autor, Articulo, Visitas),
  Visitas > 15.

% 3.2
% Si un autor es muy original, que ocurre cuando no hay otra noticia
% que tenga el mismo título. 
autorMuyOriginal(Autor):-
  autor(Autor),
  not((
    noticia(Autor, articulo(Titulo, _), _),
    noticia(OtroAutor, articulo(Titulo, _), _),
    Autor \= OtroAutor
  )).

% 3.3
% Si un autor tuvo un traspié, es decir si tiene al menos una noticia poco visitada. 
autorTuvoTraspie(Autor):-
  distinct(Autor, noticia(Autor, Articulo, _)),
  not(muyVisitada(Autor, Articulo)).

% Punto 4
% ¡Excelente! Ahora necesitamos una Edición loca: queremos armar un resumen de
% la semana con una combinación posible de artículos amarillistas que no superen 
% las 50 visitas en total. El predicado debe ser inversible.
edicionLoca(Articulos, Visitas):-
  findall(Articulo, articuloAmarillista(Articulo), ArticulosPosibles),
  combinar(ArticulosPosibles, Articulos, Visitas),
  Visitas < 50.

combinar([], [], 0).
combinar([Articulo|ArticulosPosibles], [Articulo|Articulos], TotalVisitas):-
  combinar(ArticulosPosibles, Articulos, TotalRestoVisitas),
  noticia(_, Articulo, CantidadVisitas),
  TotalVisitas is CantidadVisitas + TotalRestoVisitas.
combinar([_|ArticulosPosibles], Articulos, TotalVisitas):-
  combinar(ArticulosPosibles, Articulos, TotalVisitas).