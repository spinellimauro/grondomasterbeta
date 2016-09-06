package arena.windows

import arena.models.EquipoModel
import master.Jugador
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import arena.models.MercadoModel
import master.DT

class MercadoWindow extends SimpleWindow<MercadoModel> {

	new(WindowOwner owner, EquipoModel model) {
		super(owner, new MercadoModel(model))
		title = "Mercado"
		taskDescription = ""
	}

	override createMainTemplate(Panel panel) {
		new Table(panel, Jugador) => [
			items <=> "listaTransferibles"
			value <=> "jugadorSeleccionado"
			numberVisibleRows = 8

			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 150
			]
			new Column(it) => [
				title = "Nivel"
				bindContentsToProperty("nivel")
				fixedSize = 45
			]
			new Column(it) => [
				title = "Potencial"
				bindContentsToProperty("potencial")
				fixedSize = 65
			]
			new Column(it) => [
				title = "Precio"
				bindContentsToProperty("precioVenta")
				fixedSize = 70
			]

			new Column(it) => [
				title = "Propietario"
				bindContentsToProperty("propietario").transformer = [ DT dt | dt.nombreDT ]
				fixedSize = 150
			]
		]

		new Button(panel) => [
			caption = "Comprar"
			fontSize = 10
			onClick[modelObject.comprarJugador]
		]
	}

	override protected createFormPanel(Panel mainPanel) {}
	
	override protected addActions(Panel actionsPanel) {}
}
