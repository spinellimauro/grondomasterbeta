package arena.windows

import arena.components.LabeledNumericField
import arena.components.LabeledTextBox
import arena.models.EquipoModel
import arena.models.TorneoModel
import master.DT
import master.Jugador
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import master.Oferta

class EquipoWindow extends SimpleWindow<EquipoModel> {
	new(WindowOwner owner, TorneoModel model) {
		super(owner, new EquipoModel(model))
		title = "Equipos"
	}

	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout
		createDTPanel(new Panel(panel))
		createEquipoPanel(new Panel(panel))
		createTransferPanel(new Panel(panel))
		createBuscadorPanel(new Panel(panel))
	}

	def void createDTPanel(Panel panel) {
		new Selector(panel) => [
			bindItemsToProperty("torneo.listaParticipantes").adapter = new PropertyAdapter(DT, "nombreDT")
			bindValueToProperty("dtElegido")
			height = 80
		]

		new LabeledTextBox(panel) => [
			text = "Nombre: "
			bindValueToProperty("dtElegido.nombreDT")
			width = 70
		]

		new LabeledTextBox(panel) => [
			text = "Equipo: "
			bindValueToProperty("dtElegido.nombreEquipo")
			width = 80
		]

		new LabeledTextBox(panel) => [
			text = "Plata: "
			bindValueToProperty("dtElegido.plata")
			width = 95
		]

		new Button(panel) => [
			caption = "Mercado"
			onClick[new MercadoWindow(this, modelObject).open]
			fontSize = 10
		]
	}

	def void createEquipoPanel(Panel panel) {
		new Table(panel, Jugador) => [
			bindItemsToProperty("dtElegido.jugadores")
			bindValueToProperty("jugadorElegidoPlantel")
			numberVisibleRows = 8

			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 150
			]
			new Column(it) => [
				title = "Nivel"
				bindContentsToProperty("nivel")
				fixedSize = 45
			]
			new Column(it) => [
				title = "Potencial"
				bindContentsToProperty("potencial")
				fixedSize = 65
			]
			new Column(it) => [
				title = "Precio"
				bindContentsToProperty("precioVenta")
				fixedSize = 70
			]
		]
		
		new LabeledNumericField(panel) => [
			text = "Precio: "
			bindValueToProperty("jugadorElegido.precioVenta")
			width = 100
		]
		
			new Label(panel).text = "\n\n"
		
		new Selector(panel) => [
			bindItemsToProperty("torneo.listaParticipantes").adapter = new PropertyAdapter(DT, "nombreDT")
			bindValueToProperty("dtUsuarioActivo")
			height = 80
		]
		
		new Label(panel).text = "Monto A Ofertar"
		
		new TextBox(panel) => [
			bindValueToProperty("montoOfertado")
			width = 180
			fontSize = 12
		]
		
		new Button(panel) => [
			caption = "Ofertar"
			onClick[modelObject.ofertar]
			fontSize = 10
		]
	}

	def createTransferPanel(Panel panel) {
		new Label(panel).text = "\n\n\n"
		new Button(panel) => [
			caption = "<="
			onClick[modelObject.addJugador]
			width = 30
			fontSize = 10
		]
		new Button(panel) => [
			caption = "=>"
			onClick[modelObject.removeJugador]
			width = 30
			fontSize = 10
		]
	}

	def void createBuscadorPanel(Panel panel) {
		new Table(panel, Jugador) => [
			bindItemsToProperty("listaExterior")
			bindValueToProperty("jugadorElegido")
			numberVisibleRows = 8

			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 150
			]
			new Column(it) => [
				title = "Nivel"
				bindContentsToProperty("nivel")
				fixedSize = 45
			]
			new Column(it) => [
				title = "Potencial"
				bindContentsToProperty("potencial")
				fixedSize = 65
			]
			
			new Column(it) => [
				title = "Precio"
				bindContentsToProperty("precioMaquina")
				fixedSize = 65
			]
	
		]
		
		val panelHorizontal = new Panel(panel).layout = new HorizontalLayout
		new TextBox(panelHorizontal) => [
			bindValueToProperty("valorIngresado")
			width = 180
			fontSize = 12
		]
		new Button(panelHorizontal) => [
			caption = "Buscar"
			onClick[modelObject.buscar]
			fontSize = 10
		]
		
		new Button(panelHorizontal) => [
			caption = "Comprar a La Maquina"
			onClick[modelObject.comprarJugadorALaMaquina]
			fontSize = 10
		]
		
		new Table(panel, Oferta) => [
			bindItemsToProperty("ofertas")
			bindValueToProperty("ofertaElegida")
			numberVisibleRows = 8

			new Column(it) => [
				title = "Ofertante"
				bindContentsToProperty("dtOfertante.nombreDT")
				fixedSize = 150
			]
			new Column(it) => [
				title = "Oferta"
				bindContentsToProperty("monto")
				fixedSize = 100
			]
			new Column(it) => [
				title = "Jugador Ofertado"
				bindContentsToProperty("jugadorOfertado.nombre")
				fixedSize = 150
			]
	
		]
		
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
		
//		new Button(panelHorizontal) => [
//			caption = "Aceptar Oferta"
//			onClick[modelObject.aceptarOferta]
//			fontSize = 10
//		]
		
		
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}
}
