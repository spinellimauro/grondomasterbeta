package arena.windows

import arena.models.BuscadorModel
import master.Jugador
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import master.DT
import master.LigaMaster
import arena.models.EquipoModel

class BuscadorWindow extends SimpleWindow<BuscadorModel> {
	new(WindowOwner owner, EquipoModel model) {
		super(owner, new BuscadorModel(model.dtElegido,model.grondomaster))
		
	}

	override createFormPanel(Panel panel) {
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
			bindValueToProperty("jugadorElegido")
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

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Agregar a Plantilla"
			onClick[modelObject.addJugador]
			fontSize = 10
		]

		new Button(actionsPanel) => [
			caption = "Salir"
			onClick[close]
			fontSize = 10
		]
	}
}
