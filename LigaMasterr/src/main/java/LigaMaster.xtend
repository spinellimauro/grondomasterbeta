import java.util.List

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class LigaMaster {
	List<Dt> dts = newArrayList

	def List<Jugador> getTransferibles() {
		dts.fold(newArrayList) [ acum, dt |
			acum.addAll(dt.enVenta)
			acum
		]
	}

	def addDT(Dt dt) {
		dts.add(dt)
	}

	def getDTsQuePagan() {
		dts.filter[torneosDisponibles == 0]
	}

}

@Accessors
class Torneo {
	List<Fecha> listaFechas
	String nombreLiga
	List<Double> premios
}

@Accessors
class Fecha {
	List<Partido> listaPartidos
}

@Accessors
class Partido {
	Dt dtLocal
	Dt dtVisitante
}
