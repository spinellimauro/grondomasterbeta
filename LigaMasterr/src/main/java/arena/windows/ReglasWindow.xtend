package arena.windows

import arena.models.ReglasModel
import arena.models.TorneoModel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.TextBox

class ReglasWindow extends SimpleWindow<ReglasModel>{
	new(WindowOwner owner, TorneoModel model) {
		super(owner, new ReglasModel(model))
		title = "Equipos"
	}
	
	override createMainTemplate(Panel panel){
		
		panel.layout = new ColumnLayout(2)
		new Label(panel).text = "<= 77"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 78"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 79"
		
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 80"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 81"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 82"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 83"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 84"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 85"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 86"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 87"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 88"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 89"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 90"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 91"
		
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 92"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 93"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]
		new Label(panel).text = "= 94"
		new TextBox(panel) => [
			bindValueToProperty("val77")
		]		
	}
	
	override protected addActions(Panel actionsPanel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override protected createFormPanel(Panel mainPanel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}