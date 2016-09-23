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
import org.uqbar.arena.widgets.Button

class ReglasWindow extends SimpleWindow<ReglasModel>{
	
	int i
	
	new(WindowOwner owner, TorneoModel model) {
		super(owner, new ReglasModel(model))
		title = "Equipos"
		modelObject.traerTodo
	}
	
	override createMainTemplate(Panel panel){
		
		panel.layout = new ColumnLayout(2)
		// Niveles
		for(i=76;i<95;i++){
			new Label(panel)=>[
				text = "=" + i
			]
			new TextBox(panel) => [
				value <=> "precio" + i
			]
		}	
		// Impuesto
		new Label(panel)=>[
			text = "Nivel Minimo Impuesto" 
		]
		new TextBox(panel) => [
			value <=> "nivelImpuesto"
		]
		new Label(panel)=>[
			text = "Porcentaje Impuesto" 
			
		]
		new TextBox(panel) => [
			value <=> "porcentajeImpuesto"
		]
		// Slots
		new Label(panel)=>[
			text = "Cantidad Maxima Slots" 
		]
		new TextBox(panel) => [
			value <=> "slotsDisponibles"
		]
		
		new Label(panel)=>[
			text = "Valor Slot" 
		]
		new TextBox(panel) => [
			value <=> "slotPrecio"
		]
		
		new Button(panel)=>[
			caption = "Guardar Todo"
			onClick[modelObject.guardarTodo]
		]
	}
	
	override protected addActions(Panel actionsPanel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override protected createFormPanel(Panel mainPanel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}