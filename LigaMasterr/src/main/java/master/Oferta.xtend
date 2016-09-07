package master

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.List

@Observable
@Accessors
class Oferta {
	DT dtOfertante
	DT dtReceptor
	Double monto
	Jugador jugadorOfertado
	List<Jugador> jugadoresOfrecidos = newArrayList
	
	def void aceptar(){
		dtOfertante.addJugador(jugadorOfertado)
		dtOfertante.decPlata(monto)
		
		dtReceptor.removeJugador(jugadorOfertado)
		dtReceptor.incPlata(monto)
		
		if( jugadoresOfrecidos.size > 0){
			jugadoresOfrecidos.forEach[ dtOfertante.removeJugador(it) ]
			jugadoresOfrecidos.forEach[ dtReceptor.addJugador(it) ]
		}
	}
	
	def void rechazar(){
		dtReceptor.ofertasRecibidas.remove(this)
	}
}