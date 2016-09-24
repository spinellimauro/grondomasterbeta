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
	double plata
	int slots = 30
	Set<Jugador> listaJugadores = newHashSet
	List<Oferta> ofertasRecibidas = newArrayList

	Torneo torneo

	int torneosDisponibles = 3

	def Set<Jugador> getJugadores() {
		listaJugadores.filter[!torneo.estaSuspendido(it)].toSet
	}

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
		slots++
		decPlata(Precios.instance.getPrecio("Slot"))
	}

	def void incPlata(Double monto) {
		plata += monto
	}

	def void decPlata(Double monto) {
		plata -= monto
	}

	def void addJugador(Jugador jugador) {
		jugador.torneo = torneo
		listaJugadores.add(jugador)
	}

	def void removeJugador(Jugador jugador) {
		ofertasRecibidas.removeAll(getOfertas(jugador))
		listaJugadores.remove(jugador)
	}

	def int getPuntos() {
		torneo.getPuntos(this)
	}

	def int getAmarillas() {
		listaJugadores.fold(0)[acum, jugador|acum + jugador.amarillas]
	}

	def int getRojas() {
		listaJugadores.fold(0)[acum, jugador|acum + jugador.rojas]
	}

	def int getPuntosFairPlay() {
		amarillas * 4 + rojas * 12
	}

	def void addOferta(Oferta oferta) {
		ofertasRecibidas.add(oferta)
	}

	def List<Oferta> getOfertas(Jugador jugador) {
		ofertasRecibidas.filter[jugadorOfertado.equals(jugador)].toList
	}

	def boolean hayOfertas() {
		ofertasRecibidas.nullOrEmpty
	}
	
	def restarTorneoDisponible(){
		torneosDisponibles--
	}
	
	def tieneQuePagar(){
		torneosDisponibles == 0
	}

}
