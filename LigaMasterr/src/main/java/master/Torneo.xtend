package master

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.uqbar.commons.utils.Observable
import java.util.Collections

@Observable
@Accessors
class Torneo {
	String nombreTorneo = ""
	List<DT> listaParticipantes = newArrayList
	List<Partido> listaPartidos = newArrayList

	def void sortearFechas() {
		listaPartidos.clear
		Collections.shuffle(listaParticipantes)
		var int fecha
		var int partido

		for (fecha = 0; fecha < numeroFechas; fecha++) {

			for (partido = 0; partido < (listaParticipantes.size) / 2; partido++) {

				var int local = (fecha + partido) % (listaParticipantes.size - 1)
				var int visitante = if(partido == 0) numeroFechas else (numeroFechas - partido + fecha) % numeroFechas

				val partidoNuevo = new Partido
				partidoNuevo.numeroFecha = fecha + 1
				partidoNuevo.dtLocal = listaParticipantes.get(local)
				partidoNuevo.dtVisitante = listaParticipantes.get(visitante)
				listaPartidos.add(partidoNuevo)

			}
		}
	}

	def List<Partido> getFecha(int entero) {
		listaPartidos.filter[numeroFecha == entero].toList
	}

	def Integer getNumeroFechas() {
		listaParticipantes.size - 1
	}

	def List<Jugador> getListaGoleadores() {
		listaParticipantes.fold(newArrayList)[lista, dt|lista.addAll(dt.jugadores) lista]
		.filter[goles != 0].sortBy [goles].reverse.toList
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

	override toString() {
		nombreTorneo + ";" + listaParticipantes.fold("")[acum, dt|acum + dt.nombreDT + "-"] + ";" +
			listaPartidos.fold("")[acum, partido|acum + partido + "-"]
	}
}
