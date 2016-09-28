package arena.windows

import arena.models.MercadoModel
import arena.models.TorneoModel
import master.DT
import master.Jugador
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class MercadoWindow extends SimpleWindow<MercadoModel> {

	new(WindowOwner owner, TorneoModel model) {
		super(owner, new MercadoModel(model))
		title = "Mercado"
	}

	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout
		createTransferiblesPanel(new Panel(panel))
	}


	def void createTransferiblesPanel(Panel panel) {
		new Label(panel) => [
			text = "Lista Transferibles"
			fontSize = 12
		]
		new Table(panel, Jugador) => [
			items <=> "listaTransferibles"
			value <=> "jugadorON"
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
				fixedSize = 65
			]
			new Column(it) => [
				title = "Propietario"
				bindContentsToProperty("propietario").transformer = [DT dt|dt.nombreDT]
				fixedSize = 80
			]
		]

		new Button(panel) => [
			caption = "Comprar"
			fontSize = 10
			onClick[modelObject.comprarJugador]
			width = 100
		]
	}

	override protected createFormPanel(Panel mainPanel) {}

	override protected addActions(Panel actionsPanel) {}
}
