package arena.windows

import arena.models.TorneoModel
import master.Partido
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.bindings.PropertyAdapter
import master.Torneo

class TorneoWindow extends SimpleWindow<TorneoModel> {

	new(WindowOwner parent) {
		super(parent, new TorneoModel)
	}

	override protected createFormPanel(Panel mainPanel) {
		new Selector(mainPanel) => [
			bindItemsToProperty("grondomaster.listaTorneos").adapter = new PropertyAdapter(Torneo,"nombreTorneo")
			bindValueToProperty("torneoSeleccionado")
		]
		
		val panelHorizontal = new Panel(mainPanel).layout = new HorizontalLayout
		
		new Label(panelHorizontal) => [
			text = "\t       Fecha"
			fontSize = 12
		]
		
		new Selector(panelHorizontal) => [
			bindItemsToProperty("listaFechas")
			bindValueToProperty("fechaSeleccionada")

		]

		new Table(mainPanel, Partido) => [
			bindItemsToProperty("fecha")

			new Column(it) => [
				title = "Local"
				bindContentsToProperty("dtLocal.nombreDT")
			]

			new Column(it) => [
				title = ""
				bindContentsToProperty("score")
				fixedSize = 40
			]

			new Column(it) => [
				title = "Visitante"
				bindContentsToProperty("dtVisitante.nombreDT")
			]
		]
	}

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Editar Equipos"
			onClick[new EquipoWindow(this, modelObject).open]
			fontSize = 10
		]

		new Button(actionsPanel) => [
			caption = "Sortear"
			onClick[modelObject.sortearFixture]
			fontSize = 10
		]

		new Button(actionsPanel) => [
			caption = "Guardar"
			onClick[modelObject.grondomaster.guardarBase]
			fontSize = 10
		]
	}
}
