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

class EquipoWindow extends SimpleWindow<EquipoModel> {

	new(WindowOwner owner) {
		super(owner, new EquipoModel)
		title = "Armado de Equipos"
	}

	override createFormPanel(Panel panel) {
		new Selector(panel) => [
			bindItemsToProperty("grondomaster.dts").adapter = new PropertyAdapter(DT, "nombreDT")
			bindValueToProperty("dtElegido")
			
		]

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
			bindValueToProperty("jugadorElegido.precioVenta")
			width = 100
			fontSize = 12
		]

		new Button(panel) => [
			caption = "Agregar"
			onClick[|new BuscadorWindow(this, modelObject.dtElegido).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Eliminar"
			onClick[|modelObject.removeJugador]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Guardar Cambios"
			onClick[modelObject.grondomaster.guardarBase]
			fontSize = 10
		]
		
		new Button(panel) => [
			caption = "Salir"
			onClick[close]
			fontSize = 10
		]
	}
}
