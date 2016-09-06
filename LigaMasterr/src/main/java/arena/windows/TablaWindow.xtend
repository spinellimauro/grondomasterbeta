package arena.windows

import master.DT
import master.Jugador
import master.Torneo
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class TablaWindow extends Dialog<Torneo> {

	new(WindowOwner owner, Torneo model) {
		super(owner, model)
		title = "Estadisticas"
	}

	override protected createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout

		val panelPosiciones = new Panel(panel)
		new Label(panelPosiciones) => [
			text = "Posiciones"
			fontSize = 12
		]
		new Table(panelPosiciones, DT) => [
			bindItemsToProperty("listaPosiciones")
			numberVisibleRows = 8
			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombreDT")
				fixedSize = 85
			]

			new Column(it) => [
				title = "Puntos"
				bindContentsToProperty("puntos")
				fixedSize = 55
			]
		]

		val panelGoleadores = new Panel(panel)
		new Label(panelGoleadores) => [
			text = "Goleadores"
			fontSize = 12
		]
		new Table(panelGoleadores, Jugador) => [
			bindItemsToProperty("listaGoleadores")
			numberVisibleRows = 8
			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 140
			]

			new Column(it) => [
				title = "Goles"
				bindContentsToProperty("goles")
				fixedSize = 45
			]
		]
		
		val panelFairPlay = new Panel(panel)
		new Label(panelFairPlay) => [
			text = "Fair Play"
			fontSize = 12
		]
		new Table(panelFairPlay, DT) => [
			bindItemsToProperty("listaFairPlay")
			numberVisibleRows = 8
			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombreDT")
				fixedSize = 85
			]

			new Column(it) => [
				title = "Rojas"
				bindContentsToProperty("rojas")
				fixedSize = 40
			]
			
			new Column(it) => [
				title = "Amarillas"
				bindContentsToProperty("amarillas")
				fixedSize = 65
			]
			
			new Column(it) => [
				title = "Puntos"
				bindContentsToProperty("puntosFairPlay")
				fixedSize = 55
			]
		]
	}

	override protected createFormPanel(Panel mainPanel) {}
}
