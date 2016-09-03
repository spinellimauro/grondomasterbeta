package master

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Partido {
	int numeroFecha
	DT dtLocal = new DT
	DT dtVisitante = new DT
	List<Jugador> golesLocal = newArrayList
	List<Jugador> golesVisitante = newArrayList

	override toString() {
		numeroFecha + "," + dtLocal.nombreDT + "," + dtVisitante.nombreDT + "," + 
		golesLocal.fold(":") [ acum , jugador |acum + jugador.id + ":"] + "," +
		golesVisitante.fold(":")[acum, jugador|acum + jugador.id + ":"]
	}
	
	def String getScore(){
		golesLocal.size + " - " + golesVisitante.size
	}
}
