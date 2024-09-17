object tom {
  var energia = 100
  const energiaBaseQueAumentaAlComer = 12
  const velocidadBase = 5
  const coeficienteDeEnergiaAlCorrer = 0.5
  const coeficienteDeEnergiaParaVelocidad = 10
  
  method comer(unRaton) {
    energia += self.energiaPorComer(unRaton)
  }
  
  method energiaPorComer(unRaton) = (energiaBaseQueAumentaAlComer + unRaton.peso()) + self.extraPorRaton(unRaton)
  
  method extraPorRaton(unRaton) = if (unRaton.estaFeliz(self)) 10 else 0
  
  method velocidad() = velocidadBase + (energia / coeficienteDeEnergiaParaVelocidad)
  
  method correr(segundos) {
    const metros = self.velocidad() * segundos
    energia -= self.energiaPorCorrer(metros)
  }
  
  method energiaPorCorrer(metros) = metros * coeficienteDeEnergiaAlCorrer
  
  method meConvieneComerRatonA(unRaton, unaDistancia) = self.energiaPorComer(unRaton) > self.energiaPorCorrer(unaDistancia)
}

object jerry {
  const elementosIngeridos = ["churrasco", "pan", "ensalada"]
  
  method comer(alimento) {
    elementosIngeridos.add(alimento)
  }
  
  method peso() = 30 + self.pesoExtra()
  
  method pesoExtra() = self.alimentosPesados().sum({ alimento => alimento.length() * 2 })
  
  method alimentosPesados() = elementosIngeridos.filter({ alimento => alimento.length() > 4 })
  
  method estaFeliz(gato) = elementosIngeridos.any({ alimento => alimento == "pan" })
}

object mickey {
  var property gatoFavorito = tom
  
  method peso() = 15
  
  method estaFeliz(gato) = gatoFavorito == gato
}