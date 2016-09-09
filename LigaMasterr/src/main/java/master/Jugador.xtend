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

	def double getImpuesto() {
		Precios.instance.getPrecio(this) * (Precios.instance.getPrecio("Impuesto") / 100)
	}

	def getPrecioMaquina() {
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

	def int getAmarillas() {
		torneo.getAmarillas(this)
	}

	def int getRojas() {
		torneo.getRojas(this)
	}

	def int getGoles() {
		torneo.getGoles(this)
	}

	def DT getPropietario() {
		torneo.getPropietario(this)
	}

	def void update() {
		val instance = Jsoup.connect("http://sofifa.com/player/199715").userAgent("Mozilla").post.select("td.text-center > span.label")
		nivel = Integer.parseInt(instance.get(0).text)
		potencial = Integer.parseInt(instance.get(1).text)
	}

	override equals(Object obj) {
		if (obj == null)
			return false
		if (!Jugador.isAssignableFrom(obj.class))
			return false

		val otroJugador = obj as Jugador
		if (id != otroJugador.id)
			return false
		else
			true
	}

	override hashCode() {
		id
	}
}
