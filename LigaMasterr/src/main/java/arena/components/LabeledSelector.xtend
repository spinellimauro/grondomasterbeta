package arena.components

import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.Container

class LabeledSelector<T> extends AbstractLabeledWidget {

	Selector<T> selector
	
	new(Container container) {
		super(container)
	}
	
	def bindItemsToProperty(String property){
		selector.bindItemsToProperty(property)
		this
	}
	
	override createWidget(AbstractLabeledWidget widget) {
		selector = new Selector<T>(this) 
	}
	
	override bindValueToProperty(String property) {
		selector.bindValueToProperty(property)
		this
	}
	
}
