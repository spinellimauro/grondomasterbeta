package arena.windows

import arena.components.LabeledSelector
import arena.models.TorneoModel
import master.Partido
import master.Torneo
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class TorneoWindow extends SimpleWindow<TorneoModel> {

	new(WindowOwner parent) {
		super(parent, new TorneoModel)
		title = "Liga Master"
	}

	override protected createMainTemplate(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout
		createTorneoPanel(new Panel(mainPanel))
		createFechaPanel(new Panel(mainPanel))
	}

	def createFechaPanel(Panel panel) {
		new LabeledSelector(panel) => [
			text = "\tFecha"
			label.fontSize = 12
			bindItemsToProperty("listaFechas")
			bindValueToProperty("fechaSeleccionada")
		]

		new Table(panel, Partido) => [
			bindItemsToProperty("fecha")
			bindValueToProperty("partido")
			numberVisibleRows = 8

			new Column(it) => [
				title = "Local"
				bindContentsToProperty("dtLocal.nombreDT")
				fixedSize = 80
			]
			new Column(it) => [
				bindContentsToProperty("score")
				fixedSize = 40
			]
			new Column(it) => [
				title = "Visitante"
				bindContentsToProperty("dtVisitante.nombreDT")
				fixedSize = 80
			]
		]

		new Button(panel) => [
			caption = "Editar Partido"
			onClick[new PartidoWindow(this, modelObject.partido).open]
			fontSize = 10
		]
	}

	def void createTorneoPanel(Panel panel) {
		new Selector(panel) => [
			bindItemsToProperty("grondomaster.listaTorneos").adapter = new PropertyAdapter(Torneo, "nombreTorneo")
			bindValueToProperty("torneoSeleccionado")
			height = 50
			width = 100
		]

		val panelHorizontal = new Panel(panel).layout = new HorizontalLayout
		new Label(panelHorizontal).text = "        "
		new Button(panelHorizontal) => [
			caption = "+"
			width = 30
			height = 30
		]
		new Button(panelHorizontal) => [
			caption = "-"
			width = 30
			height = 30
		]

		new Button(panel) => [
			caption = "Editar Torneo"
			onClick[new TorneoConfigWindow(this, modelObject).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Equipos"
			onClick[new EquipoWindow(this, modelObject).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Estadisticas"
			onClick[new TablaWindow(this, modelObject.torneoSeleccionado).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Guardar"
			onClick[modelObject.grondomaster.guardarBase]
			fontSize = 10
		]
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}
}
