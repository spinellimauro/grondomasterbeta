package arena.windows

import arena.components.LabeledTextBox
import arena.models.ReglasModel
import datos.PrecioEvento
import datos.PrecioNivel
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.HorizontalLayout

class ReglasWindow extends SimpleWindow<ReglasModel> {
	new(WindowOwner owner) {
		super(owner, new ReglasModel)
		title = "Reglas"
	}

	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout
		createPreciosPanel(new Panel(panel))
		createEventosPanel(new Panel(panel))
	}

	def void createPreciosPanel(Panel panel) {

		new Table(panel, PrecioNivel) => [
			bindItemsToProperty("listaNiveles")
			bindValueToProperty("nivelON")
			numberVisibleRows = 20

			new Column(it) => [
				title = "Nivel"
				bindContentsToProperty("nivel")
				fixedSize = 40
			]

			new Column(it) => [
				title = "Precio"
				bindContentsToProperty("precio")
				fixedSize = 60
			]
		]

		new LabeledTextBox(panel) => [
			bindTextToProperty("nivelON.nivel")
			bindValueToProperty("nivelON.precio")
			width = 50
		]
	}

	def void createEventosPanel(Panel panel) {
		new Table(panel, PrecioEvento) => [
			bindItemsToProperty("listaEventos")
			bindValueToProperty("eventoON")
			numberVisibleRows = 7

			new Column(it) => [
				title = "Evento"
				bindContentsToProperty("evento")
			]

			new Column(it) => [
				title = "Precio"
				bindContentsToProperty("precio")
			]
		]

		new LabeledTextBox(panel) => [
			bindTextToProperty("eventoON.evento")
			bindValueToProperty("eventoON.precio")
			width = 50
		]
	}
	
	override protected addActions(Panel actionsPanel) { }
	
	override protected createFormPanel(Panel mainPanel) { }
}
