package master

import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import adapter.JSONAdapter
import adapter.JSONTransformer
import java.util.List

@Observable
@Accessors
class LigaMaster {
	static LigaMaster instance
	List<Torneo> listaTorneos = newArrayList
	List<DT> listaDT = newArrayList
	List<Jugador> listaJugador = newArrayList

	private new() {}

	def Set<DT> getDTsQuePagan() {
		listaDT.filter[torneosDisponibles == 0].toSet
	}

	def Set<Jugador> getListaTransferibles() {
		listaJugador.filter[precioVenta > 0].toSet
	}

	def void leerBase() {
		listaDT.clear
		listaTorneos.clear
		listaJugador.clear
		JSONAdapter.leerBase
	}

	def void guardarBase() {
		JSONTransformer.guardarBase
	}

	def void addTorneo(Torneo torneo) {
		listaTorneos.add(torneo)
	}

	def void removeTorneo(Torneo torneo) {
		listaTorneos.remove(torneo)
	}

	def static getInstance() {
		if(instance == null) instance = new LigaMaster
		instance
	}
}
