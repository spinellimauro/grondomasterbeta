import org.junit.Before
import org.junit.Test
import org.junit.Assert

class TestLigaMaster {
	LigaMaster grondomaster

	Dt mauro
	Dt nicoR
	Dt ale
	Jugador mustafi
	Jugador lacazette
	Jugador rulli
	Jugador martial

	@Before
	def void init() {
		mustafi = new Jugador(192227)
		lacazette = new Jugador(193301)
		rulli = new Jugador(215316)
		martial = new Jugador(211300)

		ale = new Dt => [
			nombreDt = "Alejandro"
			equipo = "Dortmund"
			jugadores => [
				add(mustafi)
				add(lacazette)
			]
		]

		mauro = new Dt => [
			nombreDt = "Mauro"
			equipo = "Bourdeaux"
			jugadores.add(rulli)
		]

		nicoR = new Dt => [
			nombreDt = "NicoR"
			equipo = "Rotterham"
			jugadores.add(martial)
		]

		grondomaster = new LigaMaster => [
			dts.addAll(#{mauro, ale, nicoR})

		]

		ale.venderJugador(mustafi, 10000)
		mauro.venderJugador(rulli, 5000)
	}

	@Test
	def void verificarJugadorEnVentaDT() {
		Assert.assertTrue(ale.jugadores.size > 0)
	}

	@Test
	def void verificarDTS() {
		Assert.assertEquals(3, grondomaster.dts.size)
	}

	@Test
	def void verificarJugadoresEnVenta() {
		Assert.assertEquals(2, grondomaster.transferibles.size)
	}
	
	@Test
	def void verificarPreciosJugadores() {
		Assert.assertEquals(70000, PreciosNivel.instance.getPrecio(mustafi),0)
		Assert.assertEquals(85000, PreciosNivel.instance.getPrecio(lacazette),0)
		Assert.assertEquals(30000, PreciosNivel.instance.getPrecio(rulli),0)
		Assert.assertEquals(20000, PreciosNivel.instance.getPrecio(martial),0)
	}

}
