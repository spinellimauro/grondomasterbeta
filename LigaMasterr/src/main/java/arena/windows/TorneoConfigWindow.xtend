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
import org.uqbar.arena.widgets.Selector
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
		
		new Selector(panelNuevo)=>[	
			bindItemsToProperty("listaDT").adapter = new PropertyAdapter(DT, "nombreDT")
			bindValueToProperty("dtIngresado")
		]

		new Button(panelNuevo) => [
			caption = "+"
			onClick[
				if (modelObject.dtTieneQuePagar){
					new ImpuestosWindow(this, modelObject).open
				}else modelObject.addDT
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
		
		new Button(panelNuevo) => [
			caption = "Cambiar Nombre"
			onClick[|modelObject.guardar]
			fontSize = 10
		]
	}

	override protected createFormPanel(Panel mainPanel) {}
}
