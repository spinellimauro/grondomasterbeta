package arena.models

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import datos.Precios

@Observable
@Accessors
class ReglasModel {
	Integer nivel
	Double precio
	new(TorneoModel model) {
	}
	
	def modificarPrecio(){
		Precios.instance.setPrecio(nivel,precio)
	}
}