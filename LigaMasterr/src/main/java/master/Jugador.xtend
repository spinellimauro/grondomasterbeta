package master

import org.eclipse.xtend.lib.annotations.Accessors
import org.jsoup.Jsoup
import org.uqbar.commons.utils.Observable
import datos.Precios

@Observable
@Accessors
class Jugador {
	int id
	String nombre
	int nivel
	int potencial

	Torneo torneo
	double precioVenta = 0
	int vecesNoPagadas = 0

	new(int integer) {
		id = integer
		update
	}

	new() {
	}

	def double getImpuesto() {
		val precios = torneo.precios
		precios.getPrecio(this) * (precios.getPrecio("Impuesto") / 100)
	}
	
	def getPrecioMaquina(){
		Precios.instance.getPrecio(this)
	}

	def void noSePago() {
		vecesNoPagadas++
	}

	def void pagar() {
		vecesNoPagadas = 0
	}

	def boolean getPagaImpuesto() {
		nivel > 82
	}

	def int getGoles() {
		torneo.getGoles(this)
	}

	def DT getPropietario() {
		torneo.getPropietario(this)
	}
	
	def void update() {
		val instance = Jsoup.connect("http://2016.sofifa.com/player/" + id).userAgent("Mozilla").get
		nombre = instance.select("div.header").text.replaceAll("[(\\d+.*)]", "").replace("ID:", "").replace("  ", "")
		nivel = Integer.parseInt(instance.select("span.p").get(0).text)
		potencial = Integer.parseInt(instance.select("span.p").get(1).text)
	}

	override toString() {
		id + ";" + nombre + ";" + nivel + ";" + potencial + ";" + precioVenta + ";" + vecesNoPagadas
	}

	override equals(Object obj) {
		if(obj == null) return false
		if(!Jugador.isAssignableFrom(obj.class)) return false

		val otroJugador = obj as Jugador
		if(id != otroJugador.id) return false else true
	}

	override hashCode() { id }
}
