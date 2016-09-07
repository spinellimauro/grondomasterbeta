package arena.windows

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import arena.models.OfertasModel
import org.uqbar.arena.widgets.Panel
import master.DT
import org.uqbar.arena.widgets.tables.Table
import master.Oferta
import org.uqbar.arena.widgets.tables.Column
import master.Jugador
import java.util.List
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label

class OfertasWindow extends SimpleWindow<OfertasModel> {

	new(WindowOwner parent, DT model) {
		super(parent, new OfertasModel(model))
	}

	override createMainTemplate(Panel panel) {
		new Label(panel) => [
			text = "Lista de Ofertas"
			fontSize = 12
		]
		new Table(panel, Oferta) => [
			bindItemsToProperty("dtON.ofertasRecibidas")
			bindValueToProperty("ofertaON")
			numberVisibleRows = 8

			new Column(it) => [
				title = "Ofertante"
				bindContentsToProperty("dtOfertante").transformer = [DT dt|dt.nombreDT]
				fixedSize = 80
			]

			new Column(it) => [
				title = "Monto"
				bindContentsToProperty("monto")
				fixedSize = 65
			]

			new Column(it) => [
				title = "Jugador"
				bindContentsToProperty("jugadorOfertado").transformer = [Jugador jugador|jugador.nombre]
				fixedSize = 150
			]

			new Column(it) => [
				title = "Jugadores Ofrecidos"
				bindContentsToProperty("jugadoresOfrecidos").transformer = [ List<Jugador> jugadores |
					jugadores.map[nombre].toString
				]

				fixedSize = 150
			]
		]
		
		createActionsPanel(panel)
	}

	override protected addActions(Panel panel) {
		new Button(panel) => [
			caption = "Aceptar"
			onClick[modelObject.aceptarOferta]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Rechazar"
			onClick[modelObject.rechazarOferta]
			fontSize = 10
		]
	}

	override protected createFormPanel(Panel mainPanel) {}

}
