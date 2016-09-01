import java.util.Map

final class PreciosNivel {
	static PreciosNivel instance = new PreciosNivel
	Map<Integer, Double> mapaPrecios = newHashMap(
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

	def double getPrecio(Jugador jugador) {
		mapaPrecios.get(jugador.nivel)
	}

	def static getInstance() {
		instance
	}
}
