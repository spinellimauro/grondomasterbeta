package adapter

import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonValue
import java.io.FileReader
import master.DT
import master.Jugador
import master.LigaMaster
import master.Oferta
import master.Partido
import master.Torneo

final class JSONAdapter {
	def static void leerBase() {
		val jsonJugadores = Json.parse(new FileReader("data/jugadores.txt")).asArray
		LigaMaster.instance.listaJugador.addAll(jsonJugadores.map[toJugador])

		val jsonDTs = Json.parse(new FileReader("data/dts.txt")).asArray
		LigaMaster.instance.listaDT.addAll(jsonDTs.map[toDT])

		val jsonTorneos = Json.parse(new FileReader("data/torneos.txt")).asArray
		LigaMaster.instance.listaTorneos.addAll(jsonTorneos.map[toTorneo])
	}

	def static Jugador toJugador(JsonValue jsonValue) {
		val jsonJugador = jsonValue.asObject
		
		new Jugador => [
			id = jsonJugador.get("id").asInt
			nombre = jsonJugador.get("nombre").asString
			nivel = jsonJugador.get("nivel").asInt
			potencial = jsonJugador.get("potencial").asInt
			precioVenta = jsonJugador.get("precio").asDouble
			vecesNoPagadas = jsonJugador.get("noPagadas").asInt
		]
	}

	def static DT toDT(JsonValue jsonValue) {
		val jsonDT = jsonValue.asObject
		
		new DT => [
			nombreDT = jsonDT.get("nombre").asString
			nombreEquipo = jsonDT.get("equipo").asString
			plata = jsonDT.get("plata").asDouble
			slots = jsonDT.get("slots").asInt
			torneosDisponibles = jsonDT.get("torneos").asInt

			listaJugadores.addAll(jsonDT.get("jugadores").asArray.map[getJugador(asInt)])
			ofertasRecibidas.addAll(jsonDT.get("ofertas").asArray.map[toOferta])
		]
	}

	def static toOferta(JsonValue jsonValue) {
		val jsonOferta = jsonValue.asObject

		new Oferta => [
			dtOfertante = getDT(jsonOferta.get("ofertante").asString)
			dtReceptor = getDT(jsonOferta.get("receptor").asString)
			monto = jsonOferta.get("monto").asDouble
			jugadorOfertado = getJugador(jsonOferta.get("jugador").asInt)

			jugadoresOfrecidos.addAll(jsonOferta.get("jugadoresOfertados").asArray.map[getJugador(asInt)])
		]
	}

	def static Torneo toTorneo(JsonValue jsonValue) {
		val jsonTorneo = jsonValue.asObject

		new Torneo => [
			nombreTorneo = jsonTorneo.get("torneo").asString
			limiteAmarillas = jsonTorneo.get("limiteAmarillas").asInt

			listaParticipantes.addAll( jsonTorneo.get("dts").asArray.map[getDT(asString)])
			listaPartidos.addAll( jsonTorneo.get("partidos").asArray.map[toPartido])

			configTorneo
		]
	}

	def static toPartido(JsonValue jsonValue) {
		val jsonPartido = jsonValue.asObject

		new Partido => [
			numeroFecha = jsonPartido.get("fecha").asInt
			dtLocal = getDT(jsonPartido.get("local").asString)
			dtVisitante = getDT(jsonPartido.get("visitante").asString)
			terminado = jsonPartido.get("terminado").asBoolean
			
			golesLocal.addAll( jsonPartido.get("golesLocal").asArray.map[getJugador(asInt)])
			golesVisitante.addAll( jsonPartido.get("golesVisitante").asArray.map[getJugador(asInt)])
			listaAmarillas.addAll(jsonPartido.get("amarillas").asArray.map[getJugador(asInt)])
			listaRojas.addAll(jsonPartido.get("rojas").asArray.map[getJugador(asInt)])
		]
	}

	def static getJugador(Integer integer) {
		LigaMaster.instance.listaJugador.findFirst[id == integer]
	}

	def static getDT(String string) {
		LigaMaster.instance.listaDT.findFirst[nombreDT.equals(string)]
	}
}
