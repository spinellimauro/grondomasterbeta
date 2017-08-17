package master

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
//@Observable ARENA APP
@Accessors
class Oferta {
	DT dtOfertante
	DT dtReceptor
	double monto
	
	Jugador jugadorOfertado
	List<Jugador> jugadoresOfrecidos = newArrayList

	def void aceptar() {
		dtOfertante.comprarJugador(jugadorOfertado,monto)
		dtReceptor.venderJugador(jugadorOfertado,monto)

		jugadoresOfrecidos.forEach[dtReceptor.comprarJugador(it, 0)]
		jugadoresOfrecidos.forEach[dtOfertante.venderJugador(it, 0)]
	
		LigaMaster.instance.mercado.listaOfertas.removeAll(LigaMaster.instance.mercado.getOfertasRecibidas(jugadorOfertado))
	}

	def void rechazar() {
		LigaMaster.instance.mercado.listaOfertas.remove(this)
	}
}
