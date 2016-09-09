package arena.windows

import arena.models.ImpuestoModel
import arena.models.TorneoConfigModel
import master.Jugador
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label

class ImpuestosWindow extends Dialog<ImpuestoModel> {
	new(WindowOwner owner, TorneoConfigModel model  ) {
		super(owner, new ImpuestoModel(model))
		title = "Equipos"
	}
	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout
		
		new Label(panel) => [
			text = "No Pagar"
			fontSize = 12
		]
		new Table(panel, Jugador) => [
				bindItemsToProperty("jugadores")
				bindValueToProperty("jugadorSeleccionado")
				numberVisibleRows = 8
	
				new Column(it) => [
					title = "Nombre"
					bindContentsToProperty("nombre")
					fixedSize = 80
				]
				new Column(it) => [
					title = "Nivel"
					bindContentsToProperty("nivel")
					fixedSize = 40
				]
				new Column(it) => [
					title = "Impuesto"
					bindContentsToProperty("impuesto")
					fixedSize = 80
				]
			]
		new Button(panel)=>[
			caption = "Agregar"
			onClick[modelObject.agregarAPagar()]
		]
		
		new Button(panel)=>[
			caption = "Quitar"
			onClick[modelObject.removerAPagar()]
		]
		
		new Label(panel) => [
			text = "A Pagar"
			fontSize = 12
		]
		new Table(panel, Jugador) => [
				bindItemsToProperty("jugadoresAPagar")
				bindValueToProperty("jugadorSeleccionadoAPagar")
				numberVisibleRows = 8
	
				new Column(it) => [
					title = "Nombre"
					bindContentsToProperty("nombre")
					fixedSize = 80
				]
				new Column(it) => [
					title = "Nivel"
					bindContentsToProperty("nivel")
					fixedSize = 40
				]
				new Column(it) => [
					title = "Impuesto"
					bindContentsToProperty("impuesto")
					fixedSize = 80
				]
			]
		
		
		new Label(panel) => [
			text = "Plata Disponible"
			fontSize = 12
		]
		
		new Label(panel) => [
			bindValueToProperty("dtAgregado.plata")
			fontSize = 12	
		]
		
		new Button(panel)=>[
			caption = "Pagar Impuestos"
			onClick[modelObject.pagarImpuestos()]
		]
		
	}
	
	override protected createFormPanel(Panel mainPanel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}