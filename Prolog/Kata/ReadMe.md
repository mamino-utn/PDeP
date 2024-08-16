# Kata Logico

### Enunciado
https://docs.google.com/document/d/1ImLKt1-LiyNk_KgOcc9OHQZ1TefAqwgvVIjZS9k87n8/edit

### Corrección Profesor
Hola @mamino-utn 

```pl
toca(rodolfo,teclado).
toca(rodolfo,piano).
```
Ojo que acá está definido por extensión pero no figura la regla de negocio: Por ejemplo si agregamos que Charly aprendió en el conservatorio el [Digeridoo](https://es.wikipedia.org/wiki/Didyeridú) tenemos que agregar este elemento en ambos artistas, mientras que si se encuentra modelada la regla de negocio, al agregar un elemento el Charly, automáticamente ya figura para Rodolfo. 

#### Corrección 

toca(rodolfo,Instrumento):- toca(charly,Instrumento).