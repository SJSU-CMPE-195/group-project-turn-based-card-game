extends Node
class_name Card_shop
# description: logic for card shop

@export var product: Data_Card
@export var gold: int

func product_found():
	if(product != null):
		return true
	else:
		return false

func buy(gold: int):
	if product.money > gold:
		return null
	else:
		gold = gold - product.money
		var copy = product.duplicate()
		return copy	
		
func display():
	return{"Name of card is": product.card_name, "Price of card is": product.money,
	"Card description": product.description}
	
