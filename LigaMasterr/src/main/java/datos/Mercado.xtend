package datos

import java.util.List
import master.DT
import master.Jugador
import master.Oferta
import master.Transferencia
import org.eclipse.xtend.lib.annotations.Accessors

//@Observable ARENA APP
@Accessors
class Mercado {
	List<Oferta> listaOfertas = newArrayList
	List<Transferencia> listaTraspasos = newArrayList
	
	
	
	def List<Oferta> getOfertasRecibidas(Jugador jugador) {
		listaOfertas.filter[jugadorOfertado.equals(jugador)].toList
	}
	
	def List<Oferta> getOfertasRecibidas(DT dt) {
		listaOfertas.filter[dtReceptor.equals(dt)].toList
	}

	def List<Oferta> getOfertasEnviadas(DT dt) {
		listaOfertas.filter[dtOfertante.equals(dt)].toList
	}
	
	def void agregarTransferencia(Transferencia transferencia){
		listaTraspasos.add(transferencia)
	}
}

