package arena.models

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import master.DT
import master.Jugador

@Observable
@Accessors
class ImpuestoModel {
	DT dtAgregado
	Jugador jugadorSeleccionado
	
	new(TorneoConfigModel model) {
		dtAgregado = model.dt
	}
	
	def getJugadoresConImpuesto(){
		dtAgregado.jugadoresConImpuesto
	}
}