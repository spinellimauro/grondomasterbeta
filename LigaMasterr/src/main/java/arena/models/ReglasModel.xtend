package arena.models

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import datos.PrecioNivel
import datos.PrecioEvento
import datos.Precios

@Observable
@Accessors
class ReglasModel {
	PrecioNivel nivelON = listaNiveles.get(0)
	PrecioEvento eventoON = listaEventos.get(0)
	
	def getListaNiveles(){
		Precios.instance.listaNiveles
	}
	
		
	def getListaEventos(){
		Precios.instance.listaEventos
	}
}