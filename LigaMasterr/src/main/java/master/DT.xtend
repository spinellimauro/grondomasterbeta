package master

import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import datos.Precios

@Observable
@Accessors
class DT {
	String nombreDT
	String nombreEquipo
	double plata = 0.0
	int slots = 30
	Set<Jugador> listaJugadores = newHashSet
	int torneosDisponibles = 3

	def void venderJugador(Jugador jugador) {
		incPlata(jugador.precioVenta)
		removeJugador(jugador)
	}

	def void comprarJugador(Jugador jugador, Double precio) {
		decPlata(precio)
		addJugador(jugador)
		jugador.precioVenta = 0
	}

	def void pagarImpuesto(List<Jugador> jugadoresAPagar) {
		jugadoresAPagar.forEach[pagarImpuesto]

		var jugadoresNoPagados = newArrayList
		jugadoresNoPagados.addAll(listaJugadores)
		jugadoresNoPagados.removeAll(jugadoresAPagar)
		jugadoresNoPagados.forEach[noSePago]

		if(jugadoresNoPagados.size != 0) torneosDisponibles--
	}

	def void pagarImpuesto(Jugador jugador) {
		decPlata(jugador.impuesto)
		jugador.pagar
	}

	def getJugadoresConImpuesto() {
		listaJugadores.filter[pagaImpuesto].toList
	}

	def boolean getTieneSlots() {
		slots > listaJugadores.size
	}

	def void comprarSlot() {
		if(plata >= Precios.instance.getPrecio("Slot")){
			slots++ 
			decPlata(Precios.instance.getPrecio("Slot"))
		}else{
			throw new Exception() 	
		}
	}

	def void incPlata(Double monto) {
		plata += monto
	}

	def void decPlata(Double monto) {
		plata -= monto
	}

	def void addJugador(Jugador jugador) {
		listaJugadores.add(jugador)
	}

	def void removeJugador(Jugador jugador) {
		listaJugadores.remove(jugador)
	}

	def restarTorneoDisponible(){
		torneosDisponibles--
	}
	
	def tieneQuePagar(){
		torneosDisponibles == 0
	}
	
	def venderJugadorALaMaquina(Jugador jugador) {
		removeJugador(jugador)
		plata += (Precios.instance.getPrecio(jugador)/Precios.instance.getPrecio("PrecioMaquina")) // PrecioMaquina (cuarta Parte del valor del jugador)
	}

}
