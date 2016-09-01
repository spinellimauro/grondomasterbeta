import java.io.BufferedWriter
import java.io.File
import java.io.FileWriter
import java.io.PrintWriter
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.jsoup.Jsoup
import org.jsoup.nodes.Document
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
final class SoFifa {
	static SoFifa instance = new SoFifa

	private new() {
	}

	def List<Jugador> getJugadores(String string) {
		val Document document = Jsoup.connect("http://2016.sofifa.com/players?keyword=" + string).userAgent("Mozilla").
			post

		val listaJugadores = document.select("td[data-title='Name']").select("a[href]")

		val jugadores = listaJugadores.fold(newArrayList) [ lista, jugador |
			lista.add(
				new Jugador(Integer.parseInt(jugador.attr("abs:href").replace("http://2016.sofifa.com/player/", ""))))
			lista
		].toList

		val f = new File("nombres.txt")
		val w = new FileWriter(f)
		val bw = new BufferedWriter(w)
		val wr = new PrintWriter(bw)
		
		jugadores.forEach[w.append(toString)]
		bw.close()

		jugadores

	}

	def static SoFifa getInstance() { instance }

	def void escribir() {}

}
