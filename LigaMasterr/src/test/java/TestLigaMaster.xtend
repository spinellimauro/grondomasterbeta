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
	Nivel78 n78
	Nivel79 n79
	Nivel80 n80
	
	
	@Before
	def void init() {
		
		n78 = new Nivel78
		n79 = new Nivel79
		n80 = new Nivel80
		
		mustafi = new Jugador =>[
			nombre = "Mustafi"
			nivel = n80
		]
		
		lacazette = new Jugador =>[
			nombre = "Lacazette"
			nivel = n78
		]

		rulli = new Jugador=>[
		nombre = "rulli"
		nivel = n79
		]
		
		martial = new Jugador=>[
			nombre = "Martial"
			nivel = n78
		]
		
		ale = new Dt =>[
			nombreDt = "Alejandro"
			equipo = "Dortmund"
			jugadores =>[
				add(mustafi)
				add(lacazette)
			]
		]
		
		mauro = new Dt => [
			nombreDt = "Mauro"
			equipo = "Bourdeaux"
			jugadores.add(rulli)
		]
		
		nicoR = new Dt =>[
			nombreDt = "NicoR"
			equipo = "Rotterham"
			jugadores.add(martial)
		]
		
		
		grondomaster = new LigaMaster =>[
			dts.addAll(#{mauro,ale,nicoR})
		]
		
		ale.ponerEnVentaUnJugador(mustafi,10000)
		mauro.ponerEnVentaUnJugador(rulli,5000)		
		
	}

	@Test
	def void verificarJugadorEnVentaDT(){
		Assert.assertTrue(ale.jugadores.size > 0 )	
	}
	@Test 
	def void verificarDTS(){
		Assert.assertEquals(3,grondomaster.dts.size)
	}
	@Test
	def void verificarJugadoresEnVenta(){
		Assert.assertEquals(2,grondomaster.jugadoresVendiendose.size)
	}
	
}

