package master

import java.io.File
import java.io.FileReader
import java.io.PrintWriter
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

import static extension com.google.common.io.CharStreams.*
import static extension adapter.JSONTransformer.*
import static extension adapter.JSONAdapter.*
import java.util.Set

@Observable
@Accessors
class LigaMaster {
	String nombreLiga
	List<Torneo> listaTorneos = newArrayList
	String dirDTs
	String dirJugadores
	String dirTorneos

	new(String string) {
		nombreLiga = string
		dirDTs = "data/" + nombreLiga + ".dts.txt"
		dirJugadores = "data/" + nombreLiga + ".jugadores.txt"
		dirTorneos = "data/" + nombreLiga + ".torneos.txt"
	}

	def List<DT> getDTsQuePagan() {
		listaDTs.filter[fechasDisponibles == 0].toList
	}

	def List<DT> getListaDTs() {
		listaTorneos.map[listaParticipantes].flatten.toList
	}

	def Set<Jugador> getListaJugadores() {
		listaDTs.map[jugadores].flatten.toSet
	}

	def void crearBase() {
		new File(dirDTs).createNewFile
		new File(dirJugadores).createNewFile
		new File(dirTorneos).createNewFile
	}

	def void leerBase() {
		setListaJugador(new FileReader(dirJugadores).readLines)
		setListaDT(new FileReader(dirDTs).readLines)
		listaTorneos.addAll( new FileReader(dirTorneos).readLines.map[toTorneo])

	}

	def void guardarBase() {
		crearBase
		val PrintWriter writerDTs = new PrintWriter(dirDTs)
		listaTorneos.forEach[listaParticipantes.forEach[writerDTs.println(toJSON)]]
		writerDTs.close

		val PrintWriter writerJugadores = new PrintWriter(dirJugadores)
		listaTorneos.forEach[t|t.listaJugadores.forEach[writerJugadores.println(toJSON)]]
		writerJugadores.close

		val PrintWriter writerTorneo = new PrintWriter(dirTorneos)
		listaTorneos.forEach[writerTorneo.println(toJSON)]
		writerTorneo.close
	}
}
