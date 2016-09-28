package arena.windows

import arena.models.PartidoModel
import arena.models.TorneoModel
import java.awt.Color
import master.Jugador
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class PartidoWindow extends SimpleWindow<PartidoModel> {
	new(WindowOwner parent, TorneoModel model) {
		super(parent, new PartidoModel(model))
	}

	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout
		createEquipoPanel(new Panel(panel), "Local")
		createPartidoPanel(new Panel(panel))
		createEquipoPanel(new Panel(panel), "Visitante")
		createAmonestadosPanel(new Panel(panel))
	}

	def createEquipoPanel(Panel panel, String dt) {
		new Label(panel) => [
			bindValueToProperty("nombre" + dt)
			fontSize = 12
		]
		new List(panel) => [
			bindItemsToProperty("equipo" + dt).adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorSeleccionado")
			height = 215
			width = 85
			
		]
	}

	def createPartidoPanel(Panel panel) {
		new Label(panel).text = "\n"
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
			height = 100
			width = 85
		]
		new List(golesPanel) => [
			bindItemsToProperty("partido.golesVisitante").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorSeleccionado")
			height = 100
			width = 85
		]

		val buttonPanel = new Panel(panel).layout = new HorizontalLayout
		new Label(buttonPanel).text = "\t       "
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

	def void createAmonestadosPanel(Panel panel) {
		new Label(panel) => [
			text = "Amarillas"
			fontSize = 10
		]
		new List(panel) => [
			bindItemsToProperty("partido.listaAmarillas").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorSeleccionado")
			height = 50
			width = 85
		]

		val amarillaPanel = new Panel(panel).layout = new HorizontalLayout
		new Label(amarillaPanel).text = "      "
		new Button(amarillaPanel) => [
			caption = "+"
			onClick[|modelObject.addAmarilla]
			height = 30
			width = 30
			background = Color.YELLOW
		]
		new Button(amarillaPanel) => [
			caption = "-"
			onClick[|modelObject.removeAmarilla]
			height = 30
			width = 30
			background = Color.YELLOW
		]

		new Label(panel) => [
			text = "Rojas"
			fontSize = 10
		]
		new List(panel) => [
			bindItemsToProperty("partido.listaRojas").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorSeleccionado")
			height = 50
			width = 85
		]

		val rojaPanel = new Panel(panel).layout = new HorizontalLayout
		new Label(rojaPanel).text = "      "
		new Button(rojaPanel) => [
			caption = "+"
			onClick[|modelObject.addRoja]
			height = 30
			width = 30
			background = Color.RED
		]

		new Button(rojaPanel) => [
			caption = "-"
			onClick[|modelObject.removeRoja]
			height = 30
			width = 30
			background = Color.RED
		]
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}

}
