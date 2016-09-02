package master

import java.io.FileReader
import java.io.PrintWriter
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

import static extension com.google.common.io.CharStreams.*
import static extension datos.adapters.DTAdapter.*

@Observable
@Accessors
class LigaMaster {
	List<DT> dts = newArrayList

	new() {
		leerBase
	}

	def List<Jugador> getJugadores() {
		dts.fold(newArrayList) [ lista, dt |
			lista.addAll(dt.jugadores)
			lista
		]
	}

	def List<Jugador> getTransferibles() {
		jugadores.filter[precioVenta != 0].toList
	}

	def void leerBase() {
		val readerDts = new FileReader("src/main/java/datos/txts/dts.txt").readLines
		dts.addAll( readerDts.map[toDT])
	}

	def void guardarBase() {
		val PrintWriter writerDTs = new PrintWriter("src/main/java/datos/txts/dts.txt", "UTF-8")
		dts.forEach[writerDTs.println(toString)]
		writerDTs.close

		val PrintWriter writerJugadores = new PrintWriter("src/main/java/datos/txts/jugadores.txt", "UTF-8")
		jugadores.forEach[writerJugadores.println(toString)]
		writerJugadores.close
	}

	def List<DT> getDTsQuePagan() {
		dts.filter[torneosDisponibles == 0].toList
	}

}

@Accessors
class Torneo {
	// List<Fecha> listaFechas
	List<Partido> partidos = newArrayList
	String nombreLiga
	List<Double> premios
	List<DT> jugadores = newArrayList

	int i

	def void agregarJugador(DT jugador) {
		jugadores.add(jugador)
		if (hayMasDe1Jugador) {
			for (i = jugadores.size - 2; i >= 0; i--) {
				partidos.add(new Partido => [
					dtLocal = jugadores.get(jugadores.size - 1)
					dtVisitante = jugadores.get(i)
				])
			}

		}
	}

	def hayMasDe1Jugador() {
		jugadores.size > 1
	}

}

//@Accessors
//class Fecha {
//	List<Partido> listaPartidos
//}
@Accessors
class Partido {
	DT dtLocal
	DT dtVisitante
	int golLocal
	int golVisitante
	
	
	def void jugarPartido(){
		if (golLocal > golVisitante){dtLocal.gano(golLocal - golVisitante)}
		else if (golLocal < golVisitante){dtVisitante.gano(golVisitante-golLocal)}
		else {
			dtLocal.empato
			dtVisitante.empato
		}	
	}
}

