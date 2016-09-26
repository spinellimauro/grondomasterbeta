package arena.models

import java.util.List
import master.LigaMaster
import master.Partido
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable
import master.DT
import org.uqbar.commons.utils.Dependencies

@Observable
@Accessors
class TorneoModel {
	LigaMaster ligaMaster

	DT dtON
	Integer fechaON = 1
	Torneo torneoON = new Torneo
	String nombreNuevoTorneo
	
	Partido partido
	String nombreIngresado

	new(LoginModel loginModel) {
		ligaMaster = loginModel.ligaMaster
		dtON = loginModel.dtON
	}

	def void setTorneoON(Torneo torneo) {
		fechaON = 1
		torneoON = torneo
		ObservableUtils.firePropertyChanged(this, "fecha")
		ObservableUtils.firePropertyChanged(this, "listaFechas")
	}
	
	@Dependencies("fechaON")
	def List<Partido> getFecha() {
		torneoON.getFecha(fechaON)
		
	}
	
	def List<Integer> getListaFechas() {
		(1 .. torneoON.numeroFechas).toList
	}
	
	def void sortearFechas(){
		torneoON.sortearFechas
		ObservableUtils.firePropertyChanged(this,"fecha")
		ObservableUtils.firePropertyChanged(this,"listaFechas")
	}

	def void borrarTorneo() {
		ligaMaster.removeTorneo(torneoON)
	}
	
	def crearTorneo(){
		ligaMaster.addTorneo(new Torneo=>[nombreTorneo = nombreNuevoTorneo])
	}
}
