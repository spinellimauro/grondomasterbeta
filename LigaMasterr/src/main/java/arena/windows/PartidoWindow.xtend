package arena.windows

import arena.models.PartidoModel
import master.Jugador
import master.Partido
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class PartidoWindow extends SimpleWindow<PartidoModel> {
	new(WindowOwner parent, Partido model) {
		super(parent, new PartidoModel(model))
	}

	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout
		createLocalPanel(new Panel(panel))
		createPartidoPanel(new Panel(panel))
		createVisitantePanel(new Panel(panel))
	}

	def createLocalPanel(Panel panel) {
		new Label(panel) => [
			bindValueToProperty("partido.dtLocal.nombreDT")
			fontSize = 12
		]
		new List(panel) => [
			bindItemsToProperty("partido.dtLocal.jugadores").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorSeleccionado")
			height = 150
			width = 100
		]

		val buttonPanel = new Panel(panel).layout = new HorizontalLayout
		new Button(buttonPanel) => [
			caption = "+"
			onClick[modelObject.addGol]
			height = 30
			width = 30
		]
		new Button(buttonPanel) => [
			caption = "-"
			onClick[|modelObject.removeGol]
			height = 30
			width = 30
		]
	}

	def createPartidoPanel(Panel panel) {
		new Label(panel) => [
			bindValueToProperty("partido.score")
			fontSize = 30
		]
		
		new Label(panel) => [
			text = "Goles"
			fontSize = 10
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
		new Label(panel) => [
			bindValueToProperty("partido.dtVisitante.nombreDT")
			fontSize = 12
		]
		new List(panel) => [
			bindItemsToProperty("partido.dtVisitante.jugadores").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorSeleccionado")
			height = 150
			width = 100
		]

		val buttonPanel = new Panel(panel).layout = new HorizontalLayout
		new Button(buttonPanel) => [
			caption = "+"
			onClick[modelObject.addGol]
			height = 30
			width = 30
		]
		new Button(buttonPanel) => [
			caption = "-"
			onClick[|modelObject.removeGol]
			height = 30
			width = 30
		]

	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}

}
