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

	def List<Jugador> getJugadores() {
		dts.fold(newArrayList) [ lista, dt |
			lista.addAll(dt.jugadores)
			lista
		]
	}

	def List<Jugador> getTransferibles() {
		jugadores.filter[precioVenta != 0].toList
	}
	
	def void leerBase(){
		val readerDts = new FileReader("src/main/java/datos/txts/dts.txt").readLines
		dts = readerDts.map[ toDT ].toList
	}
	
	def void guardarBase() {
		val PrintWriter writerJugadores = new PrintWriter("src/main/java/datos/txts/jugadores.txt", "UTF-8")
		jugadores.forEach[writerJugadores.println(toString)]
		writerJugadores.close
				
		val PrintWriter writerDTs = new PrintWriter("src/main/java/datos/txts/dts.txt", "UTF-8")
		dts.forEach[writerDTs.println(toString)]
		writerDTs.close
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
	DT dtLocal
	DT dtVisitante
}
