import java.util.List

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class LigaMaster{
	static List<Dt> dts = newArrayList

	def static List<Jugador> getTransferibles() {
		dts.fold(newArrayList) [ acum, dt |
			acum.addAll(dt.enVenta)
			acum
		]
	}

	def static addDT(Dt dt) {
		dts.add(dt)
	}

	def static getDTsQuePagan() {
		dts.filter[torneosDisponibles == 0]
	}
	
	
}	


class Torneo{
	List<Fecha> listaFechas
	String nombreLiga
	List<Double> premios
	
	
}


class Fecha {
	List<Partido2> listaPartidos
}

@Accessors
class Partido2 {
	Dt equipoLocal
	
	Dt equipoVisitante
}
