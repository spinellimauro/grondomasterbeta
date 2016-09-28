package arena.models

import master.Jugador
import master.Partido
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.List

@Observable
@Accessors
class PartidoModel {
	String nombreLocal
	String nombreVisitante
	List<Jugador> equipoLocal
	List<Jugador> equipoVisitante

	Partido partido
	Jugador jugadorSeleccionado

	new(TorneoModel model) {
		partido = model.partido
		nombreLocal = partido.dtLocal.nombreDT
		nombreVisitante = partido.dtVisitante.nombreDT
		equipoLocal = partido.dtLocal.listaJugadores.filter[!model.torneoON.estaSuspendido(it)].toList
		equipoVisitante = partido.dtVisitante.listaJugadores.filter[!model.torneoON.estaSuspendido(it)].toList
	}

	def void addGol() {
		partido.addGol(jugadorSeleccionado)
	}

	def void removeGol() {
		partido.removeGol(jugadorSeleccionado)
	}

	def void addAmarilla() {
		partido.addAmarilla(jugadorSeleccionado)
	}

	def void removeAmarilla() {
		partido.removeAmarilla(jugadorSeleccionado)
	}

	def void addRoja() {
		partido.addRoja(jugadorSeleccionado)
	}

	def void removeRoja() {
		partido.removeRoja(jugadorSeleccionado)
	}
}
