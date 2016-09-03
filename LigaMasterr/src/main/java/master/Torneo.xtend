package master

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.uqbar.commons.utils.Observable
import java.util.Collections

@Observable
@Accessors
class Torneo {
	String nombreTorneo
	List<DT> listaParticipantes = newArrayList
	List<Partido> listaPartidos = newArrayList

	def void sortearFechas() {
		val nuevaLista = newArrayList
		Collections.shuffle(listaParticipantes)
		var int round
		var int match
		val int rounds_count = listaParticipantes.size - 1
		val int matches_per_round = (listaParticipantes.size) / 2
		val int teams_count = listaParticipantes.size

		for (round = 0; round < rounds_count; round++)
			for (match = 0; match < matches_per_round; match++) {
				var int home = (round + match) % (teams_count - 1)
				var int away = if(match == 0) teams_count - 1 else (teams_count - 1 - match + round) % (teams_count - 1)

				val partido = new Partido
				partido.numeroFecha = round + 1
				partido.dtLocal = listaParticipantes.get(home)
				partido.dtVisitante = listaParticipantes.get(away)
				nuevaLista.add(partido)
			}
		listaPartidos = nuevaLista
	}

	def List<Partido> getFecha(int entero) {
		listaPartidos.filter[numeroFecha == entero].toList
	}

	override toString() {
		nombreTorneo + ";" 
		+ listaParticipantes.fold("")[acum, dt|acum + dt.nombreDT + "-"]+ ";" 
		+ listaPartidos.fold("")[acum, partido|acum + partido + "-"]
	}
}
