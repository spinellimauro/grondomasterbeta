package arena.models

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import master.DT
import master.Jugador
import java.util.List
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Dependencies

@Observable
@Accessors
class ImpuestoModel {
	DT dtAgregado
	Jugador jugadorSeleccionado
	Jugador jugadorSeleccionadoAPagar
	List<Jugador> jugadoresAPagar = newArrayList
	List<Jugador> jugadores = newArrayList
	Double suma
	
	new(TorneoConfigModel model) {
		dtAgregado = model.dt
	}
	
	
	def getJugadores(){
		dtAgregado.jugadoresConImpuesto
	}
	
	def void agregarAPagar(){
		jugadoresAPagar.add(jugadorSeleccionado)
		jugadores.remove(jugadorSeleccionado)
		ObservableUtils.firePropertyChanged(this,"jugadores")
		ObservableUtils.firePropertyChanged(this,"jugadoresAPagar")
	}
	
	def void removerAPagar(){
		jugadoresAPagar.remove(jugadorSeleccionadoAPagar)
		jugadores.add(jugadorSeleccionadoAPagar)
		ObservableUtils.firePropertyChanged(this,"jugadores")
		ObservableUtils.firePropertyChanged(this,"jugadoresAPagar")
	}
	
	def pagarImpuestos(){
		
	}
}