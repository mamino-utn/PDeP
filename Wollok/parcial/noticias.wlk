
// No hice un calendario en el parcial para los new Date repetidos :
object calendario { 

  method fechaActual() = new Date()
  method anioActual() = self.fechaActual().year()
  method diaActual() = self.fechaActual().day()
  method mesActual() = self.fechaActual().month() 

  method semanaAnterior() = self.fechaActual().minusDays(7)
}
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
      //En el parcial no use isEmpty 
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

  // Esto no lo hice asi al no tener calendario 
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

class Periodista {
  var property preferencia = copado
  const fechaDeIngreso
  const noticiasPublicadas = []

  method eligePublicar(noticia) = preferencia.eligePublicar(noticia)
  method publicarNoticia(noticia) {
    noticiasPublicadas.add(noticia)
  }

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


//En el parcial use first() pero los strings no entienden first
object joseDeZer inherits Periodista(fechaDeIngreso = new Date()) {

  override method eligePublicar(noticia) = noticia.titulo().startsWith("T")

}

//Durante el parcial no lo hice de esa forma 
class Multimedio {
  const periodistas = []

  method periodistasNuevos() = periodistas.filter({periodista=>periodista.esPeriodistaHace()})

  method periodistasNuevosQuePublicaronLaUltimaSemana() = 
    self.periodistasNuevos().filter({periodista=>periodista.publicoEnLaUltimaSemana()}) 
}
