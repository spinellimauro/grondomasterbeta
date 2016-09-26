package arena.models

import master.LigaMaster
import master.DT
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class LoginModel {
	LigaMaster ligaMaster = LigaMaster.instance
	DT dtON
	
	new() {
		LigaMaster.instance.leerBase
	}
}
