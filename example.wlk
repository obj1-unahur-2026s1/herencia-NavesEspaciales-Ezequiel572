class NavesEspaciales {
  var property velocidad //en kms/seg
  var property direccion  //nro entre 10 y -10
  var property combustible = 0 
  
  method estaDeRelajo() {
    self.estaTranquila()
  }

  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }

  method escapar() {
  }

  method avisar() {
  }

  method estaTranquila() {
    combustible <= 4000 && velocidad <= 12000
  }

  method cargarCombustible(litros) {
    combustible =+ litros
  }
  
  method descargarCombustible(litros) {
    combustible = (combustible - litros).max(0)
    }

  method acelerar_(cantidad) {
    velocidad = (velocidad + cantidad).min(100000)
  }

  method desacelerar_(cantidad) {
    velocidad = (velocidad - cantidad).max(0)
  }

  method irHaciaElSol() {
    direccion = 10
  }

  method escaparDelSol() {
    direccion = -10
  }

  method ponerseParaleloAlSol() {
    direccion = 0
  }

  method acercarseUnPocoAlSol() {
    direccion = (direccion + 1).min(10)
  }

  method alejarseUnPocoDelSol() {
    direccion = (direccion - 1).max(-10)
  }

  method prepararViaje() {
  self.cargarCombustible(30000)
  self.acelerar_(5000)
  }
}

class NavesBaliza inherits NavesEspaciales {
  var property color

  override method estaTranquila() {
    super()
    color != "rojo"
  }
  
  method cambiarColorDeBaliza(colorNuevo) {
    color = colorNuevo
  } 

  override method prepararViaje() {
    super()
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
  }

  override method escapar() {
    self.irHaciaElSol()
  }

  override method avisar() {
    color = "rojo"
  }

  override method estaDeRelajo() {
    
  }
}

class NaveDePasajero inherits NavesEspaciales{
  var property pasajeros 
  var property racionesDeComida = 0
  var property racionesDeBebidas = 0



  method cargarRacionesDeComida(cantidad) {
    racionesDeComida =+ cantidad
  }    

  method cargarRacionesDeBebidas(cantidad) {
    racionesDeBebidas =+ cantidad
  }    

  method descargarRacionesDeComida(cantidad) {
    racionesDeComida =- cantidad
  }   

  method descargarRacionesDeBebidas(cantidad) {
    racionesDeBebidas =- cantidad
  }    

  override method prepararViaje() {
    super()
    self.cargarRacionesDeComida(pasajeros * 4)
    self.cargarRacionesDeBebidas(pasajeros * 6)
    self.acercarseUnPocoAlSol()
  }

  override method escapar() {
    self.velocidad() * 2
  }

  override method avisar() {
    self.descargarRacionesDeComida(pasajeros * 1)
    self.descargarRacionesDeBebidas(pasajeros * 2)
  }
}

class NaveCombate inherits NavesEspaciales {
  var property invisible
  var property misilesDesplegados
  const mensajes = []

  override method estaTranquila() {
    super()
    misilesDesplegados = false
  }

  method ponerseVisible() {
    invisible = false
  }

  method ponerseInvisible() {
    invisible = true
  }

  method desplegarMisiles() {
    misilesDesplegados = true
  }

  method replegarMisiles() {
    misilesDesplegados = false
  }

  method emitirMensaje(mensaje) {
    mensajes.add(mensaje)
  }

  method mensajesEmitidos() = mensajes

  method primerMensajeEmitido() = mensajes.first()

  method ultimoMensajeEmitido() = mensajes.last()

  method emitioMensaje(mensaje) {
    mensajes.contains(mensaje)
  }

  method esEscueta() {
        mensajes.all {m => m.size() <= 30 }
  }

  override method prepararViaje() {
    super()
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar_(15000)
    self.emitirMensaje("Saliendo en mision")
  }

  override method escapar() {
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }

  override method avisar() {
    self.emitirMensaje("amenaza recibida")
  }
}

class NaveHospital inherits NaveDePasajero {
  var property estanQuirofanosPreparados 

  override method estaTranquila() {
    super()
    estanQuirofanosPreparados = false
  }

  method prepararQuirofanos() {
    estanQuirofanosPreparados = true
  }

  method desarmarQuirofanos() {
    estanQuirofanosPreparados = false
  }

  override method recibirAmenaza() {
    super()
    self.prepararQuirofanos()
  }
}

class NaveCombateSigilosa inherits NaveCombate {
  override method estaTranquila() {
    super()
    invisible = false
  }

  override method recibirAmenaza() {
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}

