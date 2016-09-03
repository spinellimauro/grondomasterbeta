package arena.models

import master.DT
import master.Jugador
import master.LigaMaster
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class EquipoModel {
	Jugador jugadorElegido = new Jugador
	DT dtElegido = new DT
	LigaMaster grondomaster
	Integer precio

	new(TorneoModel model) {
		grondomaster = model.grondomaster
	}

	def void removeJugador() {
		dtElegido.jugadores.remove(jugadorElegido)
	}

	def ponerEnVenta() {
		jugadorElegido.precioVenta = precio
	}
}
