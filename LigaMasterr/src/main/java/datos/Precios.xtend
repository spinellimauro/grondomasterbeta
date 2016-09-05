package datos

import java.util.Map
import master.Jugador

final class Precios {
	Map<Integer, Double> mapaNiveles = newHashMap(
		77 -> 10000.0,
		78 -> 20000.0,
		79 -> 30000.0,
		80 -> 40000.0,
		81 -> 55000.0,
		82 -> 70000.0,
		83 -> 85000.0,
		84 -> 95000.0,
		85 -> 115000.0,
		86 -> 130000.0,
		87 -> 150000.0,
		88 -> 180000.0,
		89 -> 220000.0,
		90 -> 250000.0,
		91 -> 300000.0,
		92 -> 400000.0,
		93 -> 500000.0,
		94 -> 550000.0
	)

	Map<String, Double> mapaPrecios = newHashMap(
		"Slot" -> 10000.0,
		"Victoria" -> 2000.0,
		"Gol" -> 1000.0,
		"Empate" -> 1000.0,
		"Impuesto" -> 10.0
	)

	def double getPrecio(Jugador jugador) {
		mapaNiveles.get(jugador.nivel)
	}

	def double getPrecio(String string) {
		mapaPrecios.get(string)
	}
}
