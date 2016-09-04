package master

import java.io.File
import java.io.FileReader
import java.io.PrintWriter
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

import static extension com.google.common.io.CharStreams.*

@Observable
@Accessors
class LigaMaster {
	String nombreLiga
	List<Jugador> listaJugadores = newArrayList
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

	def List<Jugador> getListaTransferibles() {
		listaJugadores.filter[precioVenta != 0].toList
	}

	def List<DT> getDTsQuePagan() {
		listaDTs.filter[torneosDisponibles == 0].toList
	}

	def void crearBase() {
		new File(dirDTs).createNewFile
		new File(dirJugadores).createNewFile
		new File(dirTorneos).createNewFile
	}

	def void leerBase() {
		val readerJugadores = new FileReader(dirJugadores).readLines
		listaJugadores.addAll( readerJugadores.map[toJugador])
		
		val readerDts = new FileReader(dirDTs).readLines
		listaDTs.addAll( readerDts.map[toDT])

		val readerTorneos = new FileReader(dirTorneos).readLines
		listaTorneos.addAll( readerTorneos.map[toTorneo])
	}

	def void guardarBase() {
		val PrintWriter writerDTs = new PrintWriter(dirDTs, "UTF-8")
		listaDTs.forEach[writerDTs.println(toString)]
		writerDTs.close

		val PrintWriter writerJugadores = new PrintWriter(dirJugadores, "UTF-8")
		listaJugadores.forEach[writerJugadores.println(toString)]
		writerJugadores.close

		val PrintWriter writerTorneo = new PrintWriter(dirTorneos, "UTF-8")
		listaTorneos.forEach[writerTorneo.println(toString)]
		writerTorneo.close
	}

	def DT toDT(String string) {
		val textoDT = string.split(";").iterator
		new DT => [
			nombreDT = textoDT.next
			nombreEquipo = textoDT.next
			plata = Double.parseDouble(textoDT.next)
			torneosDisponibles = Integer.parseInt(textoDT.next)
			slots = Integer.parseInt(textoDT.next)
			textoDT.next.split("-").forEach[s|if(s != null) jugadores.add(getJugador(s))]
		]
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

	def Jugador getJugador(String idText) {
		val idInt = Integer.parseInt(idText)
		listaJugadores.findFirst[id == idInt]
	}

	def Torneo toTorneo(String string) {
		val readerTorneo = string.split(";").iterator

		val torneo = new Torneo
		torneo.nombreTorneo = readerTorneo.next
		torneo.listaParticipantes.addAll( readerTorneo.next.split("-").map[getDT])
		torneo.listaPartidos.addAll(readerTorneo.next.split("-").map[toPartido])
		torneo
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

	def DT getDT(String string) {
		listaDTs.findFirst[nombreDT.equals(string)]
	}

}
