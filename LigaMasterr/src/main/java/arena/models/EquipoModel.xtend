package arena.models

import master.DT
import master.Jugador
import master.LigaMaster
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.List
import datos.SoFifa
import master.Torneo

@Observable
@Accessors
class EquipoModel {
	LigaMaster grondomaster
	Torneo torneo
	
	DT dtElegido
	Jugador jugadorElegido
	String valorIngresado

	List<Jugador> listaExterior = newArrayList

	new(TorneoModel model) {
		grondomaster = model.grondomaster
		torneo = model.torneoSeleccionado
		dtElegido = torneo.listaParticipantes.get(0)
	}

	def void addJugador() {
		grondomaster.listaJugadores.add(jugadorElegido)
		dtElegido.addJugador(jugadorElegido)
		listaExterior.remove(jugadorElegido)
	}

	def void removeJugador() {
		listaExterior.add(jugadorElegido)
		grondomaster.listaJugadores.remove(jugadorElegido)
		dtElegido.jugadores.remove(jugadorElegido)
	}

	def void buscar() {
		listaExterior.clear
		listaExterior.addAll(SoFifa.instance.getJugadores(valorIngresado))
		listaExterior.removeAll(torneo.listaJugadores)
	}
}
