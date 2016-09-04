package arena.windows

import arena.models.TorneoModel
import master.Jugador
import master.Partido
import master.Torneo
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import master.DT

class TorneoWindow extends SimpleWindow<TorneoModel> {

	new(WindowOwner parent) {
		super(parent, new TorneoModel)
	}

	override protected createMainTemplate(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout
		createTorneoPanel(mainPanel)
		createTablasPanel(mainPanel)
		createButtonPanel(mainPanel)

	}

	def createTablasPanel(Panel panel) {
		val selectorPanel = new Panel(panel)
		new Label(selectorPanel) => [
			text = "Fecha"
			fontSize = 12
		]

		new Selector(selectorPanel) => [
			bindItemsToProperty("listaFechas")
			bindValueToProperty("fechaSeleccionada")
			height = 120
		]

		val resultadosPanel = new Panel(panel)
		new Table(resultadosPanel, Partido) => [
			bindItemsToProperty("fecha")
			bindValueToProperty("partido")
			numberVisibleRows = 8

			new Column(it) => [
				title = "Local"
				bindContentsToProperty("dtLocal.nombreDT")
				fixedSize = 80
			]
			new Column(it) => [
				title = ""
				bindContentsToProperty("score")
				fixedSize = 40
			]
			new Column(it) => [
				title = "Visitante"
				bindContentsToProperty("dtVisitante.nombreDT")
				fixedSize = 80
			]
		]
		new Table(panel, Jugador) => [
			bindItemsToProperty("torneoSeleccionado.listaGoleadores")
			numberVisibleRows = 8
			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 140
			]

			new Column(it) => [
				title = "Goles"
				bindContentsToProperty("goles")
				fixedSize = 45
			]
		]

		new Table(panel, DT) => [
			bindItemsToProperty("torneoSeleccionado.listaPosiciones")
			numberVisibleRows = 8
			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombreDT")
				fixedSize = 85
			]

			new Column(it) => [
				title = "Puntos"
				bindContentsToProperty("puntos")
				fixedSize = 55
			]
		]
	}

	def void createTorneoPanel(Panel panel) {
		val torneoPanel = new Panel(panel)
		new List(torneoPanel) => [
			bindItemsToProperty("grondomaster.listaTorneos").adapter = new PropertyAdapter(Torneo, "nombreTorneo")
			bindValueToProperty("torneoSeleccionado")
			height = 50
			width = 100
		]

//		val buttonPanel = new Panel(torneoPanel).layout = new HorizontalLayout
//		new TextBox(buttonPanel) => [
//			bindValueToProperty("nombreIngresado")
//			width = 50
//		]
//
//		new Button(buttonPanel) => [
//			caption = "+"
//			onClick[modelObject.crearTorneo]
//			width = 30
//			fontSize = 8
//		]
//
//		new Button(buttonPanel) => [
//			caption = "-"
//			onClick[modelObject.borrarTorneo]
//			width = 30
//			fontSize = 8
//		]
	}

	def void createButtonPanel(Panel actionsPanel) {
		val buttonPanel = new Panel(actionsPanel)
		new Button(buttonPanel) => [
			caption = "Editar Equipos"
			onClick[new EquipoWindow(this, modelObject).open]
			fontSize = 10
		]

		new Button(buttonPanel) => [
			caption = "Sortear"
			onClick[modelObject.sortearFixture]
			fontSize = 10
		]

		new Button(buttonPanel) => [
			caption = "Editar Partido"
			onClick[new PartidoWindow(this, modelObject).open]
			fontSize = 10
		]

		new Button(buttonPanel) => [
			caption = "Guardar"
			onClick[modelObject.grondomaster.guardarBase]
			fontSize = 10
		]
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}

}
