package datos

import java.util.List
import master.Jugador
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
final class Precios {
	static Precios instance = new Precios
	
	List<PrecioNivel> listaNiveles = newArrayList(
		new PrecioNivel(76, 10000.0),
		new PrecioNivel(77, 10000.0),
		new PrecioNivel(78, 20000.0),
		new PrecioNivel(79, 30000.0),
		new PrecioNivel(80, 40000.0),
		new PrecioNivel(81, 55000.0),
		new PrecioNivel(82, 70000.0),
		new PrecioNivel(83, 85000.0),
		new PrecioNivel(84, 95000.0),
		new PrecioNivel(85, 115000.0),
		new PrecioNivel(86, 130000.0),
		new PrecioNivel(87, 150000.0),
		new PrecioNivel(88, 180000.0),
		new PrecioNivel(89, 220000.0),
		new PrecioNivel(90, 250000.0),
		new PrecioNivel(91, 300000.0),
		new PrecioNivel(92, 400000.0),
		new PrecioNivel(93, 500000.0),
		new PrecioNivel(94, 550000.0)
	)

	List<PrecioEvento> listaEventos = newArrayList(
		new PrecioEvento("Slot", 10000.0),
		new PrecioEvento("Victoria", 2000.0),
		new PrecioEvento("Gol", 1000.0),
		new PrecioEvento("Empate", 1000.0),
		new PrecioEvento("Impuesto", 10.0),
		new PrecioEvento("PrecioMaquina", 4)	
	)

	def double getPrecio(Jugador jugador) {
		val nivelJugador = jugador.nivel
		if(nivelJugador > 76) getPrecio(nivelJugador) else getPrecio(76)
	}

	def double getPrecio(int integer) {
		listaNiveles.findFirst[nivel == integer].precio
	}

	def double getPrecio(String string) {
		listaEventos.findFirst[evento.equals(string)].precio
	}

	def static getInstance() {
		instance
	}
}

@Observable
@Accessors
class PrecioNivel{
	int nivel
	double precio

	new(int integer, double valor) {
		nivel = integer
		precio = valor
	}
}

@Observable
@Accessors
class PrecioEvento{
	String evento
	double precio

	new(String string, double valor) {
		evento = string
		precio = valor
	}
}
