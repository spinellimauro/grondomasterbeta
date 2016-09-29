package arena.models

import master.DT
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import master.LigaMaster
import adapter.JSONAdapter
import java.util.List

@Observable
@Accessors
class TorneoConfigModel {
	TorneoModel model
	Torneo torneoON
	DT dtON
	DT dtIngresado
	
	new(TorneoModel torneoModel) {
		model = torneoModel
		torneoON = torneoModel.torneoON
	}
	
	def List<DT> getListaDT(){
		LigaMaster.instance.listaDT
	}

	def void addDT() {
		torneoON.addDT(dt)
	}

	def void getRemoveDT() {
		torneoON.removeDT(dtON)
		dtON.torneosDisponibles = dtON.torneosDisponibles + 1
	}
	
	def boolean dtTieneQuePagar(){
		dt.tieneQuePagar
	}
	
	def getDt(){
		JSONAdapter.getDT(dtIngresado.nombreDT)
	}
}
