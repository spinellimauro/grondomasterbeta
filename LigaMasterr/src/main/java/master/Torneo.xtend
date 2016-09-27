package master

import datos.PremiosTorneos
import java.util.Collections
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Torneo {
	String nombreTorneo = ""
	List<DT> listaParticipantes = newArrayList
	List<Partido> listaPartidos = newArrayList
	int limiteAmarillas = 3
	PremiosTorneos premios = new PremiosTorneos
	
	def void sortearFechas() {
		listaPartidos.clear
		var listaMezclada = listaParticipantes
		Collections.shuffle(listaMezclada)
		val libre = new DT

		if(listaParticipantes.size % 2 != 0) listaParticipantes.add(libre)

		for (var fecha = 0; fecha < numeroFechas; fecha++) {

			for (var partido = 0; partido < (listaParticipantes.size) / 2; partido++) {

				var int local = (fecha + partido) % numeroFechas
				var int visitante = if(partido == 0) numeroFechas else (numeroFechas - partido + fecha) % numeroFechas

				val partidoNuevo = new Partido
				partidoNuevo.numeroFecha = fecha + 1
				partidoNuevo.dtLocal = listaMezclada.get(local)
				partidoNuevo.dtVisitante = listaMezclada.get(visitante)
				if(!partidoNuevo.getJugoPartido(libre)) listaPartidos.add(partidoNuevo)

			}
		}

		listaParticipantes.remove(libre)
	}

	def int getFechaActual() {
		val partidosNoTerminados = listaPartidos.filter[!terminado]
		if(partidosNoTerminados.size > 0) partidosNoTerminados.minBy[numeroFecha].numeroFecha else numeroFechas
	}

	def Integer getNumeroFechas() {
		val nroDts = listaParticipantes.size
		if(nroDts % 2 == 0) nroDts - 1 else nroDts
	}

	def List<Partido> getFecha(int entero) {
		listaPartidos.filter[numeroFecha == entero].toList
	}

	def List<Jugador> getListaJugadores() {
		listaParticipantes.map[getListaJugadores].flatten.toList
	}

	def List<Jugador> getListaTransferibles() {
		listaJugadores.filter[precioVenta != 0].toList
	}

	def List<DT> getListaPosiciones() {
		listaParticipantes.sortBy[puntos].reverse
	}

	def List<Jugador> getListaGoleadores() {
		listaJugadores.filter[goles != 0].sortBy[goles].reverse
	}

	def List<DT> getListaFairPlay() {
		listaParticipantes.sortBy[puntosFairPlay]
	}

	def int getGoles(Jugador jugador) {
		val listaGoles = listaPartidos.map[golesLocal + golesVisitante].flatten.toList
		Collections.frequency(listaGoles, jugador)
	}

	def int getAmarillas(Jugador jugador) {
		val listaRojas = listaPartidos.map[listaAmarillas].flatten.toList
		Collections.frequency(listaRojas, jugador)
	}

	def int getRojas(Jugador jugador) {
		val listaRojas = listaPartidos.map[listaRojas].flatten.toList
		Collections.frequency(listaRojas, jugador)
	}

	def boolean estaSuspendido(Jugador jugador) {
		val fechaAnterior = getFecha(fechaActual - 1)

		fechaAnterior.exists[fueExpulsado(jugador)] ||
			( fechaAnterior.exists[fueAmonestado(jugador)] && (getAmarillas(jugador) % limiteAmarillas == 0))
	}

	def int getPuntos(DT dt) {
		listaPartidos.filter[terminado].filter[getJugoPartido(dt)].fold(0)[acum, partido|acum + partido.getPuntos(dt)]
	}

	def DT getPropietario(Jugador jugador) {
		listaParticipantes.findFirst[listaJugadores.contains(jugador)]
	}

	def void addDT(DT dt) {
		dt.torneo = this
		listaParticipantes.add(dt)
	}

	def void removeDT(DT dt) {
		listaParticipantes.remove(dt)
	}

	def void configTorneo() {
		listaParticipantes.forEach[torneo = this]
		listaJugadores.forEach[torneo = this]
	}
	
	def terminarTorneo(){
		var i = 0
		if (listaPartidos.forall[terminado]){
			for(i=0;i<4;i++){     // pondriamos i<cantPremios Y que en premios haya un put(posicion,premio) etc
				listaPosiciones.get(i).plata = premios.getPremio(i)
			}
			listaParticipantes.forEach[restarTorneoDisponible]	
		}
		
//		grondomaster.guardarBase()
	}

}
