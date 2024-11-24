class Persona{
  const suenios = []
  const carrerasQueQuiereEstudiar = []
  const carrerasHechas = []
  const lugaresVisitados = []
  var cantidadDeHijos = 0
  var felicidonios
  var tipoDePersona

  method cumplirSuenio (suenio){
    self.validarSueniosPendiente(suenio)
    suenio.cumplir(self)
  }

  method cumplirSuenioElegido(){
    const suenioElegido = tipoDePersona.suenioElegido(self.sueniosPendientes())
    self.cumplirSuenio(suenioElegido)
  }



  method validarSueniosPendiente(suenio) {
    if(self.sueniosPendientes().contains(suenio))
     throw new DomainException(message="El suenio :"+suenio+"ya esta cumplido")
  }
  
  method sueniosPendientes() = suenios.filter({suenio=>suenio.estaPendiente()})


  method agregarHijos(nuevosHijos) {
    cantidadDeHijos += nuevosHijos
  }

  method tieneHijos() = cantidadDeHijos > 0 

  method quiereEstudiar(carrera) = carrerasQueQuiereEstudiar.contains(carrera)
  method seRecibio(carrera) = carrerasHechas.contains(carrera) 

  method completarCarrera(carrera)= carrerasHechas.add(carrera)

  method visitarLugar(lugar) = lugaresVisitados.add(lugar)

  method agregarFelicidonios(cantidadFelicidonios) {
    felicidonios += cantidadFelicidonios
  } 

}

class Suenio {
  var cumplido = false

  method validar(persona)

  method cumplir(persona) {
    self.validar(persona)
    self.realizarSuenio(persona)
    self.cumplirSuenio()
    persona.agregarFelicidonios(self.felicidonios())
  }

  method cumplirSuenio() {
    cumplido = true
  }

  method felicidonios()

  method estaPendiente() = !cumplido

  method realizarSuenio(persona) 

}

class SuenioSimple inherits Suenio {
  var felicidonios = 0

  override method felicidonios() = felicidonios 
}

class SuenioMultiple inherits Suenio{
  const suenios = []
  
  override method felicidonios() = suenios.sun({suenio=>suenio.felicidonios()})

  override method validar(persona) {
    suenios.forEach({suenio=>suenio.validar(persona)})
  } 

  override method realizarSuenio(persona){
    suenios.forEach({suenio=>suenio.realizarSuenio(persona)})
  }
}

class Recibirse inherits SuenioSimple{
  const nombreCarrera

  override method validar(persona){
    self.validarSiQuiereEstudiar(persona)
    self.validarSiYaSeRecibio(persona)
    
  }

  override method realizarSuenio(persona){
    persona.completarCarrera(nombreCarrera)
  }

  method validarSiQuiereEstudiar(persona) {
    if(!persona.quiereEstudiar(nombreCarrera))
      throw new DomainException(message="Usted no quiere recibierse de"+nombreCarrera)
  }

  method validarSiYaSeRecibio(persona) {
    if(persona.seRecibio(nombreCarrera))
      throw new DomainException(message="Usted ya se recibio de"+ nombreCarrera)
  }
}

object tenerHijo inherits SuenioSimple{
  const hijosQueQuiere = 0

  override method validar(persona) {
  }

  override method realizarSuenio(persona) {
    persona.agregarHijos(hijosQueQuiere)
  }
}

class AdoptarHijo inherits SuenioSimple {
  const hijosAAdoptar = 0
  
  override method validar(persona) {
    if(persona.tieneHijos())
     throw new DomainException(message="Usted no puede adoptar si ya tiene hijos")
  }

  override method realizarSuenio(persona) {
    persona.agregarHijos(hijosAAdoptar)  
  }
}

class Viajar inherits SuenioSimple {
  const lugar

  override method validar(persona) {
  }

  override method realizarSuenio(persona){
    persona.visitarLugar(lugar)
  }
}

object realista {
  method suenioElegido(sueniosPendientes) {
    sueniosPendientes.max({suenio=>suenio.felicidonios()})
  }
}

object alocado{
  method suenioElegido(sueniosPendientes){
    sueniosPendientes.anyOne()
  }
}

object obsesivo {
  method suenioElegido(sueniosPendientes){
    sueniosPendientes.first()
  }
}



