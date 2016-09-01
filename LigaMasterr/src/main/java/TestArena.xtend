import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.MainWindow
import org.uqbar.commons.utils.Observable

class TestArena extends MainWindow<Buscador> {
	new() {
		super(new Buscador)
	}

	override createContents(Panel panel) {
		val horizontal = new Panel(panel).layout = new HorizontalLayout

		new TextBox(horizontal) => [
			bindValueToProperty("valorBuscado")
			width = 260
			fontSize = 12
		]

		new Button(horizontal) => [
			caption = "Buscar"
			onClick[modelObject.buscar]
			fontSize = 10
			setAsDefault
		]

		new Table(panel, Jugador) => [
			bindItemsToProperty("resultados")
			numberVisibleRows = 18

			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 150
			]

			new Column(it) => [
				title = "Valoración"
				bindContentsToProperty("nivel")
				fixedSize = 80
			]

			new Column(it) => [
				title = "Potencial"
				bindContentsToProperty("potencial")
				fixedSize = 80
			]
		]
	}

	def static main(String[] args) {
		new TestArena().startApplication
	}

}

@Observable
@Accessors
class Buscador {
	String valorBuscado = ""
	List<Jugador> resultados

	def void buscar() {
		resultados = SoFifa.instance.getJugadores(valorBuscado)
	}
}
