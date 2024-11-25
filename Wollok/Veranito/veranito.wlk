// Punto 1
class Lugar {
  const nombre

  method cantidadDeLetras() = nombre.size()

  method esDivertido() = self.cantidadDeLetras().even() && self.condicionesDeDiversion()
  
  method condicionesDeDiversion() 
  method esTranquilo()
  method esRaro()= self.cantidadDeLetras()>10
}

class Ciudad inherits Lugar{
  const cantidadHabitantes
  const atracciones = []
  const decibeles

  override method condicionesDeDiversion() = atracciones.size()>3 and cantidadHabitantes>100000

  override method esTranquilo() = decibeles<20

}

class Pueblo inherits Lugar {
  const extension
  const fechaFundacion
  const provincia

  method perteneceAlLitoral() = ["Entre Rios","Corrientes","Misiones"].contains(provincia)
  method esAntiguo() = fechaFundacion.year() 

  override method condicionesDeDiversion() = self.esAntiguo() or self.perteneceAlLitoral()

  override method esTranquilo() = provincia == "La Pampa"
}

class Balneario inherits Lugar {
  const metrosDePlaya
  const marPeligroso 
  const tienePeatonal

  override method condicionesDeDiversion() = metrosDePlaya>300 and marPeligroso 

  override method esTranquilo() = !tienePeatonal
}

// Punto 2
class Persona {
  var property preferencia
  var property presupuestoMaximo

  method eligeViajarA(lugar)=preferencia.leGusta(lugar)
  method puedePagar(monto) = presupuestoMaximo >= monto 

  method leGustaElRecorrido(lugares) = lugares.all({lugar=>self.eligeViajarA(lugar)}) 

}

object tranquilidad {

  method leGusta(lugar) = lugar.esTranquilo()
}

object diversion {
  
  method leGusta(lugar) = lugar.esDivertido() 
}

object raros {
  
  method leGusta(lugar) = lugar.esRaro() 
}

class Multiple {
  const preferencias = []

  method leGusta(lugar) = preferencias.any({preferencia=>preferencia.leGusta(lugar)}) 
}

class Tour {
  const lugaresAVisitar = []
  const integrantes = []
  const listaDeEspera = []
  const costoTour
  const cuposTotales
  const fechaSalida

  method agregarAlTour(persona) {
    self.validarPresupuesto(persona)
    self.validarSiLeGustan(persona)
    //self.validacionDeCupos(persona)
    if (!self.estaConfirmado())
      throw new DomainException(message="No hay lugares disponibles en el tour")
    integrantes.add(persona)
  }

  method validarPresupuesto(persona) {
    if (!persona.puedePagar(costoTour))
    throw new DomainException(message="Usted no esta dispuesto a pagar " + costoTour)
  }

  method validarSiLeGustan(persona) {
    if (!persona.leGustaElRecorrido(lugaresAVisitar))
     throw new DomainException(message="Hay lugares a los que no le gustaria ir")
  }

  method cantidadDeIntegrantes() = integrantes.size() 
  method estaConfirmado() = self.cantidadDeIntegrantes()<cuposTotales

  method validacionDeCupos(persona) {
    if (!self.estaConfirmado())
      throw new DomainException(message="El tour ya esta confirmado,se lo agregara a una lista de espera")
      self.agregarAListaDeEspera(persona)    
  }

  method agregarAListaDeEspera(persona) {
    listaDeEspera.add(persona)
  }

  method bajarPersona(persona) {
    integrantes.remove(persona)
    self.agregarPersonaEnListaDeEspera()
  }

  method agregarPersonaEnListaDeEspera() {
    const nuevoIntegrante = listaDeEspera.first()
    listaDeEspera.remove(nuevoIntegrante)
    integrantes.add(nuevoIntegrante)
  }


  method montoTotal() = costoTour * self.cantidadDeIntegrantes() 

  method esDeEsteAnio() = fechaSalida.year() == new Date().year() 

}

object reportes {
  const tours = []

  method montoTotal() =self.toursDeEsteAnio().sum({tour=>tour.montoTotal()})  

  method pendientesDeConfirmacion () = tours.filter({tour=>!tour.estaConfirmado()})
  method toursDeEsteAnio() = tours.filter({tour=>tour.esDeEsteAnio()})
}
