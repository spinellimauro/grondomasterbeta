package datos

import master.Oferta
import java.util.List
import master.DT
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import master.Jugador

@Observable
@Accessors
class Mercado {
	static Mercado instance
	List<Oferta> listaOfertas = newArrayList
	
	def List<Oferta> getOfertasRecibidas(Jugador jugador) {
		listaOfertas.filter[jugadorOfertado.equals(jugador)].toList
	}
	
	def List<Oferta> getOfertasRecibidas(DT dt) {
		listaOfertas.filter[dtReceptor.equals(dt)].toList
	}

	def List<Oferta> getOfertasEnviadas(DT dt) {
		listaOfertas.filter[dtOfertante.equals(dt)].toList
	}
	
	def static getInstance(){
		if( instance == null) instance = new Mercado
		instance
	}
}
