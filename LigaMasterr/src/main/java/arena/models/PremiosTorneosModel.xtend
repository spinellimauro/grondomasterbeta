package arena.models

import master.Torneo
import master.DT
import datos.PremioPosicion
import java.util.List

class PremiosTorneosModel {
	Torneo torneoON
	DT dtON
	List<PremioPosicion> posiciones = newArrayList
	PremioPosicion posicionON = listaPosiciones.get(0)
//	PremioEvento ON = listaEventos.get(0)
	
	new(TorneoModel model) {
		torneoON = model.torneoON
		dtON = model.dtON
		listaPosiciones
	}
	
	def getListaPosiciones(){
		posiciones = torneoON.premios.listaPosiciones
	}
	
	def getListaEventos(){
		torneoON.premios.listaEventos
	}
}