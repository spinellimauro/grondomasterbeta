package datos.adapters

import master.DT
import master.Jugador
import java.util.List
import java.io.FileReader

import static extension com.google.common.io.CharStreams.*

final class DTAdapter {
	def static DT toDT(String string) {
		val textoDT = string.split(";").iterator
		new DT => [
			nombreDT = textoDT.next
			nombreEquipo = textoDT.next
			plata = Double.parseDouble(textoDT.next)
			torneosDisponibles = Integer.parseInt(textoDT.next)
			slots = Integer.parseInt(textoDT.next)
			jugadores = textoDT.next.split("-").map[id|JugadorAdapter.instance.getJugador(Integer.parseInt(id))].toList
		]
	}
}

final class JugadorAdapter {
	List<Jugador> listaJugadores = newArrayList
	static JugadorAdapter instance = new JugadorAdapter

	private new() {
		val readerJugadores = new FileReader("src/main/java/datos/txts/jugadores.txt").readLines
		listaJugadores = readerJugadores.map[toJugador]
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

	def Jugador getJugador(int idJugador) {
		listaJugadores.findFirst[id == idJugador]
	}

	def static getInstance() {
		instance
	}
}
