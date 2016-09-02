package arena.models

import master.LigaMaster
import java.util.List
import master.Jugador
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import master.DT

@Accessors
@Observable
class VentaJugadores {
	LigaMaster grondomaster = new LigaMaster
	List<Jugador> jugadores = newArrayList
	Jugador jugadorSeleccionado
	DT dtElegido
	
	def void jugadoresEnVenta(){
		jugadores = grondomaster.transferibles
	}
	
	def void comprarJugador(){
		dtElegido.comprarJugadorEnVenta(jugadorSeleccionado,dtJugador(jugadorSeleccionado))
		grondomaster.guardarBase
	}
	
	def DT dtJugador(Jugador jugador){
		grondomaster.dts.findFirst[dt | dt.jugadores.contains(jugador)]
	}
}