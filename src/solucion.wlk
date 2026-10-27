// --- PRODUCTORA ---
object productora {
  var property impuesto = 100
  const asistentes = []
  const bandas = []

  method agregarAsistente(asistente) { asistentes.add(asistente) }
  method agregarBanda(banda) { bandas.add(banda) }

  // Reportes
  method recaudacionTotal() {
    return asistentes.sum({ asistente => asistente.totalGastadoEnEntradas() })
  }

  method presupuestoTotalBandas() {
    return bandas.sum({ banda => banda.presupuesto() })
  }

  method gananciaTotal() {
    return self.recaudacionTotal() - self.presupuestoTotalBandas()
  }

  method cantidadEntradasVendidas() {
    return asistentes.sum({ asistente => asistente.cantidadDeEntradas() })
  }

  method entradasDeBanda(banda) {
    return asistentes.sum({ asistente => asistente.entradasParaBanda(banda) })
  }

  method bandaMasPopular() {
    return bandas.max({ banda => self.entradasDeBanda(banda) })
  }

  method bonificarAsistentesVip() {
    asistentes.forEach({ asistente => asistente.recibirBonificacion() })
  }
}

// --- ABONOS (Polimorfismo) ---
object abonoFan {
  method descuento() = 0
  method bonificar() {}
}

class AbonoVip {
  var property porcentajeDescuento

  method descuento() = porcentajeDescuento
  method bonificar() {
    porcentajeDescuento += 0.01
  }
}

// --- ENTRADAS ---
class Entrada {
  const property banda
  const property fecha

  method precioBase() = 1000

  method precioAlPublico() {
    return self.precioBase() + productora.impuesto()
  }
}

// --- ASISTENTES ---
class Asistente {
  var property dineroDisponible
  var property abono
  const historialEntradas = []

  method comprarEntrada(banda, fecha) {
    if (dineroDisponible <= 0) {
      self.error("El asistente no tiene saldo positivo para comprar entradas.")
    }
    
    const entrada = new Entrada(banda = banda, fecha = fecha)
    const montoAPagar = entrada.precioAlPublico() * (1 - abono.descuento())

    dineroDisponible -= montoAPagar
    historialEntradas.add(entrada)
  }

  method entradasDelAnioAnterior(anioActual) {
    return historialEntradas.filter({ entrada => entrada.fecha().year() == anioActual - 1 })
  }

  method nombresDeBandasCompradas() {
    return historialEntradas.map({ entrada => entrada.banda().nombre() }).asSet()
  }

  method totalGastadoEnEntradas() {
    return historialEntradas.sum({ entrada => entrada.precioAlPublico() })
  }

  method cantidadDeEntradas() = historialEntradas.size()

  method entradasParaBanda(banda) {
    return historialEntradas.count({ entrada => entrada.banda() == banda })
  }

  method recibirBonificacion() {
    abono.bonificar()
  }
}

// --- BANDAS ---
class Banda {
  const property nombre

  method canon() = 1000000
  method gastoExtra()
  method presupuesto() = self.canon() + self.gastoExtra()
  method popularidad()
}

class BandaRock inherits Banda {
  const solosDeGuitarra

  override method gastoExtra() = 10000
  override method popularidad() = 100 * solosDeGuitarra
}

class BandaTrap inherits Banda {
  const tieneHielo

  override method popularidad() = if (tieneHielo) 1000 else 0
  override method canon() = self.popularidad() * self.popularidad()
  override method gastoExtra() = 0
}

class BandaIndie inherits Banda {
  const cantidadInstrumentos

  override method popularidad() = 3.14 * nombre.length()
  override method gastoExtra() = 500 * cantidadInstrumentos
}