package master

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import datos.Precios
import java.util.Set

@Observable
@Accessors
class DT {
	String nombreDT
	String nombreEquipo
	double plata
	Torneo torneo
	int torneosDisponibles = 3
	int slots = 30
	Set<Jugador> jugadores = newHashSet
	List<Oferta> ofertasRecibidas = newArrayList

	def void venderJugador(Jugador jugador) {
		plata += jugador.precioVenta
		jugadores.remove(jugador)
	}

	def void comprarJugador(Jugador jugador) {
		plata -= jugador.precioVenta
		jugadores.add(jugador)
		jugador.precioVenta = 0
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

	def void comprarSlot() {
		slots++
		plata -= Precios.instance.getPrecio("Slot")
	}

	def boolean getTieneSlots() {
		slots > jugadores.size
	}

	def getJugadoresConImpuesto() {
		jugadores.filter[pagaImpuesto]
	}

	override toString() {
		nombreDT + ";" + nombreEquipo + ";" + plata + ";" + torneosDisponibles + ";" + slots + ";"
		+ jugadores.fold("") [ acum , jugador |	acum + jugador.id + "-" ]
	}

	def empato() {
		plata += Precios.instance.getPrecio("Empato")
	}

	def gano(Integer diferenciaGol) {
		plata += Precios.instance.getPrecio("Gano") + (diferenciaGol * Precios.instance.getPrecio("PlataPorGol"))
	}
	
	def ofertar(Jugador jugadorSeleccionado,Double precioOferta){
		new Oferta =>[
			dtOfertante = this
//			dtReceptor = DT DEL JUGADORSELECCIONADO
			monto = precioOferta
			jugadorAComprar = jugadorSeleccionado
		]
	}
	
	def aceptarOferta(Oferta oferta){
		oferta.dtOfertante.agregarJugador(oferta.jugadorAComprar)
		oferta.dtReceptor.sacarJugador(oferta.jugadorAComprar)
		oferta.dtOfertante.plata -= oferta.monto
		oferta.dtReceptor.plata += oferta.monto
	}
	
	def sacarJugador(Jugador jugador){
		jugadores.remove(jugador)
	}
	
	def agregarJugador(Jugador jugador){
		jugadores.add(jugador)
	}
	
	def int getPuntos(){
		torneo.getPuntos(this)
	}
}
