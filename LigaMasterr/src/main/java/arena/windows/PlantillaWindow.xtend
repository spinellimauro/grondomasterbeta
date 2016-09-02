package arena.windows

import org.uqbar.arena.windows.MainWindow
import arena.models.PlantillaModel
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.tables.Table
import master.Jugador
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import master.DT
import org.uqbar.arena.bindings.PropertyAdapter

class PlantillaWindow extends MainWindow<PlantillaModel> {

	new() {
		super(new PlantillaModel)
	}

	override createContents(Panel panel) {
		new Selector(panel) => [
			bindValueToProperty("dtElegido")
			bindItemsToProperty("grondomaster.dts").adapter = new PropertyAdapter(DT, "nombreDT")
		]

		new Table(panel, Jugador) => [
			bindValueToProperty("jugadorElegido")
			bindItemsToProperty("dtElegido.jugadores")

			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 200
			]
			new Column(it) => [
				title = "Nivel"
				bindContentsToProperty("nivel")
				fixedSize = 80
			]
			new Column(it) => [
				title = "Potencial"
				bindContentsToProperty("potencial")
				fixedSize = 90
			]
			new Column(it) => [
				title = "Precio"
				bindContentsToProperty("precioVenta")
				fixedSize = 100
			]
		]

		val precioPanel = new Panel(panel).layout = new HorizontalLayout

		new Label(precioPanel).text = "Precio de Venta"
		new TextBox(precioPanel) => [
			bindValueToProperty("jugadorElegido.precioVenta")
			width = 150
		]
	}

	def static main(String[] args) {
		new PlantillaWindow().startApplication
	}
}
