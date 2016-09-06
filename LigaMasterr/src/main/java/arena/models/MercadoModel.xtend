package arena.models

import java.util.List
import master.DT
import master.Jugador
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class MercadoModel {
	Jugador jugadorSeleccionado
	DT dtElegido
	Torneo torneo

	new(EquipoModel model) {
		dtElegido = model.dtElegido
		torneo = model.torneo
	}

	def List<Jugador> getListaTransferibles() {
		val listaCompleta = torneo.listaTransferibles
		listaCompleta.removeAll(dtElegido.getListaJugadores)
		listaCompleta
	}

	def void comprarJugador() {
		val propietario = torneo.getPropietario(jugadorSeleccionado)
		propietario.venderJugador(jugadorSeleccionado)
		dtElegido.comprarJugador(jugadorSeleccionado)
		ObservableUtils.firePropertyChanged(this, "listaTransferibles")
		ObservableUtils.firePropertyChanged(this, "dtElegido")
	}
}