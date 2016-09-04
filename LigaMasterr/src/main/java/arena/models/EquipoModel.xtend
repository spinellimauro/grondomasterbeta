package arena.models

import master.DT
import master.Jugador
import master.LigaMaster
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.List
import datos.SoFifa

@Observable
@Accessors
class EquipoModel {
	DT dtElegido
	Jugador jugadorElegido
	LigaMaster grondomaster
	Integer precioIngresado
	String nombreIngresado
	String valorIngresado
	List<Jugador> resultados = newArrayList

	new(TorneoModel model) {
		grondomaster = model.grondomaster
		dtElegido = grondomaster.listaDTs.get(0)
	}

	def void addJugador() {
		grondomaster.listaJugadores.add(jugadorElegido)
		dtElegido.jugadores.add(jugadorElegido)
		resultados.remove(jugadorElegido)
	}

	def void removeJugador() {
		resultados.add(jugadorElegido)
		grondomaster.listaJugadores.remove(jugadorElegido)
		dtElegido.jugadores.remove(jugadorElegido)
	}

	def void ponerEnVenta() {
		jugadorElegido.precioVenta = precioIngresado
	}

	def void addDT() {
		grondomaster.listaDTs.add(new DT => [nombreDT = nombreIngresado])
	}

	def void removeDT() {
		grondomaster.listaDTs.remove(dtElegido)
	}

	def void buscar() {
		resultados.clear
		resultados.addAll(SoFifa.instance.getJugadores(valorIngresado))
		resultados.removeAll(grondomaster.listaJugadores)
	}
}
