package master

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Oferta {
	DT dtOfertante
	DT dtReceptor
	Double monto
	Jugador jugadorAComprar
}