package arena.models

import master.DT
import master.Oferta
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import master.LigaMaster

@Observable
@Accessors
class OfertasModel {
	DT dtON
	Oferta ofertaON
	LigaMaster ligaMaster
	new(DT dt) {
		dtON = dt
	}
	
	def void aceptarOferta(){
		ofertaON.aceptar
		ligaMaster.guardarBase	
	}
	
	def void rechazarOferta(){
		ofertaON.rechazar
		ligaMaster.guardarBase
	}
}
