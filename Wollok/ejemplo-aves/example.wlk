object pepita {
  var energy = 100
  
  // getter
  method energy() = energy
  
  //setter
  method energy(_energy) {
    energy = _energy
    
  }

  method fly(minutes) {
    energy -= minutes * 3
  }
  
  method comer(cantidad) {
    energy = energy + 2 * cantidad
  }
}

object juan {
  var mascota= ""
  
  method mascota(_mascota) {
      mascota = _mascota
      mascota.duenio(self)
  }
}

object firulais {
  var duenio = ""

  method duenio(_duenio) {
    duenio = _duenio
  }
  
}


// Ejemplo de Polimorfimos

object  galvan {
  var sueldo = 15000

  method sueldo()=sueldo
  method sueldo(_sueldo) { 
    sueldo= _sueldo
  } 
}

object baigorria{
  var cantidadEmpanadasVendidas=100
  var montoPorEmpanada = 200 
  
  method venderEmpanada() {
    cantidadEmpanadasVendidas += 1
  }
  
  //getter
  method montoPorEmpanada() = montoPorEmpanada
  //Setter
  method montoPorEmpanada(_montoPorEmpanada) {
    montoPorEmpanada= _montoPorEmpanada
  }

  method sueldo() = cantidadEmpanadasVendidas * montoPorEmpanada

}

object gimenez {
  var dinero = 300000 

  method dinero() = dinero
  method pagarA(empleado) {
    dinero = dinero - empleado.sueldo()
  }
}