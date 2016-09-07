package arena.models

import master.DT
import master.Oferta
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class OfertasModel {
	DT dtON
	Oferta ofertaON
	
	new(DT dt) {
		dtON = dt
	}
	
	def void aceptarOferta(){
		ofertaON.aceptar
	}
	
	def void rechazarOferta(){
		ofertaON.rechazar
	}
}
