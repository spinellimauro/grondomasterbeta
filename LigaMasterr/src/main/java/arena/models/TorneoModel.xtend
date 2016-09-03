package arena.models

import java.util.List
import master.LigaMaster
import master.Partido
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.utils.Dependencies
import master.Torneo

@Observable
@Accessors
class TorneoModel {
	LigaMaster grondomaster
	List<Integer> listaFechas = (1 .. 15).toList
	int fechaSeleccionada = 1
	Torneo torneoSeleccionado = new Torneo

	new() {
		grondomaster = new LigaMaster("test")
		grondomaster.leerBase
	}
	
	@Dependencies("torneoSeleccionado","fechaSeleccionada")
	def List<Partido> getFecha() {
		torneoSeleccionado.getFecha(fechaSeleccionada)
	}

	def void sortearFixture() {
		torneoSeleccionado.sortearFechas
	}
}
