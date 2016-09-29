package datos

import java.util.Map
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class PremiosTorneos {
	Integer cantPremios
	Map<Integer, Double> mapaPosiciones = newHashMap(
		1 -> 40000.0,
		2 -> 30000.0,
		3 -> 20000.0,
		4 -> 10000.0
	)
	
	def double getPremio(Integer posicion) {
		mapaPosiciones.get(posicion)
	}
	
}