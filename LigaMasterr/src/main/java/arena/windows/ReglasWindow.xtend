package arena.windows

import org.uqbar.arena.windows.WindowOwner
import arena.models.TorneoModel
import org.uqbar.arena.windows.SimpleWindow
import arena.models.ReglasModel
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Button

class ReglasWindow extends SimpleWindow<ReglasModel>{
	new(WindowOwner owner, TorneoModel model) {
		super(owner, new ReglasModel(model))
		title = "Equipos"
	}
	
	override createMainTemplate(Panel panel){
		new Button(panel).caption = "Hola"
	}
	
	override protected addActions(Panel actionsPanel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override protected createFormPanel(Panel mainPanel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}