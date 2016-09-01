import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Jugador {
	int nivel
	Double precioVenta = null
	int vecesNoPagadas = 0

	def double getPrecioMaquina() {
		nivel * 10000
	}

	def void setPrecioVenta(double precio) {
		precioVenta = precio
	}

	def double getImpuesto() {
		getPrecioMaquina * 0.10
	}

	def void noSePago() {
		vecesNoPagadas++
	}

	def void pagar() {
		vecesNoPagadas = 0
	}
	
	def pagaImpuesto() {
		nivel > 82
	}
	
}