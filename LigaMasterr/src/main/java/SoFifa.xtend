import org.eclipse.xtend.lib.annotations.Accessors
import org.jsoup.Jsoup
import org.jsoup.nodes.Document
import org.jsoup.nodes.Element
import java.util.List
import org.uqbar.commons.utils.Observable
import java.io.File
import java.io.FileWriter
import java.io.BufferedWriter
import java.io.PrintWriter

@Observable
@Accessors
final class SoFifa {
	static SoFifa instance = new SoFifa

	private new() {
	}

	def List<Jugador> getJugadores(String string) {
		var i = 0 as int
		val Document document = Jsoup.connect("http://2016.sofifa.com/players?keyword=" + string).userAgent("Mozilla").post

		val nombres = document.select("td[data-title='Name']").select("a[href]")

		val jugadores = newArrayList

		for (Element jugador : nombres) {

			jugadores.add(new Jugador => [
				id = Integer.parseInt(jugador.attr("abs:href").replace("http://2016.sofifa.com/player/", ""))
			])
		}
		
		val f = new File("nombres.txt")

	
		val w = new FileWriter(f)
		
		val bw = new BufferedWriter(w)
		
		val wr = new PrintWriter(bw)  
		wr.write("Jugadores")
		for(i=0;i<jugadores.size;i++){
			wr.append(jugadores.get(i).nombre)
		}
		bw.close()
 		
		jugadores
	}

	def static SoFifa getInstance() { instance }
	
	
	def void escribir(){

	
 } 
	
}