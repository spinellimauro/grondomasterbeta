package arena.windows

import arena.models.PremiosTorneosModel
import arena.models.TorneoModel
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class PremiosTorneoWindow extends Dialog<PremiosTorneosModel> {

	new(WindowOwner owner, TorneoModel model) {
		super(owner, new PremiosTorneosModel(model))
	}

	override createMainTemplate(Panel panel) {
		
	}

	override protected createFormPanel(Panel mainPanel) {}
}