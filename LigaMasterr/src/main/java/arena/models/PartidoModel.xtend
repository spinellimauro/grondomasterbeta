package arena.models

import master.Jugador
import master.Partido
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class PartidoModel {
	Partido partido
	Jugador jugadorSeleccionado

	new(Partido model) {
		partido = model
	}
	
	def void addGol() {
		partido.addGol(jugadorSeleccionado)
	}

	def void removeGol() {
		partido.removeGol(jugadorSeleccionado)
	}
}
