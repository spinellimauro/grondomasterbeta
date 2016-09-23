package arena.models

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import datos.Precios

@Observable
@Accessors
class ReglasModel {
	Integer nivel
	Double precio
	Integer nivelImpuesto
	Double porcentajeImpuesto
	Integer slotsDisponibles
	Double slotPrecio
	Double precio76
	Double precio77
	Double precio78
	Double precio79
	Double precio80
	Double precio81
	Double precio82
	Double precio83
	Double precio84
	Double precio85
	Double precio86
	Double precio87
	Double precio88
	Double precio89
	Double precio90
	Double precio91
	Double precio92
	Double precio93
	Double precio94
	
	new(TorneoModel model) {
	}
	
	def modificarPrecio(){
		Precios.instance.setPrecio(nivel,precio)
	}
	
//	def getPorcentajeImpuesto(){
//		Precios.instance.getPrecio("Impuesto")
//	}
	
	def guardarTodo(){
		Precios.instance.setPrecio(76,precio76)
		Precios.instance.setPrecio(77,precio77)
		Precios.instance.setPrecio(78,precio78)
		Precios.instance.setPrecio(79,precio79)
	 	Precios.instance.setPrecio(80,precio80)
		Precios.instance.setPrecio(81,precio81)
		Precios.instance.setPrecio(82,precio82)
		Precios.instance.setPrecio(83,precio83)
		Precios.instance.setPrecio(84,precio84)
		Precios.instance.setPrecio(85,precio85)
		Precios.instance.setPrecio(86,precio86)
		Precios.instance.setPrecio(87,precio87)
		Precios.instance.setPrecio(88,precio88)
		Precios.instance.setPrecio(89,precio89)
		Precios.instance.setPrecio(90,precio90)
		Precios.instance.setPrecio(91,precio91)
		Precios.instance.setPrecio(92,precio92)
		Precios.instance.setPrecio(93,precio93)
		Precios.instance.setPrecio(94,precio94)
		
		Precios.instance.setPrecio("Impuesto",porcentajeImpuesto)
		Precios.instance.setPrecio("Slot", slotPrecio)
	}
	
	def traerTodo(){
		precio76 = Precios.instance.getPrecio(76)
		precio77 = Precios.instance.getPrecio(77)
		precio78 = Precios.instance.getPrecio(78)
		precio79 = Precios.instance.getPrecio(79)
		precio80 = Precios.instance.getPrecio(80)
		precio81 = Precios.instance.getPrecio(81)
		precio82 = Precios.instance.getPrecio(82)
		precio83 = Precios.instance.getPrecio(83)
		precio84 = Precios.instance.getPrecio(84)
		precio85 = Precios.instance.getPrecio(85)
		precio86 = Precios.instance.getPrecio(86)
		precio87 = Precios.instance.getPrecio(87)
		precio88 = Precios.instance.getPrecio(88)
		precio89 = Precios.instance.getPrecio(89)
		precio90 = Precios.instance.getPrecio(90)
		precio91 = Precios.instance.getPrecio(91)
		precio92 = Precios.instance.getPrecio(92)
		precio93 = Precios.instance.getPrecio(93)
		precio94 = Precios.instance.getPrecio(94)
		
		porcentajeImpuesto = Precios.instance.getPrecio("Impuesto")
		slotPrecio = Precios.instance.getPrecio("Slot")
		
	}
}