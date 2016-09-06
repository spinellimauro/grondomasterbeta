package adapter

import com.eclipsesource.json.Json
import java.util.List
import master.DT
import master.Jugador
import master.Partido
import master.Torneo

final class JSONAdapter {
	static List<Jugador> listaJugador = newArrayList
	static List<DT> listaDT = newArrayList

	def static void setListaJugador(List<String> listaString) {
		listaString.forEach [
			val jsonJugador = Json.parse(it).asObject

			listaJugador.add(
				new Jugador => [
					id = jsonJugador.get("id").asInt
					nombre = jsonJugador.get("nombre").asString
					nivel = jsonJugador.get("nivel").asInt
					potencial = jsonJugador.get("potencial").asInt
					precioVenta = jsonJugador.get("precio").asDouble
					vecesNoPagadas = jsonJugador.get("noPagadas").asInt
				]
			)
		]
	}

	def static void setListaDT(List<String> listaString) {
		listaString.forEach [
			val jsonDT = Json.parse(it).asObject

			listaDT.add(
				new DT => [
					nombreDT = jsonDT.get("nombre").asString
					nombreEquipo = jsonDT.get("equipo").asString
					plata = jsonDT.get("plata").asDouble
					slots = jsonDT.get("slots").asInt
					jsonDT.get("jugadores").asArray.forEach[s|addJugador(getJugador(s.asInt))]
					fechasDisponibles = jsonDT.get("fechas").asInt
				]
			)
		]
	}

	def static Torneo toTorneo(String string) {
		val jsonTorneo = Json.parse(string).asObject

		new Torneo => [
			nombreTorneo = jsonTorneo.get("torneo").asString
			jsonTorneo.get("dts").asArray.forEach[s|addDT(getDT(s.asString))]
			listaPartidos.addAll( jsonTorneo.get("partidos").asArray.map[toPartido(asString)])
			configTorneo
		]
	}

	def static toPartido(String string) {
		val jsonPartido = Json.parse(string).asObject

		new Partido => [
			numeroFecha = jsonPartido.get("fecha").asInt
			dtLocal = getDT(jsonPartido.get("local").asString)
			dtVisitante = getDT(jsonPartido.get("visitante").asString)
			golesLocal.addAll( jsonPartido.get("golesLocal").asArray.map[getJugador(asInt)])
			golesVisitante.addAll( jsonPartido.get("golesVisitante").asArray.map[getJugador(asInt)])
		]
	}

	def static getJugador(Integer integer) {
		listaJugador.findFirst[id == integer] ?: new Jugador
	}

	def static getDT(String string) {
		listaDT.findFirst[nombreDT.equals(string)] ?: new DT
	}
}
