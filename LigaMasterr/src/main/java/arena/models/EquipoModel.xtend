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
import org.uqbar.commons.model.ObservableUtils

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
		validar
		dtUsuarioActivo.ofertar(jugadorElegidoPlantel,getMontoOfertado)
		ObservableUtils.firePropertyChanged(this, "ofertas")
	}
	
	def getOfertas(){
		dtElegido.ofertasRecibidas
		
	}
	
	def aceptarOferta(){
//		if (validarOferta){
			ofertaElegida.aceptar
//			dtElegido.ofertasRecibidas.removeAll(dtElegido.getOfertas(jugadorElegidoPlantel))  // TODO : borre todas las ofertas del jugador que ya se fue del equipo
			ObservableUtils.firePropertyChanged(this, "ofertas")
//		}
//		else{
//			
//			ofertaElegida.rechazar
//			ObservableUtils.firePropertyChanged(this, "ofertas")
//			throw new UserException("No tenes ese jugador")
//		}
			
	}
	
	def rechazarOferta(){
		ofertaElegida.rechazar
		ObservableUtils.firePropertyChanged(this, "ofertas")
	}
	
//	def validarOferta(){
//		dtElegido.jugadores.contains(ofertaElegida.jugadorOfertado)
//	}
	
	def validar(){
		if (dtUsuarioActivo == null){
			throw new UserException("Debe seleccionar un usuario")
		}
		
		if (jugadorElegidoPlantel == null){
			throw new UserException("Debe seleccionar un jugador")
		}
		
	}
	
}
