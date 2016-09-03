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
		Assert.assertEquals(12, grondomaster.listaJugadores.size)
	}

	@Test
	def void verificarJugadoresEnVenta() {
		Assert.assertEquals(2, grondomaster.listaTransferibles.size)
	}

}
