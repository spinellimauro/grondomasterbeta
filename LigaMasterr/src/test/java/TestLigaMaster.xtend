import master.LigaMaster
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestLigaMaster {
	LigaMaster grondomaster

	@Before
	def void init() {
		grondomaster = new LigaMaster("test")
		
		grondomaster.leerBase
	}

	@Test
	def void verificarDTs() {
		Assert.assertEquals(4, grondomaster.listaDTs.size)
	}

	@Test
	def void verificarJugadores() {
		Assert.assertEquals(14, grondomaster.listaJugadores.size)
	}
}
