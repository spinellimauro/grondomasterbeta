package master

import datos.Precios
import java.util.Collections
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Torneo {
	String nombreTorneo = ""
	Precios precios = new Precios
	List<DT> listaParticipantes = newArrayList
	List<Partido> listaPartidos = newArrayList

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

	def List<Jugador> getListaTransferibles() {
		listaJugadores.filter[precioVenta != 0].toList
	}

	def List<Partido> getFecha(int entero) {
		listaPartidos.filter[numeroFecha == entero].toList
	}

	def Integer getNumeroFechas() {
		val nroDts = listaParticipantes.size
		if(nroDts % 2 == 0) nroDts - 1 else nroDts
	}

	def List<Jugador> getListaJugadores() {
		listaParticipantes.map[jugadores].flatten.toList
	}

	def List<Jugador> getListaGoleadores() {
		listaJugadores.filter[goles != 0].sortBy[goles].reverse
	}

	def List<DT> getListaPosiciones() {
		listaParticipantes.sortBy[puntos].reverse
	}
	
	def int getPuntos(DT dt) {
		listaPartidos.filter[getJugoPartido(dt)].fold(0)[acum, partido|acum + partido.getPuntos(dt)]
	}

	def int getGoles(Jugador jugador) {
		val listaGoles = listaPartidos.fold(newArrayList) [ lista, partido |
			lista.addAll(partido.golesLocal)
			lista.addAll(partido.golesVisitante)
			lista
		]

		listaGoles.filter[equals(jugador)].size
	}

	def DT getPropietario(Jugador jugador) {
		listaParticipantes.findFirst[jugadores.contains(jugador)]
	}
	
	def void addDT(DT dt){
		dt.torneo = this
		listaParticipantes.add(dt)
	}
	
	def void configTorneo(){
		listaParticipantes.forEach[ torneo = this ]
		listaJugadores.forEach[torneo = this]
	}

}
