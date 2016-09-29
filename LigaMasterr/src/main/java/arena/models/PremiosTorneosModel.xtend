package arena.models

import master.Torneo
import master.DT

class PremiosTorneosModel {
	Torneo torneoON
	DT dtON
	
	new(TorneoModel model) {
		torneoON = model.torneoON
		dtON = model.dtON
	}
	
	
}