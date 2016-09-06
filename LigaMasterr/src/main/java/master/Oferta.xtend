package master

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Oferta {
	DT dtOfertante
	DT dtReceptor
	Double monto
	Jugador jugadorOfertado
	
	def void aceptar(){
		dtOfertante.addJugador(jugadorOfertado)
		dtOfertante.decPlata(monto)

		dtReceptor.removeJugador(jugadorOfertado)
		dtReceptor.incPlata(monto)
	}
	
	def void rechazar(){
		dtReceptor.ofertasRecibidas.remove(this)
	}
}