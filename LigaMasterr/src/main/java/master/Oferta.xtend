package master

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.List
import datos.Mercado

@Observable
@Accessors
class Oferta {
	DT dtOfertante
	DT dtReceptor
	Double monto
	Jugador jugadorOfertado
	List<Jugador> jugadoresOfrecidos = newArrayList

	def void aceptar() {
		dtReceptor.removeJugador(jugadorOfertado)
		dtReceptor.incPlata(monto)

		dtOfertante.addJugador(jugadorOfertado)
		dtOfertante.decPlata(monto)

		if (jugadoresOfrecidos.size > 0) {
			jugadoresOfrecidos.forEach[dtOfertante.removeJugador(it)]
			jugadoresOfrecidos.forEach[dtReceptor.addJugador(it)]
		}

		Mercado.instance.listaOfertas.removeAll(Mercado.instance.getOfertasRecibidas(jugadorOfertado))
	}

	def void rechazar() {
		Mercado.instance.listaOfertas.remove(this)
	}
}
