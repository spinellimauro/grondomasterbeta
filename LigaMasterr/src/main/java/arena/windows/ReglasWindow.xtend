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

class ReglasWindow extends SimpleWindow<ReglasModel> {
	new(WindowOwner owner) {
		super(owner, new ReglasModel)
		title = "Reglas"
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {
		new Table(mainPanel, PrecioNivel) => [
			bindItemsToProperty("listaNiveles")
			bindValueToProperty("nivelON")
			numberVisibleRows = 8

			new Column(it) => [
				title = "Nivel"
				bindContentsToProperty("nivel")
			]
			
			new Column(it) => [
				title = "Precio"
				bindContentsToProperty("precio")
				fixedSize = 60
			]
		]

		new LabeledTextBox(mainPanel) => [
			bindTextToProperty("nivelON.nivel")
			bindValueToProperty("nivelON.precio")
			width = 50
		]

		new Table(mainPanel, PrecioEvento) => [
			bindItemsToProperty("listaEventos")
			bindValueToProperty("eventoON")
			numberVisibleRows = 6

			new Column(it) => [
				title = "Evento"
				bindContentsToProperty("evento")
			]
			
			new Column(it) => [
				title = "Precio"
				bindContentsToProperty("precio")
			]
		]

		new LabeledTextBox(mainPanel) => [
			bindTextToProperty("eventoON.evento")
			bindValueToProperty("eventoON.precio")
			width = 50
		]
	}
}
