package arena.windows

import arena.models.EquipoModel
import arena.models.TorneoModel
import master.DT
import master.Jugador
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class EquipoWindow extends SimpleWindow<EquipoModel> {

	new(WindowOwner owner, TorneoModel model) {
		super(owner, new EquipoModel(model))
		title = "Manejo de Equipos"
		taskDescription = ""
	}

	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout

		val panelIzquierdo = new Panel(panel)
		createDTPanel(panelIzquierdo)

		val panelCentral = new Panel(panel)
		createEquipoPanel(panelCentral)
		createButtonPanel(panelCentral)

		val buttonPanel = new Panel(panel)
		createTransferPanel(buttonPanel)

		val panelDerecho = new Panel(panel)
		createBuscadorPanel(panelDerecho)
	}

	def void createDTPanel(Panel panel) {
		val panelNombre = new Panel(panel).layout = new HorizontalLayout
		new Label(panelNombre) => [
			text = "Nombre: "
			fontSize = 12
		]
		new TextBox(panelNombre) => [
			value <=> "dtElegido.nombreDT"
			fontSize = 10
			width = 70
		]

		val panelEquipo = new Panel(panel).layout = new HorizontalLayout
		new Label(panelEquipo) => [
			text = "Equipo :"
			fontSize = 12
		]
		new TextBox(panelEquipo) => [
			value <=> "dtElegido.nombreEquipo"
			fontSize = 10
			width = 80
		]

		val panelPlata = new Panel(panel).layout = new HorizontalLayout
		new Label(panelPlata) => [
			text = "Plata: "
			fontSize = 12
		]
		new NumericField(panelPlata) => [
			value <=> "dtElegido.plata"
			fontSize = 10
			width = 95
		]

		new Selector(panel) => [
			bindItemsToProperty("grondomaster.listaDTs").adapter = new PropertyAdapter(DT, "nombreDT")
			bindValueToProperty("dtElegido")
			height = 80
		]

		val panelNuevo = new Panel(panel).layout = new HorizontalLayout
		new TextBox(panelNuevo) => [
			value <=> "nombreIngresado"
			fontSize = 12
			width = 80
		]
		new Button(panelNuevo) => [
			caption = "+"
			onClick[modelObject.addDT]
			fontSize = 10
			width = 30
			fontSize = 10
		]
		new Button(panelNuevo) => [
			caption = "-"
			onClick[|modelObject.removeDT]
			fontSize = 10
			width = 30
		]
		new Button(panel) => [
			caption = "Mercado"
			onClick[new TransferiblesWindow(this, modelObject).open]
			fontSize = 10
		]
	}

	def void createEquipoPanel(Panel panel) {
		new Table(panel, Jugador) => [
			bindItemsToProperty("dtElegido.jugadores")
			bindValueToProperty("jugadorElegido")
			numberVisibleRows = 11

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
				fixedSize = 65
			]
		]
	}

	def void createButtonPanel(Panel panel) {
		val panelHorizontal = new Panel(panel).layout = new HorizontalLayout
		new Label(panelHorizontal) => [
			text = "Precio de Venta"
			fontSize = 12
		]
		new NumericField(panelHorizontal) => [
			bindValueToProperty("precioIngresado")
			width = 100
			fontSize = 12
		]
		new Button(panelHorizontal) => [
			caption = "Poner En Venta"
			onClick[modelObject.ponerEnVenta]
			fontSize = 10
		]
	}

	def createTransferPanel(Panel panel) {
		new Label(panel).text = "\n\n\n\n\n"
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
			bindItemsToProperty("resultados")
			bindValueToProperty("jugadorElegido")
			numberVisibleRows = 11

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
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}
}
