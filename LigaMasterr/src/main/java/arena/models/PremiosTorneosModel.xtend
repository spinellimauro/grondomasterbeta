package arena.models

import datos.PremioPosicion
import master.DT
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class PremiosTorneosModel {
	Torneo torneoON
	DT dtON
	PremioPosicion posicionON
	
	new(TorneoModel model) {
		torneoON = model.torneoON
		dtON = model.dtON
	}
	
	def getListaPosiciones(){
		torneoON.premios.listaPosiciones
	}
	
	def getListaEventos(){
		torneoON.premios.listaEventos
	}
}