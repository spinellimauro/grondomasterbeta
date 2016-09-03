package arena.models

import master.DT
import master.Jugador
import master.LigaMaster
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils
import java.util.List

@Accessors
@Observable
class TransferiblesModel {
	Jugador jugadorSeleccionado
	DT dtElegido
	LigaMaster grondomaster

	new(EquipoModel model) {
		dtElegido = model.dtElegido
		grondomaster = model.grondomaster
	}

	def List<Jugador> getListaTransferibles() {
		val listaCompleta = grondomaster.listaTransferibles
		listaCompleta.removeAll(dtElegido.jugadores)
		listaCompleta
	}

	def void comprarJugador() {
		val dueño = grondomaster.listaDTs.findFirst[jugadores.contains(jugadorSeleccionado)]
		dueño.venderJugador(jugadorSeleccionado)
		dtElegido.comprarJugador(jugadorSeleccionado)
		ObservableUtils.firePropertyChanged(this, "grondomaster", getGrondomaster())
	}
}