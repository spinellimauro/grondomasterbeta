package datos

import java.util.Map
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.uqbar.commons.utils.Observable

@Accessors
class PremiosTorneos {
	Integer cantPremios = 4
	List<PremioEvento> listaEventos = newArrayList(
		new PremioEvento("Victoria", 2000.0),
		new PremioEvento("Gol", 1000.0),
		new PremioEvento("Empate", 1000.0)
	)
	
	List<PremioPosicion> listaNiveles = newArrayList(
		new PremioPosicion(1, 40000.0),
		new PremioPosicion(2, 30000.0),
		new PremioPosicion(3, 20000.0),	
		new PremioPosicion(4, 10000.0)	
	)
	
	def double getPremioEvento(String string) {
		listaEventos.findFirst[evento.equals(string)].precio
	}
	
	def double getPremio(Integer posicion) {
		listaEventos.findFirst[evento.equals(posicion)].precio
	}
	
	def crearPremio(double premio){
		listaNiveles.add(new PremioPosicion(listaNiveles.size + 1, premio))
	}
	
	
}

@Observable
@Accessors
class PremioEvento{
	String evento
	double precio

	new(String string, double valor) {
		evento = string
		precio = valor
	}
}

@Observable
@Accessors
class PremioPosicion{
	int nivel
	double precio

	new(int integer, double valor) {
		nivel = integer
		precio = valor
	}
}