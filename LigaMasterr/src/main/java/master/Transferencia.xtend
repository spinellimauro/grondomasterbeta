package master

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Transferencia {
	DT dtCompra
	DT dtVende
	double monto
	Jugador jugadorComprado
}