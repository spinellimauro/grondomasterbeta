package master

import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class DT {
	String nombreDT
	String nombreEquipo
	double plata
	int slots = 30
	Set<Jugador> jugadores = newHashSet
	List<Oferta> ofertasRecibidas = newArrayList

	Torneo torneo

	int fechasDisponibles = 3

	def void venderJugador(Jugador jugador) {
		incPlata(jugador.precioVenta)
		removeJugador(jugador)
	}

	def void comprarJugador(Jugador jugador) {
		decPlata(jugador.precioVenta)
		addJugador(jugador)
		jugador.precioVenta = 0
	}

	def void pagarImpuesto(List<Jugador> jugadoresAPagar) {
		jugadoresAPagar.forEach[pagarImpuesto]

		var jugadoresNoPagados = jugadores
		jugadoresNoPagados.removeAll(jugadoresAPagar)
		jugadoresNoPagados.forEach[noSePago]

		if(jugadoresNoPagados.size != 0) fechasDisponibles--
	}

	def void pagarImpuesto(Jugador jugador) {
		decPlata(jugador.impuesto)
		jugador.pagar
	}

	def getJugadoresConImpuesto() {
		jugadores.filter[pagaImpuesto]
	}

	def boolean getTieneSlots() {
		slots > jugadores.size
	}

	def void comprarSlot() {
		slots++
		decPlata(torneo.precios.getPrecio("Slot"))
	}


	def void incPlata(Double monto) {
		plata += monto
	}

	def void decPlata(Double monto) {
		plata -= monto
	}

	def void addJugador(Jugador jugador) {
		jugadores.add(jugador)
	}

	def void removeJugador(Jugador jugador) {
		jugadores.remove(jugador)
	}

	def int getPuntos() {
		torneo.getPuntos(this)
	}
	
	def void ofertar(Jugador _jugadorOfertado , Double valorOfertado){
		_jugadorOfertado.dueño.ofertasRecibidas.add(
			new Oferta =>[
				dtOfertante = this
				dtReceptor = _jugadorOfertado.dueño
				monto = valorOfertado
				jugadorOfertado = _jugadorOfertado
			]
		)
	}
	
	override toString() {
		nombreDT + ";" + nombreEquipo + ";" + plata + ";" + fechasDisponibles + ";" + slots + ";" + jugadores.fold("-") [ acum, jugador |
			acum + jugador.id + "-"
		]
	}
	
	def getOfertas(Jugador jugador) {
		ofertasRecibidas.filter[o|o.jugadorOfertado == jugador]
	}
	
}
