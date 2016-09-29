package arena.windows

import arena.components.LabeledTextBox
import arena.models.PremiosTorneosModel
import arena.models.TorneoModel
import datos.PremioPosicion
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class PremiosTorneoWindow extends Dialog<PremiosTorneosModel> {

	new(WindowOwner owner, TorneoModel model) {
		super(owner, new PremiosTorneosModel(model))
	}
	
	override createMainTemplate(Panel panel) {
	
		createPreciosPanel(new Panel(panel))
		
	}
	
	def void createPreciosPanel(Panel panel) {

		new Table(panel, PremioPosicion) => [
			bindItemsToProperty("posiciones")
//			bindValueToProperty("posicionON")
			numberVisibleRows = 20

			new Column(it) => [
				title = "Posicion"
				bindContentsToProperty("posicion")
				fixedSize = 40
			]

			new Column(it) => [
				title = "Premio"
				bindContentsToProperty("premio")
				fixedSize = 60
			]
		]

//		new LabeledTextBox(panel) => [
//			bindTextToProperty("posicionON.posicion")
//			bindValueToProperty("posicionON.premio")
//			width = 50
//		]
	}
	override protected createFormPanel(Panel mainPanel) {}
}