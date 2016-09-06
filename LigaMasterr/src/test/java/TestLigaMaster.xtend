import master.LigaMaster
import org.junit.Assert
import org.junit.Before
import org.junit.Test

import static extension adapter.JSONTransformer.*
import static extension adapter.JSONAdapter.*

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

	@Test
	def void toJson() {
		println(grondomaster.listaTorneos.get(0).toJSON.toTorneo)
	}
}
