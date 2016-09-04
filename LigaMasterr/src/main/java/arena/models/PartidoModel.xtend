package arena.models

import master.Partido
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import master.Jugador
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Dependencies

@Observable
@Accessors
class PartidoModel {
	TorneoModel torneo
	Partido partido
	Jugador jugadorSeleccionado

	new(TorneoModel model) {
		partido = model.partido
		torneo = model
	}

	def void addGolLocal() {
		partido.golesLocal.add(jugadorSeleccionado)
		ObservableUtils.firePropertyChanged(this, "partido")
	}

	def void removeGolLocal() {
		partido.golesLocal.remove(jugadorSeleccionado)
		ObservableUtils.firePropertyChanged(this, "partido")
	}

	def void addGolVisitante() {
		partido.golesVisitante.add(jugadorSeleccionado)
		ObservableUtils.firePropertyChanged(this, "partido")
	}

	def void removeGolVisitante() {
		partido.golesVisitante.remove(jugadorSeleccionado)
		ObservableUtils.firePropertyChanged(this, "partido")
	}

	@Dependencies("partido")
	def getMarcador() {
		partido.score
	}
}
