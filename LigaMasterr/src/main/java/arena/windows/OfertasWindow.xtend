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
import org.uqbar.arena.layout.HorizontalLayout

class OfertasWindow extends SimpleWindow<OfertasModel> {

	new(WindowOwner parent, DT model) {
		super(parent, new OfertasModel(model))
	}

	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout
		
		createRecibidosPanel(new Panel(panel))
		createEnviadosPanel(new Panel(panel))
		createActionsPanel(panel)
	}
	
	def void createRecibidosPanel(Panel panel) {
		new Label(panel) => [
			text = "Recibidas"
			fontSize = 12
		]
		
		new Table(panel, Oferta) => [
			bindItemsToProperty("ofertasRecibidas")
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
		
		val buttonPanel = new Panel(panel).layout = new HorizontalLayout
		
		new Button(buttonPanel) => [
			caption = "Aceptar"
			onClick[modelObject.aceptarOferta]
			fontSize = 10
		]

		new Button(buttonPanel) => [
			caption = "Rechazar"
			onClick[modelObject.rechazarOferta]
			fontSize = 10
		]
	}
	
	def void createEnviadosPanel(Panel panel){
		new Label(panel) => [
			text = "Enviadas"
			fontSize = 12
		]
		new Table(panel, Oferta) => [
			bindItemsToProperty("ofertasEnviadas")
			bindValueToProperty("ofertaON")
			numberVisibleRows = 8

			new Column(it) => [
				title = "Receptor"
				bindContentsToProperty("dtReceptor").transformer = [DT dt|dt.nombreDT]
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
		
		new Button(panel) => [
			caption = "Cancelar"
			onClick[modelObject.rechazarOferta]
			fontSize = 10
		]
	}

	override protected addActions(Panel panel) {}

	override protected createFormPanel(Panel mainPanel) {}

}
