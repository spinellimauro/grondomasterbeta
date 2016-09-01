

import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.TextBox


import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Selector

class EjemploWindow extends MainWindow<LigaMaster>{
	new() {
		super(new LigaMaster)
	}
	
	override createContents(Panel mainPanel){
		mainPanel.layout = new VerticalLayout
		
		new Label(mainPanel).text = "Dt Local"
		
		new Selector(mainPanel) =>[
			items <=> "dts"
			value <=> "partido.dtLocal"
		]
//		
////		new Label(mainPanel).value <=> "dtLocal.plata"
//		
//		new Label(mainPanel).text = "Dt Visitante"
//		
//		new Selector(mainPanel) =>[
//			(items <=> "dts")
//			value <=> "partido.dtVisitante"
//		]
//		
////		new Label(mainPanel).value <=> "dtVisitante.plata"
//		new Label(mainPanel).text = "Gol Local"
//		
//		new TextBox(mainPanel) =>[
//			value <=> "partido.golLocal"
//			fontSize = 12
//		]
//		
//		new Label(mainPanel).text = "Gol Visitante"
//		
//		new TextBox(mainPanel) =>[
//			value <=> "partido.golVisitante"
//			fontSize = 12
//		]
//		
//		
//		new Button(mainPanel) => [
//			caption = "JugarPartido"
//			onClick [|this.modelObject.jugarPartido]
//		]
		
	}
	
	def static main(String[] args) {
		new EjemploWindow().startApplication
	}
}