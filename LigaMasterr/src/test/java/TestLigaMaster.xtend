import master.DT
import master.LigaMaster
import master.Torneo
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestLigaMaster {
	LigaMaster grondomaster

	DT mauro
	DT nicoR
	DT ale
//	Jugador mustafi
//	Jugador lacazette
//	Jugador rulli
//	Jugador martial
	Torneo torneo

	@Before
	def void init() {
		grondomaster = new LigaMaster
		torneo = new Torneo
////		mustafi = new Jugador(192227)
//		lacazette = new Jugador(193301)
//		rulli = new Jugador(215316)
//		martial = new Jugador(211300)
		ale = new DT => [
			nombreDT = "Alejandro"
			nombreEquipo = "Dortmund"
			jugadores => [
//				add(mustafi)
//				add(lacazette)
			]
		]

		mauro = new DT => [
			nombreDT = "Mauro"
			nombreEquipo = "Bourdeaux"
//			jugadores.add(rulli)
		]

		nicoR = new DT => [
			nombreDT = "NicoR"
			nombreEquipo = "Rotterham"
//			jugadores.add(martial)
		]
//
		grondomaster = new LigaMaster => [
			dts.addAll(#{mauro, ale, nicoR})

		]
//
//		ale.venderJugador(mustafi, 10000)
//		mauro.venderJugador(rulli, 5000)
		grondomaster.leerBase

	}

//	@Test
//	def void verificarJugadorEnVentaDT() {
//		Assert.assertTrue(ale.jugadores.size > 0)
//	}
	@Test
	def void verificarDTS() {
		Assert.assertEquals(3, grondomaster.dts.size)
	}

	@Test
	def void verificarJugadores() {
		Assert.assertEquals(4, grondomaster.jugadores.size)
	}

	@Test
	def void verificarJugadoresEnVenta() {
		Assert.assertEquals(2, grondomaster.transferibles.size)
	}

//	@Test
//	def void verificarPreciosJugadores() {
//		grondomaster.guardarBase
//		Assert.assertEquals(70000, Precios.instance.getPrecio(mustafi), 0)
//		Assert.assertEquals(85000, Precios.instance.getPrecio(lacazette), 0)
//		Assert.assertEquals(30000, Precios.instance.getPrecio(rulli), 0)
//		Assert.assertEquals(20000, Precios.instance.getPrecio(martial), 0)
//	}
	@Test
	def void verificarTorneo() {
		torneo.agregarJugador(mauro)
		torneo.agregarJugador(nicoR)
		torneo.agregarJugador(ale)
		Assert.assertEquals(3, torneo.partidos.size())
		Assert.assertTrue(torneo.partidos.get(0).dtLocal == nicoR)
		Assert.assertTrue(torneo.partidos.get(0).dtVisitante == mauro)

		Assert.assertTrue(torneo.partidos.get(1).dtLocal == ale)
		Assert.assertTrue(torneo.partidos.get(1).dtVisitante == nicoR)

		Assert.assertTrue(torneo.partidos.get(2).dtLocal == ale)
		Assert.assertTrue(torneo.partidos.get(2).dtVisitante == mauro)
	}
}
