extends Node
class_name Upgrade_shop
# description: logic for upgrade shop
@export var product: Data_Card
@export var gold: int
@export var upgrade_price: int = 100

func product_found():
	if(product != null):
		return true
	else:
		return false
		
func upgrade_card(gold: int):
	if (upgrade_price > gold or product == null):
		return null
	elif(gold >= upgrade_price):
		product.upgrade()
		return(product)
		
