package arena.models

import master.LigaMaster
import master.DT
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils
import java.util.List

@Observable
@Accessors
class LoginModel {
	DT dtON
	String dtNuevo = ""
	String dtEquipo = ""
	
	new() {
		LigaMaster.instance.leerBase
		dtON = listaDT.get(0)
	}
	
	def List<DT> getListaDT(){
		LigaMaster.instance.listaDT.sortBy[nombreDT]
	}
	
	def void crearDT() {
		LigaMaster.instance.crearDT(dtNuevo,dtEquipo)
		ObservableUtils.firePropertyChanged(this, "listaDT")
	}
	
}
