package master

import java.io.File
import java.io.FileReader
import java.io.PrintWriter
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

import static extension com.google.common.io.CharStreams.*
import java.util.Set

@Observable
@Accessors
class LigaMaster {
	String nombreLiga
	Set<Jugador> listaJugadores = newHashSet
	List<DT> listaDTs = newArrayList
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

	def void crearBase() {
		new File(dirDTs).createNewFile
		new File(dirJugadores).createNewFile
		new File(dirTorneos).createNewFile
	}

	def void leerBase() {
		val readerJugadores = new FileReader(dirJugadores).readLines
		listaJugadores.addAll( readerJugadores.filter[!nullOrEmpty].map[toJugador])

		val readerDts = new FileReader(dirDTs).readLines
		listaDTs.addAll( readerDts.map[toDT])

		val readerTorneos = new FileReader(dirTorneos).readLines
		listaTorneos.addAll( readerTorneos.map[toTorneo])
	}

	def void guardarBase() {
		crearBase
		val PrintWriter writerDTs = new PrintWriter(dirDTs)
		listaTorneos.forEach[listaParticipantes.forEach[writerDTs.println(toString)]]
		writerDTs.close

		val PrintWriter writerJugadores = new PrintWriter(dirJugadores)
		listaTorneos.forEach[ t | t.listaJugadores.forEach[writerJugadores.println(toString)]]
		writerJugadores.close

		val PrintWriter writerTorneo = new PrintWriter(dirTorneos)
		listaTorneos.forEach[writerTorneo.println(toString)]
		writerTorneo.close
	}

	def Jugador toJugador(String string) {
		val textoJugador = string.split(";").iterator
		new Jugador => [
			id = Integer.parseInt(textoJugador.next)
			nombre = textoJugador.next
			nivel = Integer.parseInt(textoJugador.next)
			potencial = Integer.parseInt(textoJugador.next)
			precioVenta = Double.parseDouble(textoJugador.next)
			vecesNoPagadas = Integer.parseInt(textoJugador.next)
		]
	}

	def DT toDT(String string) {
		val textoDT = string.split(";").iterator
		new DT => [
			nombreDT = textoDT.next
			nombreEquipo = textoDT.next
			plata = Double.parseDouble(textoDT.next)
			fechasDisponibles = Integer.parseInt(textoDT.next)
			slots = Integer.parseInt(textoDT.next)
			jugadores.addAll(textoDT.next.split("-").filter[!nullOrEmpty].map[getJugador])
		]
	}

	def Torneo toTorneo(String string) {
		val readerTorneo = string.split(";").iterator

		val torneoNuevo = new Torneo
		torneoNuevo.nombreTorneo = readerTorneo.next
		torneoNuevo.listaParticipantes.addAll( readerTorneo.next.split("-").map[getDT])
		torneoNuevo.listaParticipantes.forEach[torneo = torneoNuevo]
		torneoNuevo.listaJugadores.forEach[torneo = torneoNuevo]
		torneoNuevo.listaPartidos.addAll(readerTorneo.next.split("-").map[toPartido])
		torneoNuevo
	}

	def Partido toPartido(String string) {
		val readerPartido = string.split(",").iterator
		new Partido => [
			numeroFecha = Integer.parseInt(readerPartido.next)
			dtLocal = getDT(readerPartido.next)
			dtVisitante = getDT(readerPartido.next)
			readerPartido.next.split(":").forEach[s|if(s != "") golesLocal.add(getJugador(s))]
			readerPartido.next.split(":").forEach[s|if(s != "") golesVisitante.add(getJugador(s))]
		]
	}

	def Jugador getJugador(String idText) {
		val idInt = Integer.parseInt(idText)
		listaJugadores.findFirst[id == idInt]
	}

	def DT getDT(String string) {
		listaDTs.findFirst[nombreDT.equals(string)]
	}

}
