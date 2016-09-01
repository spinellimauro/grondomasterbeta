import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Dt {
	Regla reglas
	String nombreDt
	String equipo
	double plata
	double valor
	Jugador jugador
	List<Jugador> jugadores = newArrayList
	int torneosDisponibles = 3
	int slots = 30

	def void venderJugador(Jugador jugador,double precio) {
		jugador => [precioVenta = precio]
	}

	def List<Jugador> getEnVenta() {
		jugadores.filter[precioVenta != 0].toList
	}

	def jugadoresConImpuesto() {
		jugadores.filter[j|j.pagaImpuesto]
	}

	def void pagarImpuesto(List<Jugador> jugadoresAPagar) {
		jugadoresAPagar.forEach[pagarJugador]

		var jugadoresNoPagados = jugadores
		jugadoresNoPagados.removeAll(jugadoresAPagar)
		jugadoresNoPagados.forEach[noSePago]
	}

	def void pagarJugador(Jugador jugador) {
		plata -= jugador.impuesto
		jugador.pagar
	}

	def void comprarJugadorEnVenta(Jugador jugadorSeleccionado) {
//		if (tieneSlots()){     SI NO TIENE SLOTS SE DESACTIVA EL BOTON COMPRAR.
		plata -= jugadorSeleccionado.precioVenta
		jugadores.add(jugadorSeleccionado)
//		}
//		else 
//			throw new Exception
	}

	def void venderJugadorEnVenta(Jugador jugadorVendido) {
		jugadores.remove(jugadorVendido)
		plata += jugadorVendido.precioVenta
	}

	def comprarSlot() {
		slots++
		plata -= reglas.valorSlot
	}

	def boolean tieneSlots() {
		slots > jugadores.size()
	}

}
