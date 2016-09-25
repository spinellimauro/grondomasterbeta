package master

import java.io.File
import java.io.FileReader
import java.io.PrintWriter
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

import static extension adapter.JSONAdapter.*
import static extension adapter.JSONTransformer.*
import static extension com.google.common.io.CharStreams.*

@Observable
@Accessors
class LigaMaster {
	String nombreLiga
	List<Torneo> listaTorneos = newArrayList
	List<DT> listaDTs = newArrayList
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
		listaDTs.filter[torneosDisponibles == 0].toList
	}

//	def List<DT> getListaDTs() {
//		listaTorneos.map[listaParticipantes].flatten.toList
//	}

	def Set<Jugador> getListaJugadores() {
		listaTorneos.map[listaJugadores].flatten.toSet
	}

	def Set<Jugador> getListaTransferibles() {
		listaJugadores.filter[precioVenta > 0].toSet
	}

	def void crearBase() {
		new File(dirDTs).createNewFile
		new File(dirJugadores).createNewFile
		new File(dirTorneos).createNewFile
	}

	def void leerBase() {
		setListaJugador(new FileReader(dirJugadores).readLines)
		listaDTs = setListaDT(new FileReader(dirDTs).readLines)
		listaTorneos.addAll( new FileReader(dirTorneos).readLines.map[toTorneo])
	}

	def void guardarBase() {
		val PrintWriter writerDTs = new PrintWriter(dirDTs)
		listaDTs.forEach[writerDTs.println(toJSON)]
		writerDTs.close

		val PrintWriter writerJugadores = new PrintWriter(dirJugadores)
		listaJugadores.forEach[writerJugadores.println(toJSON)]
		writerJugadores.close

		val PrintWriter writerTorneo = new PrintWriter(dirTorneos)
		listaTorneos.forEach[writerTorneo.println(toJSON)]
		writerTorneo.close
	}

	def void addTorneo(Torneo torneo) {
		listaTorneos.add(torneo)
	}

	def void removeTorneo(Torneo torneo) {
		listaTorneos.remove(torneo)
	}
}
