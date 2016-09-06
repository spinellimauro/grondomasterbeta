package arena.models

import datos.SoFifa
import java.util.List
import master.DT
import master.Jugador
import master.LigaMaster
import master.Oferta
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class EquipoModel {
	LigaMaster grondomaster
	Torneo torneo

	DT dtUsuarioActivo
	Jugador jugadorElegido
	String valorIngresado
	
	DT dtElegido
	Jugador jugadorElegidoPlantel
	Double montoOfertado

	Oferta ofertaElegida

	List<Jugador> listaExterior = newArrayList

	new(TorneoModel model) {
		torneo = model.torneoSeleccionado
		dtElegido = torneo.listaParticipantes.get(0)
	}

	def void addJugador() {
		dtElegido.addJugador(jugadorElegido)
		listaExterior.remove(jugadorElegido)
	}

	def void removeJugador() {
		listaExterior.add(jugadorElegido)
		dtElegido.removeJugador(jugadorElegido)
	}

	def void buscar() {
		listaExterior.clear
		listaExterior.addAll(SoFifa.instance.getJugadores(valorIngresado))
		listaExterior.removeAll(torneo.listaJugadores)
	}

	def void comprarJugadorALaMaquina() {
		if (dtElegido.plata >= jugadorElegido.precioMaquina) {
			dtElegido.decPlata(jugadorElegido.precioMaquina)
			dtElegido.addJugador(jugadorElegido)
			listaExterior.remove(jugadorElegido)
		} else {
			throw new UserException("Dinero Insuficiente")
		}
	}

	def ofertar() {
		validar
		dtUsuarioActivo.ofertar(jugadorElegidoPlantel, getMontoOfertado)
		ObservableUtils.firePropertyChanged(this, "ofertas")
	}

	def getOfertas() {
		dtElegido.ofertasRecibidas
	}

	def aceptarOferta() {
		ofertaElegida.aceptar
		ObservableUtils.firePropertyChanged(this, "ofertas")
	}

	def rechazarOferta() {
		ofertaElegida.rechazar
		ObservableUtils.firePropertyChanged(this, "ofertas")
	}

	def validar() {
		if (dtUsuarioActivo == null) {
			throw new UserException("Debe seleccionar un usuario")
		}

		if (jugadorElegidoPlantel == null) {
			throw new UserException("Debe seleccionar un jugador")
		}
	}
}
