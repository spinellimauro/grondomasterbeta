package arena.models

import master.Jugador
import arena.models.EquipoModel
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.List
import master.DT
import master.Oferta
import master.LigaMaster
import datos.Mercado
import org.uqbar.commons.model.UserException
@Observable
@Accessors
class OfertaModel {
	DT dtON
	Jugador jugadorON
	LigaMaster ligaMaster
	double montoOfertado = 0.0
	Jugador jugadorElegido
	List<Jugador> listaJugadores = newArrayList

	new(EquipoModel equipoModel) {
		dtON = equipoModel.dtON
		jugadorON = equipoModel.jugadorON
	}

	def void addJugador() {
		listaJugadores.add(jugadorElegido)
	}
	
	def void removeJugador() {
		listaJugadores.add(jugadorElegido)
	}
	
	def void enviarOferta() {
		
//		if(montoOfertado > dtON.plata) throw new UserException("No tenes ese dinero disponible")

		Mercado.instance.listaOfertas.add(
			new Oferta => [
				dtOfertante = dtON
				dtReceptor = LigaMaster.instance.getPropietario( jugadorON)	
				monto = montoOfertado
				jugadorOfertado = jugadorON
				jugadoresOfrecidos = listaJugadores
			]
		)
	
		
		
	}
}
