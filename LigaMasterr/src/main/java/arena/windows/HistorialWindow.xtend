package arena.windows

import java.util.List
import master.DT
import master.LigaMaster
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.utils.Observable

class HistorialWindow extends Dialog<HistorialModel> {

	new(WindowOwner parent, DT model) {
		super(parent, new HistorialModel(model))
	}

	override createMainTemplate(Panel panel) {
		new Table(panel, Historial) => [
			bindItemsToProperty("listaHistoriales")
			numberVisibleRows = 15

			new Column(it) => [
				title = "DT"
				bindContentsToProperty("dt")
				fixedSize = 100
			]
		
			new Column(it) => [
				title = "Jugados"
				bindContentsToProperty("jugados")
				fixedSize = 90
			]
						
			new Column(it) => [
				title = "Ganados"
				bindContentsToProperty("ganados")
				fixedSize = 90
			]

			new Column(it) => [
				title = "Empatados"
				bindContentsToProperty("empatados")
				fixedSize = 90
			]
			new Column(it) => [
				title = "Perdidos"
				bindContentsToProperty("perdidos")
				fixedSize = 90
			]

			new Column(it) => [
				title = "Diferencia"
				bindContentsToProperty("diferencia")
				fixedSize = 90
			]
		]
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}
}

@Observable
@Accessors
class HistorialModel {
	List<Historial> listaHistoriales = newArrayList

	new(DT dt) {
		for (otroDT : LigaMaster.instance.listaDT) {
			if (otroDT != dt)
				listaHistoriales.add(new Historial(dt, otroDT))
		}

		listaHistoriales = listaHistoriales.sortBy[diferencia].reverse
	}

}

@Observable
@Accessors
class Historial {
	String dt
	int jugados
	int ganados
	int empatados
	int perdidos
	int diferencia

	new(DT dt, DT otroDT) {
		dt = otroDT.nombreDT
		jugados = LigaMaster.instance.getPartidosJugados(dt, otroDT).size
		ganados = LigaMaster.instance.getPartidosGanados(dt, otroDT)
		empatados = LigaMaster.instance.getPartidosEmpatados(dt, otroDT)
		perdidos = LigaMaster.instance.getPartidosPerdidos(dt, otroDT)
		diferencia = ganados - perdidos
	}
}
