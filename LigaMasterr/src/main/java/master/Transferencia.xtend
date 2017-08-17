package master

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Transferencia {
	DT dtCompra
	DT dtVende
	double monto
	Jugador jugadorComprado
}