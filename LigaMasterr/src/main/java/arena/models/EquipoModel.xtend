package arena.models

import datos.Precios
import datos.SoFifa
import java.util.List
import master.DT
import master.Jugador
import master.LigaMaster
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Dependencies

@Observable
@Accessors
class EquipoModel {
	Torneo torneoON
	DT dtActivo
	DT dtON
	Jugador jugadorON = new Jugador

	String textoBusqueda = ""
	List<Jugador> listaMaquina = newArrayList

	new(TorneoModel model) {
		torneoON = model.torneoON
		dtActivo = model.dtON
		dtON = model.dtON
	}

	def void validar() {
		if (jugadorON == null)
			throw new UserException("Debe seleccionar un jugador")
	}

	def void validarOfertar() {
		validar
		
		if (dtActivo.listaJugadores.contains(jugadorON))
			throw new UserException("Ese jugador es tuyo")
		
		if (listaMaquina.contains(jugadorON))
			throw new UserException("Ese jugador es de la Máquina")
	}

	def List<DT> getListaDT() {
		LigaMaster.instance.listaDT.sortBy[nombreDT]
	}

	@Dependencies("jugadorON")
	def boolean getJugadorPropio() {
		dtActivo.listaJugadores.contains(jugadorON)
	}

	def void comprarSlot() {
		try
			dtActivo.comprarSlot
		catch (Exception e)
			throw new UserException(e.message)
	}

	def void venderAMaquina() {
		try
			dtActivo.venderJugador(jugadorON, jugadorON.precioMaquina / Precios.instance.getPrecio("PrecioMaquina"))
		catch (Exception e)
			throw new UserException(e.message)
	}

	// Armado de Equipo
	def void transferIn() {
		jugadorON.propietario.removeJugador(jugadorON)
		dtON.addJugador(jugadorON)
		listaMaquina.remove(jugadorON)

		ObservableUtils.firePropertyChanged(this, "listaMaquina")
		ObservableUtils.firePropertyChanged(this, "dtON")
	}

	def void transferOut() {
		listaMaquina.add(jugadorON)
		dtON.removeJugador(jugadorON)

		ObservableUtils.firePropertyChanged(this, "listaMaquina")
		ObservableUtils.firePropertyChanged(this, "dtON")
	}

	// Maquina
	def void buscar() {
		listaMaquina.clear
		listaMaquina.addAll(SoFifa.instance.getJugadores(textoBusqueda))
	}

	def void comprarAMaquina() {
		if (!listaMaquina.contains(jugadorON))
				throw new Exception("Ese jugador no es de la Máquina")

		if (!jugadorON.propietario.nombreDT.equals("Libre"))
				throw new Exception("Ese jugador no está Libre")
		
		try {
			val jugadorMaquina = jugadorON

			dtON.comprarJugador(jugadorMaquina, jugadorMaquina.precioMaquina)
			listaMaquina.remove(jugadorMaquina)
		} catch (Exception e)
			throw new UserException(e.message)
	}
}
