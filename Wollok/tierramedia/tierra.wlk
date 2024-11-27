// Armas 

// Integrante 1 -- Matias
object baculo {
  
  var property poderBase = 250

  method unidadesDePoder(guerrero) = (poderBase * if(guerrero.tienePocaVida()) 2 else 1).min(400)

}
// Integrante 2 -- David

object espada {

  var property magiaQueRige = magiaElfica

  method poderDeMagiaQueRige(guerrero) = magiaQueRige.unidadesDePoder(guerrero)

  method unidadesDePoder(guerrero) = 10 * self.poderDeMagiaQueRige(guerrero)
}

object magiaElfica {
  const poder = 25
  method unidadesDePoder(guerrero) = poder
}

object magiaEnana {
  method unidadesDePoder(guerrero) = guerrero.vida() / 2
}


// Integrante 3 -- Tobias
object flechaDeBronce {

  const poderBase = 100
  var property fechaDeLustrado = new Date()

  method unidadesDePoder(guerrero) = 0.max(poderBase - (calendario.fecha() - fechaDeLustrado))
  
}

object calendario {
  
  var property fecha = new Date()

}


// Grupal

/* viejo gandalf
object gandalf {
    var property vida = 100 
    var property armas = []
    //var property vacunacionAlDia = false
    
    method cantidadDeArmas() = armas.size() 
    method tienePocaVida() = vida < 10
    method nivelDePoder() = (vida * self.efectoMultiplicador()) + self.sumatoriaDePoderArmas() * 2

    method efectoMultiplicador() = if (self.tienePocaVida()) 200 else 15

    method sumatoriaDePoderArmas() = armas.sum({arma => arma.unidadesDePoder(self)})
}

*/
object cajaDeFlechas {
  var property flechasQueContiene = []

  method unidadesDePoder(guerrero) = self.sumatoriaPoderDeFlechas(guerrero)/self.cantidadDeSignificativas(guerrero) 

  method sumatoriaPoderDeFlechas(guerrero) = self.flechasSignificativas(guerrero).sum({flecha =>flecha.unidadesDePoder(guerrero)})
  method flechasSignificativas(guerrero) = flechasQueContiene.filter({flecha => flecha.unidadesDePoder(guerrero)>50})
  method cantidadDeSignificativas(guerrero) = self.flechasSignificativas(guerrero).size()
}


object flechaDeAluminio{
    var property valor = 50 

    method unidadesDePoder(guerrero) = valor 
}

object flechaDeHierro{

    var property estaOxidada = false
    var property poderBase = 70

    method unidadesDePoder(guerrero) = if(self.estaOxidada()) self.poderBase()*0.5 else self.poderBase()

}


// Recorriendo la Tierra Media 

// Integrante 1 -- Matias 
object lebennin {

  var property cantidadDeGuardias = 0

  method pasaZona(guerrero) = if (self.puedePasar(guerrero))  self.aplicarConsecuencias(guerrero)

  method puedePasar(guerrero) = if(cantidadDeGuardias > 3) guerrero.nivelDePoder()>1500 else guerrero.nivelDePoder()>1000
  method aplicarConsecuencias(guerrero) {}

}
 
// Integrante 2 -- David

object minasTirith{
  method puedePasar(guerrero) = guerrero.cantidadDeArmas() > 0

  method pasarZona(guerrero) {
    self.aplicarConsecuencias(guerrero)
  }

  method aplicarConsecuencias(guerrero) {
    guerrero.curarGuerrero( (guerrero.cantidadDeArmas() * 10)*-1)
    
  }
}

// Integrante 3 -- Tobias

object lossarnach {
  method puedePasar(guerrero) = true

  method pasarZona(guerrero) {
    self.aplicarConsecuencias(guerrero)
  } 

  method aplicarConsecuencias(guerrero) {
    guerrero.curarGuerrero((guerrero.cantidadDeArmas() * 2))
    } 
  }

// Grupal

object caminoDeGondor {
    var property zonaDeSalida = lebennin
    var property zonaDeLlegada = minasTirith
    const camino = [zonaDeSalida,zonaDeLlegada]

    method pasarZona(guerrero) {
      camino.forEach{zona => zona.aplicarConsecuencias(guerrero) }
    }

    method puedePasar(guerrero) = camino.all({zona=>zona.puedePasar(guerrero)})
}

// Tom Bombadil

// Grupal

object tomBombadil {
    var property vida = 100
    var property vacunacionAlDia = true
    var property armas = []

    method cantidadDeArmas() = 100 
    method nivelDePoder()= 2000

    method modificarVida(modificacion) {}
}



// Continuacion -- Parte 2

// Integrante 1 -- Matias

object magiaHumana {
  var property fraccionQueOtorga = 0

  method unidadesDePoder(guerrero) = guerrero.vida() * (fraccionQueOtorga/100)  
}

class Espada{
  var property multiplicadorDePoder
  var property magiaQueRige

  method unidadesDePoder(guerrero) = magiaQueRige.unidadesDePoder(guerrero) * multiplicadorDePoder
}

class Daga inherits Espada {
  override method unidadesDePoder(guerrero) = super(guerrero)/2
}

// Integrante 2 -- David

class Arco {
  var property longitud  
  
  method tension(guerrero) = 40

  method unidadesDePoder(guerrero) = 0.1 * ( self.tension(guerrero) * longitud) 
}

class Ballesta inherits Arco {
  override method tension(guerrero) = if(guerrero.cantidadDeArmas()>3) super(guerrero) * 1.2 else super(guerrero) * 1.1

}

// Integrante 3 -- Tobias

// Como el baculo no cambia, y ademas es unico e irrepetible, mantenemos el objeto creado en la primer entrega.

class Hacha {

  const property poderBase

  var property tipoDeMango

  method unidadesDePoder(guerrero) = poderBase + tipoDeMango.poder(poderBase)

}

class MaderaRuberoica {

  const property multiplicador

  method poder(poderBase) = ((poderBase * multiplicador)).min(50)/10

}

object maderaNolan {
  
  method poder(poderBase) = 35

}

class MaderaLuduenica inherits MaderaRuberoica {

  override method poder(poderBase) = super(poderBase) + 10

}

// Grupal 

class Maiar inherits Raza {
  override method factorMultiplicador() = if (self.tienePocaVida()) 200 else 15
}

object gollum inherits Hobbit(vida=100){
  override method nivelDePoder() = super()/2
} 

// Integrante 1 -- Matias

class Hobbit inherits Raza {}

class Elfo inherits Raza {
  var property posilloMagico=self.randomPosillo()

  method randomPosillo()= 1000.randomUpTo(5000)
  

  override method nivelDePoder()= posilloMagico/2
}

// Integrante 2 -- David

class Enanos inherits Raza {
  const property factorDePoder
  override method factorMultiplicador() = factorDePoder

  override method nivelDePoder() = super() * 0.3
}

// Integrante 3 -- Tobias

class Humano inherits Raza {

  override method factorMultiplicador() = 1.1 ** self.cantidadDeArmas()

  //override method nivelDePoder() = self.vida() * self.factorMultiplicador() + self.sumatoriaDePoderArmas() * 2

}

// Modelado de gurreros

const frodo = new Hobbit (vida=60,armas=[new Espada(multiplicadorDePoder=10,magiaQueRige=magiaElfica)])
const legolas = new Elfo (vida=80,armas=[new Arco(longitud=110),new Espada(multiplicadorDePoder=12,magiaQueRige=magiaElfica)],posilloMagico=2000)

const gimli = new Enanos (vida=70,factorDePoder=3,armas=[new Daga(multiplicadorDePoder=10,magiaQueRige=magiaElfica)])


const glamdring = new Espada (multiplicadorDePoder=10,magiaQueRige=magiaElfica)
const gandalf = new Maiar (vida=100,armas=[glamdring,baculo])

const aragorn = new Humano (vida=80,armas=[new Espada(multiplicadorDePoder=18,magiaQueRige=magiaElfica), new Ballesta(longitud=10)])

// Los Caminos de la Tierra Media

class Zona {
  var property poderRequerido 
  var property penalizacion  

  method puedePasar(guerrero) = guerrero.nivelDePoder() > poderRequerido

  method aplicarConsecuencias(guerrero) {
    guerrero.curarGuerrero(penalizacion*-1)
  }  
}

class Camino {
  var property zonaDeSalida
  var property zonaDeLlegada
  var property camino =[]  

  method pasarCamino(guerrero){
    if (self.puedePasar(guerrero)) self.pasarZona(guerrero) else throw new Exception(message="Falta poder para pasar este camino")
  }

  method pasarZona(guerrero) {
    camino.forEach{zona => zona.aplicaConsecuencias(guerrero)}
  }

  method puedePasar(guerrero) = camino.all({zona =>zona.puedePasar(guerrero)})

}


const bosqueDeFangorn =  new Zona (poderRequerido=50,penalizacion=10)
const edoras = new Zona (poderRequerido = 300,penalizacion=50)

const rohan = new Camino (zonaDeSalida=bosqueDeFangorn,zonaDeLlegada=edoras,camino=[bosqueDeFangorn,lossarnach,edoras])
const gondor = new Camino(zonaDeSalida=lebennin,zonaDeLlegada=minasTirith,camino=[lebennin,minasTirith])

/*
Se evaluan sobre los guerreros de la siguiente forma:
rohan.pasarCamino(guerrero) // le mandamos un mensaje a rohan si un determinado guerrero puede pasar
*/

// Entrega 3

// Integrante 1

class Raza {
  var property vida
  var property archienemigo = null
  var property armas = []
  var property tactica = tacticaAgil

  method cantidadDeArmas() = armas.size()
  method tienePocaVida() = vida < 10  
  method tieneVida() = vida > 0 
  method nivelDePoder () = (vida * self.factorMultiplicador()) + self.sumatoriaDePoderArmas() * 2 
  method factorMultiplicador() = 1
  method sumatoriaDePoderArmas() = armas.sum({arma => arma.unidadesDePoder(self)})
  method armaMasPoderosa() = armas.max({arma => arma.unidadesDePoder(self)})
  method quitarArmaMasPoderosa() {
    armas = armas.filter({arma => arma != self.armaMasPoderosa()})
  }

  method curarGuerrero(modificacion){
    vida += modificacion 
  }  

  // Se produce un enfrentamiento cuando ambos tienen vida 
  method enfrentarA(oponente) {
    if (self.tieneVida() and oponente.tieneVida()) tactica.formaDeAtaque(self,oponente) 
  }

  // Un guerrero produce daño si tiene vida 
  method producirDanio() = if(self.tieneVida()) (self.nivelDePoder()+tactica.extra())*0.1 else 0

  // Metodo para quitar vida
  method recibirDanio(danio) {
    vida -=danio
  }
}

class Tactica {

  // Templete method para el daño extra que tienen las tacticas
  method extra() = 0
  
  // Forma el la que se producen los daños segun las tacticas
  method formaDeAtaque(atacante,defensor) {
    defensor.recibirDanio(atacante.producirDanio())
    atacante.recibirDanio(defensor.producirDanio())
  }
  
}

object tacticaAgil inherits Tactica{
  override method extra() = 100 // Una tactica agil suma 100 al poder de un guerrero
}

object tacticaDeResistencia inherits Tactica{

  override method formaDeAtaque(atacante,defensor) {
    // Un guerrero resistente recibe primero el ataque y lo recibe a la mitad 
    atacante.recibirDanio(defensor.producirDanio()/2) 
    defensor.recibirDanio(atacante.producirDanio())
  }

}

class TacticaCaruso inherits Tactica {

  // La tactica caruso tiene como estado el umbralDeEnergia para saber cuando huir
  var property umbralDeEnergia = 0

  // Si el enemigo supera el umbralDeEnergia huyo pero sufro 10 de daño y si no se produce combate normal
  override method formaDeAtaque(atacante,defensor) {
    
    if(defensor.nivelDePoder() > umbralDeEnergia) atacante.recibirDanio(10) else super(atacante,defensor)
    
  }
   
}

object tacticaCuatroTresTres inherits Tactica {
  override method formaDeAtaque(atacante,defensor){
    defensor.recibirDanio(atacante.producirDanio()*2) // Esta tactica produce un doble ataque por lo tanto es doble daño
    if(atacante.vida()>60) atacante.recibirDanio(0) else atacante.recibirDanio(defensor.producirDanio()) // Si tengo mas de 60 de vida no sufro danio 
  }
}

// Integrante 3
class Anillo {
  var property duenio
  
  method invocarAnillo() {
    duenio.vida(100.min(duenio.vida() * 2))
  }
}

class AnilloDeFuego inherits Anillo {
  var property archienemigo

  override method invocarAnillo() {
    super()

    archienemigo.recibirDanio(20)
  }
}

class AnilloMaldito inherits Anillo {
  override method invocarAnillo() {
    super()

    duenio.quitarArmaMasPoderosa()
  }
}

class AnilloDeAire inherits Anillo {
  var property mejorAmigo

  override method invocarAnillo() {
    super()

    mejorAmigo.curarGuerrero(30)
  }
}

object anilloUnico inherits Anillo (duenio = gollum) {

  override method invocarAnillo() {
    super()

    duenio.recibirDanio(20)

    if (duenio.cantidadDeArmas() <= 3)
      duenio.recibirDanio(10)
  }
}