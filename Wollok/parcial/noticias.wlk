
// No hice un calendario en el parcial para los new Date repetidos :
// Resta puntos por dates repetidos seguramento ( -0.5 0 -1 Puntos)
object calendario { 

  method fechaActual() = new Date()
  method anioActual() = self.fechaActual().year()
  method diaActual() = self.fechaActual().day()
  method mesActual() = self.fechaActual().month() 

  method semanaAnterior() = self.fechaActual().minusDays(7)
}
// Punto 1 (4 Puntos) : Mios (3 o 4) Ni idea la verdad :c
class Noticia {
  const importancia 
  const property fechaPublicacion
  const property titulo
  const property desarrollo
  const periodista

  method publicar() {
    self.validacionPeriodista()
    self.validadicionEscritura()
    periodista.publicarNoticia(self)
  }

  method validadicionEscritura(){
    if(!self.cuantasPalabrasEnTitulo()>=2)
      throw new DomainException(message ="La noticia no tiene un buen titulo")
      //En esta parte use la lista generada por palabras de desarrollo :C -0.5 o -1
    if(self.desarrollo().isEmpty()){
      throw new DomainException(message ="Carece de desarrollo")
    }
  }

  method validacionPeriodista() {
    if(!periodista.cuantasNoPrefiereHoy()<2)
      throw new DomainException(message ="El periodista publico demasiadas noticia que no prefiere")
  } 

  method esCopada() = self.esImportante() and self.esReciente() and self.tomaEnCuenta()

  method esImportante() = importancia >= 8
  method sePublicoHace()  = fechaPublicacion.day() - calendario.diaActual()
  method esReciente() = self.sePublicoHace() < 3 
  method tomaEnCuenta()

  method esSensacional() = self.palabrasDelTitulo().any({palabra=>self.esEspectacular(palabra)})

  method esEspectacular(palabra) = ["espectacular","increible","grandioso"].contain(palabra)
  method palabrasDelTitulo() = titulo.words()
  method cuantasPalabrasEnTitulo() = self.palabrasDelTitulo().size()
  method primeraPalabraDelTitulo() = self.palabrasDelTitulo().first() 

  method palabrasDelDesarrollo() = desarrollo.words()
  method largoDelDesarrollo() = self.largoDelDesarrollo().size()

  method esChivo() = false 

  // Esto no lo hice asi al no tener calendario hice 
  method esDeHoy() = fechaPublicacion == calendario.fechaActual()

  method esDeLaUltimaSemana() = fechaPublicacion == calendario.semanaAnterior()
}

class Articulos inherits Noticia {
  const linksANoticias = []

  override method tomaEnCuenta() = linksANoticias.size()>=2
}

class Chivo inherits Noticia {
  const productoPromocionado
  const pagaron 

  override method tomaEnCuenta() = pagaron > 2000000
  override method esChivo()=true

}

class Reportaje inherits Noticia {
  const entrevistado

  method largoDelNombre() = entrevistado.size()
  override method tomaEnCuenta() = !self.largoDelNombre().even()
  override method esEspectacular(palabra) = super(palabra) or ["Dibu Martinez"].contain(palabra)
}

class Cobertura {
  const noticias = []

  method esCopada()= noticias.all({noticia=>noticia.esCopada()})
}

// Punto 2 (3 puntos ) : mios (1.5 o 2 con suerte)
class Periodista {
  var property preferencia = copado
  const fechaDeIngreso
  const noticiasPublicadas = []

  method eligePublicar(noticia) = preferencia.eligePublicar(noticia)
  method publicarNoticia(noticia) {
    noticiasPublicadas.add(noticia)
  }

  //Punto 3 lo hice mas o menos
  method noticiasQueNoPrefiere() = noticiasPublicadas.filter({noticia=>self.eligePublicar(noticia)})
  method noticiasNoPreferidasDeHoy() = self.noticiasQueNoPrefiere().filter({noticia=>noticia.esDeHoy()}) 

  method cuantasNoPrefiereHoy() = self.noticiasNoPreferidasDeHoy().size()

  method esPeriodistaHace() = fechaDeIngreso.year() - calendario.anioActual()

  method publicoEnLaUltimaSemana() = noticiasPublicadas.filter({noticia=>noticia.esDeLaUltimaSemana()})

}

object copado {
  method eligePublicar(noticia) = noticia.esCopada() 
}

object sensacionalista {
  method eligePublicar(noticia) = noticia.esSensacional()
}

object vago {
  //                                                    Nose si puse < o >
  method elgiePublicar(noticia) = noticia.esChivo() and noticia.largoDelDesarrollo()<100
}


// MAL un string no entiende first :(
object joseDeZer inherits Periodista(fechaDeIngreso = new Date()) {

  override method eligePublicar(noticia) = noticia.titulo().startsWith("T")

}

// Punto 3 (3 Puntos) : Mios quizas unos (1.5 o 2 con suerte)

// Punto 4 (2 Puntos) : Mios quizas (0 o 0.5 o 1 con suerte)

//Mal No existe date().week() jasjja
// Esto no lo hice asi seguramente este todo mal 
class Multimedio {
  const periodistas = []

  method periodistasNuevos() = periodistas.filter({periodista=>periodista.esPeriodistaHace()})

  method periodistasNuevosQuePublicaronLaUltimaSemana() = 
    self.periodistasNuevos().filter({periodista=>periodista.publicoEnLaUltimaSemana()}) 
}
