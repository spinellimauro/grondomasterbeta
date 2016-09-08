package arena.windows

import org.uqbar.arena.windows.SimpleWindow
import arena.models.EquipoModel
import org.uqbar.arena.windows.WindowOwner
import arena.models.TorneoModel
import org.uqbar.arena.windows.Dialog
import arena.models.TorneoConfigModel
import arena.models.ImpuestoModel
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.Panel
import master.Jugador
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.layout.HorizontalLayout

class ImpuestosWindow extends Dialog<ImpuestoModel> {
	new(WindowOwner owner, TorneoConfigModel model  ) {
		super(owner, new ImpuestoModel(model))
		title = "Equipos"
	}
	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout
		new Table(panel, Jugador) => [
				bindItemsToProperty("jugadoresConImpuesto")
				bindValueToProperty("jugadorSeleccionado")
				numberVisibleRows = 8
	
				new Column(it) => [
					title = "Nombre"
					bindContentsToProperty("nombre")
					fixedSize = 80
				]
				new Column(it) => [
					title = "Nivel"
					bindContentsToProperty("nivel")
					fixedSize = 40
				]
				new Column(it) => [
					title = "Impuesto"
					bindContentsToProperty("getImpuesto")
					fixedSize = 80
				]
			]
	}
	
	override protected createFormPanel(Panel mainPanel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}