package arena.models

import master.LigaMaster
import master.DT
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils

@Observable
@Accessors
class LoginModel {
	LigaMaster ligaMaster = LigaMaster.instance
	DT dtON
	String dtNuevo
	String dtEquipo
	
	new() {
		LigaMaster.instance.leerBase
	}
	
	def crearDT() {
		LigaMaster.instance.crearDT(dtNuevo,dtEquipo)
		ObservableUtils.firePropertyChanged(this, "ligaMaster")
	}
	
}
