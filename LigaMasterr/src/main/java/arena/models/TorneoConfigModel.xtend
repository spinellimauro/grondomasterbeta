package arena.models

import master.DT
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class TorneoConfigModel {
	TorneoModel model
	Torneo torneoON
	DT dtON
	String nombreIngresado

	new(TorneoModel torneoModel) {
		model = torneoModel
		torneoON = torneoModel.torneoON
	}

	def void addDT() {
		torneoON.addDT(new DT => [nombreDT = nombreIngresado])
		nombreIngresado = ""
	}

	def void getRemoveDT() {
		torneoON.removeDT(dtON)
	}
}
