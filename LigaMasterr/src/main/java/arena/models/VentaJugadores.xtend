package arena.models

import master.LigaMaster
import java.util.List
import master.Jugador
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class VentaJugadores {
	LigaMaster grondomaster = new LigaMaster
	List<Jugador> jugadores = newArrayList
	Jugador jugadorSeleccionado
	
	def void jugadoresEnVenta(){
		jugadores = grondomaster.transferibles
	}
}