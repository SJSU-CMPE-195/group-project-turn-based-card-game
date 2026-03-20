extends Node
class_name Upgrade_shop
# description: logic for upgrade shop
@export var product: Data_Card
@export var gold: int
@export var upgrade_price: int = 400

func product_found():
	if(product != null):
		return true
	else:
		return false
		
func upgrade_card(gold: int):
	if (product == null):
		print("Product not found")
		return null
	elif(upgrade_price > gold):
		print("Not sufficient gold to upgrade ", product.card_name)
	elif(gold >= upgrade_price):
		product.upgrade()
		print(product.card_name, " has been upgraded")
		return(product)
		
