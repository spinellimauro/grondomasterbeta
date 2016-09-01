import org.eclipse.xtend.lib.annotations.Accessors
import org.jsoup.nodes.Document
import org.jsoup.Jsoup
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Jugador {
	Double precioVenta = null
	int vecesNoPagadas = 0

	def double getPrecioMaquina() {
		nivel * 10000
	}

	def void setPrecioVenta(double precio) {
		precioVenta = precio
	}

	def double getImpuesto() {
		getPrecioMaquina * 0.10
	}

	def void noSePago() {
		vecesNoPagadas++
	}

	def void pagar() {
		vecesNoPagadas = 0
	}
	
	def pagaImpuesto() {
		nivel > 82
	}
	
		int id

	def Document getInstance() {
		Jsoup.connect("http://2016.sofifa.com/player/" + id).userAgent("Mozilla").post
	}

	def String getNombre() {
		instance.select("div.header").text.replaceAll("[(ID:\\d+)]", "").toString
	}

	def int getNivel() {
		Integer.parseInt(instance.select("span.p").get(0).text.toString)
	}

	def int getPotencial() {
		Integer.parseInt(instance.select("span.p").get(1).text.toString)
	}
	
}