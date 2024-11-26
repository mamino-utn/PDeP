class Plataforma {
  const property juegos = []

  method juegoMasCaro() = juegos.max({juego=>juego.precio()}) 

  method cambiarTipoDeDescuentoJuego(juego,nuevoDescuento){
    if(juegos.contains(juego))
    juego.cambiarTipoDeDescuento(nuevoDescuento)
    else
      throw new DomainException(message=juego+"No esta en la plataforma")
  } 

  method validacionDeDescuento(porcentajeDescuento) {
    if(porcentajeDescuento==100){
      throw new DomainException(message="No se puede aplicar descuentos del 100%")
    }
  }


  method juegosAptosParaMenores(pais) = juegos.filter({juego=>juego.aptoParaMenores(pais)})

  method cantidadDeJuegosParaMenores(pais) = self.juegosAptosParaMenores(pais).size() 

  method promedioDePrecios(pais) = self.juegosAptosParaMenores(pais).sum({juego=>juego.precioEnMonedaPais(pais)})

  method juegosCaros() = juegos.filter({juego=>juego.comparacionPrecio(self.juegoMasCaro()*0.75)}) 

  method descuentoPorcentualParaJuegos(porcentajeDescuento){
    self.validacionDeDescuento(porcentajeDescuento)
    const juegosCaros = self.juegosCaros()
    const nuevoDescuento = new DescuentoDirecto(porcentaje=porcentajeDescuento)
    juegosCaros.forEach({juego=>juego.cambiarTipoDeDescuento(nuevoDescuento)})

  }
}


class Juego {
  const precio = 0
  var descuento = sinDescuento
  const caracteristicas = []
  const criticas = []

  method precio() = (self.calculoDeDescuento()).max(0) 

  method calculoDeDescuento() = precio - descuento.aplicarDescuento(precio)

  method cambiarTipoDeDescuento(nuevoDescuento) {
    descuento=nuevoDescuento
  } 

  method precioEnMonedaPais(pais) = pais.conversionAMonedaLocal(self.precio())

  method aptoParaMenores(pais) = !caracteristicas.any({carateristica=>pais.prohibeCaracteristica(carateristica)}) 

  method comparacionPrecios(monto){
    self.precio() > monto
  }

  method recibirCritica(critica){
    criticas.add(critica)
  }
}

class Pais {
  var conversionEnDolares
  const property caracteristicasProhibidas= []

  method prohibeCaracteristica(caracterisca) = caracteristicasProhibidas.contains(caracterisca)

  method conversionAMonedaLocal(precioEnDolares) = conversionEnDolares * precioEnDolares 

}

object sinDescuento {
  method aplicarDescuento(precioJuego) =  0
}

class DescuentoDirecto  {
  const porcentaje

  method aplicarDescuento(precioJuego) = precioJuego * (porcentaje/100) 
}

class DescuentoFijo {
  const descuentoFijo

  method precioFinal(precioJuego) = precioJuego - descuentoFijo 
  method validacionPrecioCoFinal(precioJuego)= self.precioFinal(precioJuego) > precioJuego/2

  method aplicarDescuento(precioJuego) =  if (self.validacionPrecioCoFinal(precioJuego))  descuentoFijo else 0
}

object gratuito{
  method aplicarDescuento(precioJuego) = precioJuego 
}

class Critica {
  var votacionPositiva = false
  var texto = ""
  var critico

  method critica(juego) {
    votacionPositiva = critico.votacion(juego)
    texto = critico.opinion()
  }

   method darCritica(juego) {
    self.critica(juego)
    juego.recibirCritica(self) 
   }
}


class Critico {
  var  votacion = positiva
  var property opinion = "" 

  method votacion(juego) = votacion.esPositiva() 

 
}

object positiva {
  method esPositva()= true
}

object negativa{
  method esPositva()=false
}

class Usuario inherits Critico {

  override method opinion() = if(votacion.esPositva()) "SI" else "NO"

  method cambiarVotacion() {
    votacion = !votacion
  }

}

class CriticosPagos inherits Critico{
  const juegosQueLePagaron = []
  const palabrasRandomElegidas = []

  override method opinion() = palabrasRandomElegidas.anyOne()

  override method votacion(juego) = juegosQueLePagaron.contains(juego)

  method agregarJuegoQuePago(juego) {
    juegosQueLePagaron.add(juego)
  }

  method unJuegoDejoDePagar(juego){
    juegosQueLePagaron.remove(juego)
  }
}

class CriticaDeRevista inherits Critico{
  const criticos = []

  method cantidadCriticos() = criticos.size()

  method criticosQueVotaronPositivo(juego) = criticos.filter({critico=>critico.votacion()})

  method mayoriaDeVotosPositivos(juego) = self.criticosQueVotaronPositivo(juego) > self.cantidadCriticos()
  

  override method votacion(juego) = self.mayoriaDeVotosPositivos(juego)

  override method opinion() = criticos.map({critico=>critico.opinion()}).join(" ")

  method agregarCritico(nuevoCritico) {
    criticos.add(nuevoCritico)
  }

  method eliminarCritico(critico) {
    criticos.remove(critico)
  }
}