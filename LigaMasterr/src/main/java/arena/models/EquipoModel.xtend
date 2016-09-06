package arena.models

import master.DT
import master.Jugador
import master.LigaMaster
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.List
import datos.SoFifa
import master.Torneo
import org.uqbar.commons.model.UserException
import master.Oferta
import org.uqbar.commons.utils.Dependencies

@Observable
@Accessors
class EquipoModel {
	LigaMaster grondomaster
	Torneo torneo
	
	DT dtUsuarioActivo
	DT dtElegido
	Jugador jugadorElegidoPlantel
	Jugador jugadorElegido
	String valorIngresado
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
		if (dtElegido.plata >= jugadorElegido.precioMaquina){	
			dtElegido.decPlata(jugadorElegido.precioMaquina)
			dtElegido.addJugador(jugadorElegido)
			listaExterior.remove(jugadorElegido)
		}else{
			throw new UserException("Dinero Insuficiente")
		}
	}

	def ofertar(){
		dtUsuarioActivo.ofertar(jugadorElegidoPlantel,getMontoOfertado)
	}
	
	def getOfertas(){
		dtElegido.ofertasRecibidas
	}
	
}
