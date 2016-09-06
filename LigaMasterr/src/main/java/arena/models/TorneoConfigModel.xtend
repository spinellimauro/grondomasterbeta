package arena.models

import master.DT
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class TorneoConfigModel {
	TorneoModel torneo
	DT dtElegido
	String nombreIngresado = ""

	new(TorneoModel model) {
		torneo = model
	}

	def void addDT() {
		val dtNuevo = new DT => [nombreDT = nombreIngresado]
		torneo.torneoSeleccionado.addDT(dtNuevo)
	}

	def void getRemoveDT() {
		torneo.torneoSeleccionado.listaParticipantes.remove(dtElegido)
	}
}
