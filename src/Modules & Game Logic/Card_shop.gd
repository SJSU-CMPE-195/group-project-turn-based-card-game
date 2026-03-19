extends Node
class_name Card_shop
# description: logic for card shop

@export var product: Data_Card
@export var gold: int
@export var cardupgrade: Data_Card
@export var upgrade_price: int = 100

func product_found():
	if(product != null):
		return true
	else:
		return false

func buy():
	if product.money > gold:
		return null
	else:
		gold = gold - product.money
		var copy = product.duplicate()
		return copy	

func press_buy():
	var bought = buy()
	if bought == null:
		print("Card does not exist or you don't have sufficient gold to buy it")
	else:
		print(bought.card_name, " has been purchased")

func press_upgrade():
	if (upgrade_price > gold or product == null):
		print("Product not found or not sufficient gold to upgrade")
		return null
	elif(gold >= upgrade_price):
		product.upgrade()
		print("Succesfully upgraded", product.card_name)
		return(product)
	
func display():
	return{"Name of card is": product.card_name, "Price of card is": product.money,
	"Card description": product.description}
	
func _on_buy_card_pressed() -> void:
	press_buy()

func _on_card_to_upgrade_pressed() -> void:
	press_upgrade()
