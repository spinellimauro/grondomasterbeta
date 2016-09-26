package adapter

import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import com.eclipsesource.json.WriterConfig
import java.io.PrintWriter
import master.DT
import master.Jugador
import master.LigaMaster
import master.Oferta
import master.Partido
import master.Torneo
import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Observable
@Accessors
final class JSONTransformer {
	def static void guardarBase() {
		var jsonTorneos = new JsonArray
		for (torneo : LigaMaster.instance.listaTorneos)
			jsonTorneos.add(torneo.toJSON)
		
		var PrintWriter printer = new PrintWriter("data/torneos.txt")
		jsonTorneos.writeTo(printer,WriterConfig.PRETTY_PRINT)
		printer.close

		var jsonJugadores = new JsonArray
		for (jugador : LigaMaster.instance.listaJugador)
			jsonJugadores.add(jugador.toJSON)
			
		printer = new PrintWriter("data/jugadores.txt")
		jsonJugadores.writeTo(printer,WriterConfig.PRETTY_PRINT)
		printer.close

		var jsonDts = new JsonArray
		for (dt : LigaMaster.instance.listaDT)
			jsonDts.add(dt.toJSON)
			
		printer = new PrintWriter("data/dts.txt")
		jsonDts.writeTo(printer,WriterConfig.PRETTY_PRINT)
		printer.close
	}

	def static toJSON(Jugador jugador) {
		new JsonObject => [
			add("id", jugador.id)
			add("nombre", jugador.nombre)
			add("nivel", jugador.nivel)
			add("potencial", jugador.potencial)
			add("precio", jugador.precioVenta)
			add("noPagadas", jugador.vecesNoPagadas)
		]
	}

	def static toJSON(DT dt) {
		new JsonObject => [
			add("nombre", dt.nombreDT)
			add("equipo", dt.nombreEquipo)
			add("plata", dt.plata)
			add("slots", dt.slots)
			add("ofertas", new JsonArray => [dt.ofertasRecibidas.map[toJSON].forEach[oferta|add(oferta)]])
			add("jugadores", new JsonArray => [dt.getListaJugadores.forEach[jugador|add(jugador.id)]])
			add("torneos", dt.torneosDisponibles)
		]
	}

	def static toJSON(Oferta oferta) {
		new JsonObject => [
			add("ofertante", oferta.dtOfertante.nombreDT)
			add("receptor", oferta.dtReceptor.nombreDT)
			add("monto", oferta.monto)
			add("jugador", oferta.jugadorOfertado.id)
			add("jugadoresOfertados", new JsonArray => [oferta.jugadoresOfrecidos.map[id].forEach[id|add(id)]])
		]
	}

	def static toJSON(Torneo torneo) {
		new JsonObject => [
			add("torneo", torneo.nombreTorneo)
			add("dts", new JsonArray => [torneo.listaParticipantes.forEach[dt|add(dt.nombreDT)]])
			add("partidos", new JsonArray => [torneo.listaPartidos.forEach[partido|add(partido.toJSON)]])
			add("limiteAmarillas", torneo.limiteAmarillas)
		]
	}

	def static toJSON(Partido partido) {
		new JsonObject => [
			add("fecha", partido.numeroFecha)
			add("local", partido.dtLocal.nombreDT)
			add("visitante", partido.dtVisitante.nombreDT)
			add("golesLocal", new JsonArray => [partido.golesLocal.forEach[jugador|add(jugador.id)]])
			add("golesVisitante", new JsonArray => [partido.golesVisitante.forEach[jugador|add(jugador.id)]])
			add("amarillas", new JsonArray => [partido.listaAmarillas.forEach[jugador|add(jugador.id)]])
			add("rojas", new JsonArray => [partido.listaRojas.forEach[jugador|add(jugador.id)]])
			add("terminado", partido.terminado)
		]
	}
}
