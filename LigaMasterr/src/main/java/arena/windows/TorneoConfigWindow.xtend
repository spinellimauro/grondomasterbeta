package arena.windows

import arena.components.LabeledTextBox
import arena.models.TorneoConfigModel
import arena.models.TorneoModel
import master.DT
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class TorneoConfigWindow extends Dialog<TorneoConfigModel> {

	new(WindowOwner owner, TorneoModel model) {
		super(owner, new TorneoConfigModel(model))
	}

	override createMainTemplate(Panel panel) {
		new LabeledTextBox(panel) => [
			text = "Nombre: "
			bindValueToProperty("torneoON.nombreTorneo")
			width = 150
		]

		new List(panel) => [
			bindItemsToProperty("torneoON.listaParticipantes").adapter = new PropertyAdapter(DT, "nombreDT")
			bindValueToProperty("dtON")
			height = 100
		]
		
		val panelNuevo = new Panel(panel).layout = new HorizontalLayout
		new TextBox(panelNuevo) => [
			bindValueToProperty("nombreIngresado")
			fontSize = 10
			width = 80
		]
		new Button(panelNuevo) => [
			caption = "+"
			onClick[
				modelObject.addDT
				if (modelObject.dtTieneQuePagar){
					new ImpuestosWindow().open
				}
			]
			fontSize = 10
			width = 30
		]
		new Button(panelNuevo) => [
			caption = "-"
			onClick[|modelObject.removeDT]
			fontSize = 10
			width = 30
		]
		
		new Button(panelNuevo) => [
			caption = "Sortear Fixture"
			onClick[|modelObject.model.sortearFechas]
			fontSize = 10
		]
	}

	override protected createFormPanel(Panel mainPanel) {}
}
