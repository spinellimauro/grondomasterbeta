package arena.windows

import org.uqbar.arena.windows.SimpleWindow
import arena.models.EquipoModel
import org.uqbar.arena.windows.WindowOwner
import arena.models.TorneoModel

class ImpuestosWindow extends SimpleWindow<EquipoModel> {
	new(WindowOwner owner, TorneoModel ) {
		super(owner, new EquipoModel(model))
		title = "Equipos"
	}

	
}