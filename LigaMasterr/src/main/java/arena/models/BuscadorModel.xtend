package arena.models

import org.eclipse.xtend.lib.annotations.Accessors
import datos.SoFifa
import java.util.List
import master.Jugador
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class BuscadorModel {
	String valorBuscado = ""
	List<Jugador> resultados

	def void buscar() {
		resultados = SoFifa.instance.getJugadores(valorBuscado)
	}
}
