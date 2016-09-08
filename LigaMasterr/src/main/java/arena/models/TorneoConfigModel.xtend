package arena.models

import master.DT
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import master.LigaMaster

@Observable
@Accessors
class TorneoConfigModel {
	TorneoModel model
	Torneo torneoON
	DT dtON
	String nombreIngresado
	LigaMaster liga
	DT dt = new DT => [nombreDT = nombreIngresado]
	new(TorneoModel torneoModel) {
		model = torneoModel
		torneoON = torneoModel.torneoON
		liga = torneoModel.ligaMaster
	}

	def void addDT() {
		torneoON.addDT(new DT => [nombreDT = nombreIngresado])
		nombreIngresado = ""
	}

	def void getRemoveDT() {
		torneoON.removeDT(dtON)
	}
	
	def boolean dtTieneQuePagar(){
		dt.tieneQuePagar
	}
}
