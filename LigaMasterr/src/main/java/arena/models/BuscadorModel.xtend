package arena.models

import datos.SoFifa
import java.util.List
import master.DT
import master.Jugador
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import master.LigaMaster

@Observable
@Accessors
class BuscadorModel {
	DT dtElegido
	String valorBuscado = ""
	Jugador jugadorElegido
	List<Jugador> resultados
	LigaMaster grondoMaster 
	
	new(DT dt,LigaMaster _grondoMaster) {
		dtElegido = dt
		grondoMaster = _grondoMaster
	}

	def void buscar() {
		resultados = SoFifa.instance.getJugadores(valorBuscado)
	}
	
	def void addJugador() {
		dtElegido.jugadores.add(jugadorElegido)
		grondoMaster.guardarBase
	}
}
