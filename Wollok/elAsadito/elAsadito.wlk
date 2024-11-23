class Persona {

  var property posicion = []
  const property elementos = []
  const property comidas = [] 
  var property criterioParaPasar = normal
  var property criterioDeEleccionComidas = dietetico

  method mePodesPasar(elemento,quienLoPide) {
    self.validacionDeElemento(elemento)
    criterioParaPasar.accionesAlPasarElementos(self,quienLoPide,elemento)
  }

  method validacionDeElemento(elemento) {
    if(!self.tengoElElemento(elemento))
      throw new DomainException(message="No tienes el elemento pedido busca el" + elemento)
  }

  method tengoElElemento(elemento) = elementos.contains(elemento) 

  method agregarElementos(elementosParaAgregar) = elementos.addAll(elementosParaAgregar)
  method quitarElemento(elementosParaQuitar) = elementos.removeAll(elementosParaQuitar)
  
  method cambiarPosicion(otraPersona) {
    const nuevaPosicion = otraPersona.posicion()
    otraPersona.posicion(self.posicion())
    posicion=nuevaPosicion
  }

  method primerElemento() = elementos.first() 
  method cantidadDeElementos() = elementos.size() 

  method comer(comida){
    if (criterioDeEleccionComidas.aceptaComer(comida)) comidas.add(comida)
  }

  method estaPipon() = comidas.any({comida =>comida.esPesada()})

  method comioAlgo() = comidas.isEmpty() 

  method laPasaBien() = self.comioAlgo() and self.laPasaBienPersonalmente()

  method laPasaBienPersonalmente()

}


object osky inherits Persona {
  override method laPasaBienPersonalmente() = true
}

object moni inherits Persona {

  // Posicion es una lista en donde el primer elemento es x y el segundo elemento es 1 
  override method laPasaBienPersonalmente() = posicion.contains([1,1])
}

object facu inherits Persona {

  override method laPasaBienPersonalmente() = comidas.any({comida =>comida.esCarne()})
}

object vero inherits Persona {

  override method laPasaBienPersonalmente() = self.cantidadDeElementos()<3

}



class CriterioDeCambio {

  method accionesAlPasarElementos(quienLoDa,quienLoRecibe,elemento){
    quienLoDa.quitarElementos(self.elementosQuePasa(quienLoDa,elemento))
    quienLoRecibe.agregarElementos(self.elementosQuePasa(quienLoDa,elemento))
  }

  method elementosQuePasa(quienLoDa,elemento) 

}


object sordo inherits CriterioDeCambio {

  override method elementosQuePasa(quienLoDa,elemento) = [quienLoDa.primerElemento()] 
}

object dejameTranquilo inherits CriterioDeCambio {

  override method elementosQuePasa(quienLoDa,elemento) = quienLoDa.elementos()
}
object charlatan {
  method accionesAlPasarElementos (quienLoDa,quienLoRecibe,elemento) {
    quienLoDa.cambiarPosicion(quienLoRecibe)
  } 
}

object normal inherits CriterioDeCambio {
  
  override method elementosQuePasa(quienLoDa,elemento) = [elemento] 
}

class Comida {
  const property esCarne = true
  const property calorias = 250

  method esPesada() = calorias>500 
}


object vegetariano{
  method aceptaComer(comida) = !comida.esCarne() 
}

object dietetico {
  var property limiteEstablecido = 500 

  method aceptaComer(comida) = comida.calorias()<limiteEstablecido
}

class Alternado {
  var property quiero = true 

  method aceptaComer(comida) {
    quiero = !quiero
    return !quiero
  }  
}

class Combinacion {
  const property criteriosDeEleccion = []

  method agregarCriterios(criterios) = criteriosDeEleccion.addAll(criterios) 
  method aceptaComer(comida) = criteriosDeEleccion.all({criterio => criterio.aceptaComer(comida)})

}


// Se utilizo polimorfismo en las distintas personas ya que todos entiende el mensaje de si la estaPasando bien personalmente
// Tambien se uso en los criterios de eleccion de comidas ya que todos los criterios entienden el mensaje de si aceptaComer

/* 
Se uso herencia en los criterios de pasar un elemento al hacer inherits estamos heredando todos los metodos de la clase abstracta criterioDeCambios
exeptuando los charlatanes que tienen un comportamiento diferente al pasar el elemento
*/

/*
Composicion lo usamos al definir en una persona los criterios que tiene para la eleccion de comidas y de como pasa un elemento
*/