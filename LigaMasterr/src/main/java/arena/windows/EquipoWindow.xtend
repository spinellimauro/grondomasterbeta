package arena.windows

import arena.models.EquipoModel
import master.DT
import master.Jugador
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.layout.HorizontalLayout
import arena.models.TorneoModel

class EquipoWindow extends SimpleWindow<EquipoModel> {

	new(WindowOwner owner, TorneoModel model) {
		super(owner, new EquipoModel(model))
		title = "Armado de Equipos"
	}

	override createFormPanel(Panel panel) {
		createDTPanel(panel)
		createEquipoPanel(panel)
	}

	def void createDTPanel(Panel panel) {
		new Selector(panel) => [
			bindItemsToProperty("grondomaster.listaDTs").adapter = new PropertyAdapter(DT, "nombreDT")
			bindValueToProperty("dtElegido")
		]

		val panelHorizontal = new Panel(panel).layout = new HorizontalLayout
		new Label(panelHorizontal) => [
			text = "Plata"
			fontSize = 12

		]

		new Label(panelHorizontal) => [
			value <=> "dtElegido.plata"
			fontSize = 12
		]
	}

	def void createEquipoPanel(Panel panel) {
		new Table(panel, Jugador) => [
			bindItemsToProperty("dtElegido.jugadores")
			bindValueToProperty("jugadorElegido")
			numberVisibleRows = 8

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
	}

	override addActions(Panel panel) {
		new Label(panel) => [
			text = "Precio de Venta"
			fontSize = 12
		]
		
		new NumericField(panel) => [
			bindValueToProperty("precio")
			width = 100
			fontSize = 12
		]
		
		new Button(panel) => [
			caption = "Poner En Venta"
			onClick[modelObject.ponerEnVenta]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "+"
			onClick[|new BuscadorWindow(this, modelObject.dtElegido).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "-"
			onClick[|modelObject.removeJugador]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Mercado"
			onClick[new TransferiblesWindow(this, modelObject).open]
			fontSize = 10
		]
	}
}
