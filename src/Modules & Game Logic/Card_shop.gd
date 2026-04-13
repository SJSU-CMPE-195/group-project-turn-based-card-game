extends Node
class_name Card_shop
# description: logic for card shop

# variable declaration
# @export var product: Data_Card
@export var fireball: Data_Card
@export var shield: Data_Card
@export var heal: Data_Card
@export var gold: int
# @export var cardupgrade: Data_Card
@export var upgrade_price: int = 400

func product_found(card: Data_Card): # validate if product found
	if(card != null):
		return true
	else:
		return false

func buy(card: Data_Card): # buy product and update gold
	if card.money > gold:
		print("Not sufficient gold to purchase ", card.card_name)
		return null
	else:
		gold = gold - card.money # update gold when product purchased
		var copy = card.duplicate()
		return copy	

func press_buy(card: Data_Card):
	var bought = buy(card)
	if(bought != null): # notify what was bought
		print(bought.card_name, " has been purchased, you have ", gold, " gold remaining")

func press_upgrade(card: Data_Card): # function to upgrade
	if(card == null):
		print("Product not found")
	elif (upgrade_price > gold): # User needs to have sufficient gold to upgrade
		print("Not sufficient gold to upgrade")
		return null
	elif(gold >= upgrade_price):
		gold = gold - upgrade_price
		card.upgrade()
		print(card.card_name, " has been upgraded sucessfully, you have ", gold, " gold remaining")
		return(card)
	
func display(card: Data_Card): # output card name, cost, and description to console
	return{"Name of card is": card.card_name, "Price of card is": card.money,
	"Card description": card.description}

func _on_fireball_buy_button_pressed() -> void:
	press_buy(fireball)

func _on_shield_buy_button_pressed() -> void:
	press_buy(shield)
	
func _on_heal_buy_button_pressed() -> void:
	press_buy(heal)

func _on_upgrade_fireball_button_pressed() -> void:
	press_upgrade(fireball)
	
func _on_upgrade_shield_button_pressed() -> void:
	press_upgrade(shield)

func _on_upgrade_heal_button_pressed() -> void:
	press_upgrade(heal)
