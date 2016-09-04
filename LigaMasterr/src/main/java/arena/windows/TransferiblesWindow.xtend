package arena.windows

import arena.models.EquipoModel
import arena.models.TransferiblesModel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import master.Jugador

class TransferiblesWindow extends SimpleWindow<TransferiblesModel> {

	new(WindowOwner owner, EquipoModel model) {
		super(owner, new TransferiblesModel(model))
		title = "Jugadores en Venta"
		taskDescription = ""
	}

	override createFormPanel(Panel panel) {
		new Table(panel, Jugador) => [
			items <=> "listaTransferibles"
			value <=> "jugadorSeleccionado"
			numberVisibleRows = 8

			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 200
			]
			new Column(it) => [
				title = "Nivel"
				bindContentsToProperty("nivel")
				fixedSize = 80
			]
			new Column(it) => [
				title = "Potencial"
				bindContentsToProperty("potencial")
				fixedSize = 90
			]
			new Column(it) => [
				title = "Precio"
				bindContentsToProperty("precioVenta")
				fixedSize = 100
			]
		]
	}

	override addActions(Panel panel) {
		new Button(panel) => [
			caption = "Comprar"
			fontSize = 10
			onClick[modelObject.comprarJugador()]
		]
	}
}
