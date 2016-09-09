package arena.models

import master.DT
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import master.LigaMaster
import adapter.JSONAdapter

@Observable
@Accessors
class TorneoConfigModel {
	TorneoModel model
	Torneo torneoON
	DT dtON
	String nombreIngresado
	LigaMaster liga
	new(TorneoModel torneoModel) {
		model = torneoModel
		torneoON = torneoModel.torneoON
		liga = torneoModel.ligaMaster
	}

	def void addDT() {
		torneoON.addDT(dt)
		nombreIngresado = ""
	}

	def void getRemoveDT() {
		torneoON.removeDT(dtON)
	}
	
	def boolean dtTieneQuePagar(){
		dt.tieneQuePagar
	}
	
	def getDt(){
		JSONAdapter.getDT(nombreIngresado)
	}
}
