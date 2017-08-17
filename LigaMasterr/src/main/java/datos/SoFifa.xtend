package datos

import master.Jugador
import org.eclipse.xtend.lib.annotations.Accessors
import org.jsoup.Jsoup

//@Observable ARENA APP
@Accessors
final class SoFifa {
	static SoFifa instance = new SoFifa

	private new() {}

	def getJugadores(String string) {
		val document = Jsoup.connect("http://sofifa.com/players?keyword=" + string + "&layout=2017desktop&hl=es-ES").userAgent("Mozilla").post
		val tabla = document.select("tbody > tr")

		tabla.map [
			var jugador = new Jugador

			val data = select("td")
			jugador.nombre = data.get(0).select("a").text
			jugador.id = Integer::parseInt(data.select("img").attr("id"))
			jugador.nacionalidad = data.get(1).select("a > span ").attr("title")
			jugador.posiciones = newArrayList(data.get(2).select("span").map[text])
			jugador.nivel = Integer::parseInt(data.get(6).text)
			jugador.potencial = Integer::parseInt(data.get(7).text)

			jugador
		]
	}

	
	
	def getEquipos(String string) {
		val document = Jsoup.connect("http://sofifa.com/teams?keyword=" + string).userAgent("Mozilla").post
		val tabla = document.select("tbody > tr > td > a[href*=team]")
		
		tabla.map[
			val equipo = new Equipo
			
			equipo.id = Integer::parseInt(it.attr("href").replaceAll("[^\\d-]", ""))
			equipo.nombre = it.text
			
			equipo
		]
	}

	def static SoFifa getInstance() {
		instance
	}
}

@Accessors
class Equipo{
	int id
	String nombre
}