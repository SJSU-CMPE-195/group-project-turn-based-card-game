extends Node
class_name Card_shop
# description: logic for card shop

@export var product: Data_Card
@export var fireball: Data_Card
@export var shield: Data_Card
@export var heal: Data_Card
@export var gold: int
@export var cardupgrade: Data_Card
@export var upgrade_price: int = 400

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
	if (product.money > gold):
		print("Not sufficient gold to purchase ", product.card_name)
	elif(gold >= product.money):
		print(bought.card_name, " has been purchased, you have ", gold, " gold remaining")

func press_upgrade():
	if(product == null):
		print("Product not found")
	elif (upgrade_price > gold):
		print("Not sufficient gold to upgrade")
		return null
	elif(gold >= upgrade_price):
		gold = gold - upgrade_price
		product.upgrade()
		print(product.card_name, " has been upgraded, you have ", gold, " gold remaining")
		return(product)
	
func display():
	return{"Name of card is": product.card_name, "Price of card is": product.money,
	"Card description": product.description}
	
func _on_button_to_buy_fireball_pressed() -> void:
	product = fireball
	press_buy()

func _on_button_to_buy_shield_pressed() -> void:
	product = shield
	press_buy()
	
func _on_button_to_buy_heal_pressed() -> void:
	product = heal
	press_buy()

func _on_button_to_upgrade_shield_pressed() -> void:
	product = shield
	press_upgrade()

func _on_button_to_upgrade_heal_pressed() -> void:
	product = heal
	press_upgrade()

func _on_button_to_upgrade_fireball_pressed() -> void:
	product = fireball
	press_upgrade()
