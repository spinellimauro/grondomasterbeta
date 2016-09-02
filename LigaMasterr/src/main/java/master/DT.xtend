package master

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import datos.Precios

@Observable
@Accessors
class DT {
	String nombreDT
	String nombreEquipo
	double plata
	int torneosDisponibles = 3
	int slots = 30
	List<Jugador> jugadores = newArrayList

	def void venderJugador(Jugador jugador, double precio) {
		jugador => [precioVenta = precio]
	}

	def List<Jugador> getEnVenta() {
		jugadores.filter[precioVenta != 0].toList
	}

	def jugadoresConImpuesto() {
		jugadores.filter[pagaImpuesto]
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

	def void comprarSlot() {
		slots++
		plata -= Precios.instance.getPrecio("Slot")
	}

	def boolean getTieneSlots() {
		slots > jugadores.size()
	}

	override toString() {
		nombreDT + ";" + nombreEquipo + ";" + plata + ";" + torneosDisponibles + ";" + slots + ";" 
		+ jugadores.fold("")[ acum , jugador | acum + jugador.id + "-" ]
	}
	
	def empato(){
		plata += 1000
	}
	
	def gano(Integer diferenciaGol){
		plata += 2000 + (diferenciaGol * 1000)
	}
}
