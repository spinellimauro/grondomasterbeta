package arena.windows

import org.uqbar.arena.windows.SimpleWindow
import arena.models.PartidoModel
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import arena.models.TorneoModel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.bindings.PropertyAdapter
import master.Jugador

class PartidoWindow extends SimpleWindow<PartidoModel> {
	new(WindowOwner parent, TorneoModel model) {
		super(parent, new PartidoModel(model))
	}

	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout
		createLocalPanel(new Panel(panel))
		createPartidoPanel(new Panel(panel))
		createVisitantePanel(new Panel(panel))
	}

	def createLocalPanel(Panel panel) {
		new List(panel) => [
			bindItemsToProperty("partido.dtLocal.jugadores").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorSeleccionado")
			height = 150
			width = 100
		]

		val buttonPanel = new Panel(panel).layout = new HorizontalLayout
		new Button(buttonPanel) => [
			caption = "+"
			onClick[modelObject.addGolLocal]
			fontSize = 10
			width = 30
			fontSize = 10
		]
		new Button(buttonPanel) => [
			caption = "-"
			onClick[|modelObject.removeGolLocal]
			fontSize = 10
			width = 30
		]
	}

	def createPartidoPanel(Panel panel) {
		new Label(panel) => [
			bindValueToProperty("marcador")
			fontSize = 30
		]

		val golesPanel = new Panel(panel).layout = new HorizontalLayout
		new List(golesPanel) => [
			bindItemsToProperty("partido.golesLocal").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorSeleccionado")
			height = 88
			width = 100
		]

		new List(golesPanel) => [
			bindItemsToProperty("partido.golesVisitante").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorSeleccionado")
			height = 88
			width = 100
		]
	}

	def createVisitantePanel(Panel panel) {
		new List(panel) => [
			bindItemsToProperty("partido.dtVisitante.jugadores").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorSeleccionado")
			height = 150
			width = 100
		]

		val buttonPanel = new Panel(panel).layout = new HorizontalLayout
		new Button(buttonPanel) => [
			caption = "+"
			onClick[modelObject.addGolVisitante]
			fontSize = 10
			width = 30
			fontSize = 10
		]
		new Button(buttonPanel) => [
			caption = "-"
			onClick[|modelObject.removeGolVisitante]
			fontSize = 10
			width = 30
		]

	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}

}
