package arena.models

import master.DT
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import master.LigaMaster
import adapter.JSONAdapter
import java.util.List
import org.uqbar.commons.model.UserException

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
		dtIngresado.torneosDisponibles = dtIngresado.torneosDisponibles - 1
	}

	def void getRemoveDT() {
		
		if (dtON == null) throw new UserException("Debe seleccionar un jugador de la Lista")
		
		torneoON.removeDT(dtON)
		dtIngresado.torneosDisponibles = dtIngresado.torneosDisponibles + 1
	}
	
	def boolean dtTieneQuePagar(){
		dt.tieneQuePagar
	}
	
	def getDt(){
		JSONAdapter.getDT(dtIngresado.nombreDT)
	}
}
