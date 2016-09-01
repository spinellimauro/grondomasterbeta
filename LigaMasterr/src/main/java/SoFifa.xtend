import org.eclipse.xtend.lib.annotations.Accessors
import org.jsoup.Jsoup
import org.jsoup.nodes.Document
import org.jsoup.nodes.Element
import java.util.List
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
final class SoFifa {
	static SoFifa instance = new SoFifa

	private new() {
	}

	def List<Jugador> getJugadores(String string) {
		val Document document = Jsoup.connect("http://2016.sofifa.com/players?keyword=" + string).userAgent("Mozilla").post

		val nombres = document.select("td[data-title='Name']").select("a[href]")

		val jugadores = newArrayList

		for (Element jugador : nombres) {

			jugadores.add(new Jugador => [
				id = Integer.parseInt(jugador.attr("abs:href").replace("http://2016.sofifa.com/player/", ""))
			])
		}

		jugadores
	}

	def static SoFifa getInstance() { instance }
}