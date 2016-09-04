package arena.models

import java.util.List
import master.LigaMaster
import master.Partido
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class TorneoModel {
	LigaMaster grondomaster
	Integer fechaSeleccionada = 1
	Torneo torneoSeleccionado
	Partido partido
	String nombreIngresado

	new() {
		grondomaster = new LigaMaster("test")
		grondomaster.leerBase
		torneoSeleccionado = grondomaster.listaTorneos.get(0)
		torneoSeleccionado.listaParticipantes.forEach[jugadores.forEach[torneo = torneoSeleccionado]]
		torneoSeleccionado.listaParticipantes.forEach[torneo = torneoSeleccionado]
	}

	def void setTorneoSeleccionado(Torneo torneo) {
		fechaSeleccionada = 1
		torneoSeleccionado = torneo
		ObservableUtils.firePropertyChanged(this, "listaFechas")
	}
	
	@Dependencies("fechaSeleccionada")
	def List<Partido> getFecha() {
		torneoSeleccionado.getFecha(fechaSeleccionada)
	}

	def List<Integer> getListaFechas() {
		(1 .. torneoSeleccionado.numeroFechas).toList
	}

	def void sortearFixture() {
		torneoSeleccionado.sortearFechas
		ObservableUtils.firePropertyChanged(this, "fecha")
	}

	def void crearTorneo() {
		val torneoNuevo = new Torneo
		torneoNuevo.nombreTorneo = nombreIngresado
		torneoNuevo.listaParticipantes.forEach[jugadores.forEach[torneo = torneoNuevo]]

		grondomaster.listaTorneos.add(torneoNuevo)
	}

	def void borrarTorneo() {
		val torneoABorrar = torneoSeleccionado
		torneoSeleccionado = new Torneo
		grondomaster.listaTorneos.remove(torneoABorrar)
	}
}
