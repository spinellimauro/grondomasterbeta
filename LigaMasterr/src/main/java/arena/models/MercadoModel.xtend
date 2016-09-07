package arena.models

import datos.SoFifa
import java.util.List
import java.util.Set
import master.DT
import master.Jugador
import master.LigaMaster
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class MercadoModel {
	DT dtON
	LigaMaster ligaMaster

	Jugador jugadorON
	String valorIngresado = ""

	List<Jugador> listaMaquina = newArrayList

	new(EquipoModel model) {
		dtON = model.dtON
		ligaMaster = model.ligaMaster
	}

	def Set<Jugador> getListaTransferibles() {
		val listaCompleta = ligaMaster.listaTransferibles
		listaCompleta.removeAll(dtON.getListaJugadores)
		listaCompleta
	}

	def void comprarJugador() {
		if (dtON.plata < jugadorON.precioVenta)
			throw new UserException("Dinero Insuficiente")

		jugadorON.propietario.venderJugador(jugadorON)
		dtON.comprarJugador(jugadorON, jugadorON.precioVenta)

		ObservableUtils.firePropertyChanged(this, "listaTransferibles")
		ObservableUtils.firePropertyChanged(this, "dtON")
	}

	def void buscar() {
		listaMaquina.clear
		listaMaquina.addAll(SoFifa.instance.getJugadores(valorIngresado))
		listaMaquina.removeAll(ligaMaster.listaJugadores)
	}

	def void comprarJugadorALaMaquina() {
		if (dtON.plata < jugadorON.precioMaquina)
			throw new UserException("Dinero Insuficiente")

		if (!listaMaquina.contains(jugadorON))
			throw new UserException("Ese jugador no es de la Máquina")

		dtON.comprarJugador(jugadorON, jugadorON.precioMaquina)
		listaMaquina.remove(jugadorON)

		ObservableUtils.firePropertyChanged(this, "dtON")
	}
}
