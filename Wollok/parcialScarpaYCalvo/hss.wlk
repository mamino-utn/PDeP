class Panelista {
  var property puntosEstrella = 0

  method darRemateGracioso(tematica) 

  method sumarPuntosEstrella(puntos){
    puntosEstrella += puntosEstrella
  } 

  method opinarDeFarandula(cantidaInvolucrados) {
     self.opinarSinSaber()
  }

  method opinarDeDeportes() {
    self.opinarSinSaber()
  }

  method opinarSinSaber() {
    self.sumarPuntosEstrella(1)
  }

  method opinar(tematica) {
    tematica.opinionPanelista(self)
  } 

  method hablarSobreTematica(tematica){
    self.opinar(tematica)
    self.darRemateGracioso(tematica)
  }

}


object celebridad inherits Panelista {

  override method darRemateGracioso(tematica) {
    self.sumarPuntosEstrella(3)
  }

  override method opinarDeFarandula(cantidadDeInvolucrados){
    self.sumarPuntosEstrella(cantidadDeInvolucrados)
  }
}

class Colorado inherits Panelista {
  var puntosDeGracia = 0

  override method darRemateGracioso(tematica) {
    self.sumarPuntosEstrella(puntosDeGracia*0.2)
    self.sumarPuntosDeGracia(1)
  }

  method sumarPuntosDeGracia(puntos) {
    puntosDeGracia *= puntos
  }
}

object coloradoConPeluca inherits Colorado {

  override method darRemateGracioso(tematica) {
    super(tematica)
    self.sumarPuntosEstrella(1)
  }
}

object viejo inherits Panelista {
  
  override method darRemateGracioso(tematica) {
    self.sumarPuntosEstrella(tematica.cantidadPalabrasDelTitulo())
  }

}

object deportivo inherits Panelista {
  override method darRemateGracioso(tematica){

  }

  method opininar(tematica) {
    tematica.opinionPanelista(self)
  }

  override method opinarDeDeportes() {
    self.sumarPuntosEstrella(5)
  }
}

class Tematica {
  const property titulo= ""

  method opinionPanelista(unPanelista) {
    unPanelista.sumarPuntosEstrella(1)
  }

  method esInteresante()  = false 

  method cantidadPalabrasDelTitulo() = titulo.words().size()
}

class Deportiva inherits Tematica {
  
  override method opinionPanelista(unPanelista) {
    unPanelista.opinaDeDeporte()
  }

  override method esInteresante() = titulo.contains("Messi")
}

class Farandula inherits Tematica {
  const cantidadDeInvolucrados

  override method opinionPanelista(unPanelista) {
    unPanelista.opinaDeFarandula(cantidadDeInvolucrados)
  }

  override method esInteresante() = cantidadDeInvolucrados >= 3
}

class Filosofica inherits Tematica {

  override method esInteresante() = self.cantidadPalabrasDelTitulo() > 20

}

class Mix inherits Tematica {
  const tematicas = []

  override method titulo() = tematicas.map({tematica=>tematica.titulo()}).join(" ")

  override method esInteresante() = tematicas.any({tematica=>tematica.esInteresante()})

  override method opinionPanelista(panelista) {
    tematicas.forEach({tematica=>tematica.opinionPanelista(panelista)})
  }
}

// Como las tematicas moral y ecomica no tienen un comportamiento exclusivo y tematica no es abstracta seran instancias de esta

class Emision {
  const panelistas = []
  const tematicasAHablar = []
  var emitido = false

  method cantidadPanelistas() = panelistas.size() 
  method haySuficientesPanelistas() = self.cantidadPanelistas()>=2

  method tematicasInteresantes() = tematicasAHablar.filter({tematica=>tematica.esInteresante()}) 
  method cantidadDeTematicasInteresantes() = self.tematicasInteresantes().size() 
  method cantidadTematicas() = tematicasAHablar.size() 

  method lasTematicasSonInteresantes()= self.cantidadDeTematicasInteresantes() >= self.cantidadTematicas()/2
  
  method sePuedeEmitir() = self.haySuficientesPanelistas() and self.lasTematicasSonInteresantes()

  method emitir() {
    if(!self.sePuedeEmitir())
      throw new DomainException(message="El programa no se puede emitir")
    tematicasAHablar.forEach({tematica=>self.hablarSobreTematica(tematica)})
    emitido=true
  } 

  method hablarSobreTematica(tematica) {
    panelistas.forEach({panelista=>panelista.hablaSobreTematica(tematica)})
  }

  method validacionDeEmision() {
    if (!emitido){
      throw new DomainException(message="El programa todavia no fue emitido")
    }
  } 

  method panelistaEstrella(){
    self.validacionDeEmision()
    panelistas.max({panelista=>panelista.puntosEstrella()})
  }

}