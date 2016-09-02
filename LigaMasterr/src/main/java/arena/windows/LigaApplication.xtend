package arena.windows

import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window

class LigaApplication extends Application {

	static def void main(String[] args) {
		new LigaApplication().start()
	}

	override protected Window<?> createMainWindow() {
//		new EquipoWindow(this)
		new VentaJugadoresWindow(this)
	}

}
