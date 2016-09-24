package arena.windows

import arena.models.MercadoModel
import arena.models.TorneoModel
import master.Jugador
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class MercadoSofifa extends SimpleWindow<MercadoModel> {

	new(WindowOwner owner, TorneoModel model) {
		super(owner, new MercadoModel(model))
		title = "Mercado"
	}

	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout
		createMaquinaWindowPanel(new Panel(panel))
	}

	def createMaquinaWindowPanel(Panel panel) {
		new Label(panel) => [
			text = "Lista Exterior"
			fontSize = 12
		]
		new Table(panel, Jugador) => [
			bindItemsToProperty("listaMaquina")
			bindValueToProperty("jugadorON")
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
				bindContentsToProperty("precioMaquina")
				fixedSize = 65
			]

		]

		val panelHorizontal = new Panel(panel).layout = new HorizontalLayout
		new TextBox(panelHorizontal) => [
			bindValueToProperty("valorIngresado")
			width = 180
			fontSize = 12
		]

		new Button(panelHorizontal) => [
			caption = "Buscar"
			onClick[modelObject.buscar]
			fontSize = 10
		]

		new Button(panelHorizontal) => [
			caption = "Comprar"
			onClick[modelObject.comprarJugadorALaMaquina]
			fontSize = 10
		]
	}
	override protected createFormPanel(Panel mainPanel) {}

	override protected addActions(Panel actionsPanel) {}
}
