extends Node
class_name Upgrade_shop
# description: logic for upgrade shop

@export var product: Data_Card
@export var gold: int
@export var upgrade_price: int = 400

func product_found(): # function to confirm if product found
	if(product != null):
		return true
	else:
		return false
		
func upgrade_card(gold: int): 
	if (product == null): # Card not found
		print("Product not found")
		return null
	elif(upgrade_price > gold): # Price of upgrading more than amount of gold user has
		print("Not sufficient gold to upgrade ", product.card_name)
	elif(gold >= upgrade_price): # Sufficient money to upgrade
		product.upgrade()
		print(product.card_name, " has been upgraded")
		return(product)
		
