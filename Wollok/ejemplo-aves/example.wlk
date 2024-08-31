object pepita {
  var energy = 100
  var song = ""
  
  method energy() = energy
  
  method fly(minutes) {
    energy -= minutes * 3
  }
  
  method sing() {
    song = "Pprr Porr "
  }
}