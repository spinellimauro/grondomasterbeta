package arena.windows

import arena.models.ReglasModel
import arena.models.TorneoModel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.TextBox

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*


class ReglasWindow extends SimpleWindow<ReglasModel>{
	
	int i
	
	new(WindowOwner owner, TorneoModel model) {
		super(owner, new ReglasModel(model))
		title = "Equipos"
	}
	
	override createMainTemplate(Panel panel){
		
		panel.layout = new ColumnLayout(2)
		
		for(i=77;i<95;i++){
			new Label(panel)=>[
				text = "=" + i
			]
			new TextBox(panel) => [
				value <=> "precio"
			]
		}	
	}
	
	override protected addActions(Panel actionsPanel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override protected createFormPanel(Panel mainPanel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}