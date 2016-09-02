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
import arena.models.VentaJugadores

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class VentaJugadoresWindow extends SimpleWindow<VentaJugadores> {

	new(WindowOwner owner) {
		super(owner, new VentaJugadores)
		title = "Venta Jugadores"
		modelObject.jugadoresEnVenta
	}

	override createFormPanel(Panel panel) {

		new Table(panel, Jugador) => [
			items <=> "jugadores"
			value <=> "jugadorSeleccionado"
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
		new Button(panel) => [
			caption = "Comprar"
			fontSize = 10
		]
		
		new Button(panel) => [
			caption = "Salir"
			onClick[close]
			fontSize = 10
		]
	}
}
