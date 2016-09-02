package arena.windows

import arena.models.BuscadorModel
import master.Jugador
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.MainWindow

class BuscadorWindow extends MainWindow<BuscadorModel> {
	new() {
		super(new BuscadorModel)
	}

	override createContents(Panel panel) {
		val horizontal = new Panel(panel).layout = new HorizontalLayout

		new TextBox(horizontal) => [
			bindValueToProperty("valorBuscado")
			width = 260
			fontSize = 12
		]

		new Button(horizontal) => [
			caption = "Buscar"
			onClick[modelObject.buscar]
			fontSize = 10
			setAsDefault
		]

		new Table(panel, Jugador) => [
			bindItemsToProperty("resultados")
			numberVisibleRows = 18

			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 150
			]

			new Column(it) => [
				title = "Valoración"
				bindContentsToProperty("nivel")
				fixedSize = 80
			]

			new Column(it) => [
				title = "Potencial"
				bindContentsToProperty("potencial")
				fixedSize = 80
			]
		]
	}

	def static main(String[] args) {
		new BuscadorWindow().startApplication
	}

}
