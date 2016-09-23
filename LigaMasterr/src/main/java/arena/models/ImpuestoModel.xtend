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
	double suma = 0
	boolean habilitado = true
	TorneoConfigModel modelo
	
	new(TorneoConfigModel model) {
		dtAgregado = model.dt
		agregarJugadores
		modelo = model
	}
	
	
	def agregarJugadores(){
		jugadores = dtAgregado.jugadoresConImpuesto
	}
	
	def void agregarAPagar(){
		jugadoresAPagar.add(jugadorSeleccionado)
		jugadores.remove(jugadorSeleccionado)
		actualizar
	}
	
	def void removerAPagar(){
		jugadores.add(jugadorSeleccionadoAPagar)
		jugadoresAPagar.remove(jugadorSeleccionadoAPagar)
		actualizar
	}
	
	def pagarImpuestos(){
		dtAgregado.pagarImpuesto(jugadoresAPagar)
	}
	
	def actualizar(){
		sumaImpuestos
		ObservableUtils.firePropertyChanged(this,"suma")
		ObservableUtils.firePropertyChanged(this,"jugadoresAPagar")
		ObservableUtils.firePropertyChanged(this,"jugadores")
	}
	
	def sumaImpuestos(){
		suma = jugadoresAPagar.fold(0d)[acum , Jugador| acum + Jugador.getImpuesto]
	}
	
	def deshabilitar(){
		habilitado = false
	}
	
}