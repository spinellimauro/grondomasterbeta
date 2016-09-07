package arena.models

import java.util.List
import master.DT
import master.Jugador
import master.LigaMaster
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class EquipoModel {
	LigaMaster ligaMaster
	Torneo torneoON
	DT dtON

	DT dtElegido
	Jugador jugadorON
	String valorIngresado

	new(TorneoModel model) {
		ligaMaster = model.ligaMaster
		torneoON = model.torneoON
		dtON = model.dtON
		dtElegido = listaEquipos.get(0)
	}

	def validar() {
		if (dtElegido == null)
			throw new UserException("Debe seleccionar un usuario")

		if (jugadorON == null)
			throw new UserException("Debe seleccionar un jugador")
	}

	def List<DT> getListaEquipos() {
		val listaDTs = ligaMaster.listaDTs
		listaDTs.remove(dtON)
		listaDTs
	}
}
