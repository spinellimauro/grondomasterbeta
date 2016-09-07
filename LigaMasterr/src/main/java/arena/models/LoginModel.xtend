package arena.models

import master.LigaMaster
import master.DT
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class LoginModel {
	LigaMaster ligaMaster
	DT dtON
	
	new() {
		ligaMaster = new LigaMaster("test")
		ligaMaster.leerBase
		dtON = ligaMaster.listaDTs.get(0)
	}
}
