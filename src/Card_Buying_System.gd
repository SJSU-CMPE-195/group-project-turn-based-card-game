# Create system to buy cards, integrating shop with combat scene
extends Control
class_name Card_Buying_System
@export var Menu_Scene: PackedScene
@export var card_cost = 3
@export var reward_cost = 4
@export var upgrade_cost = 5
@export var beginning_gold = 10
@export var gain = false
var player_gold = 10

func purchase(cost: int):
	if(player_gold > cost):
		return true
	return false

func buy_card():
	var c_cost
	c_cost = card_cost
	if (purchase(card_cost) == true):
		player_gold = player_gold - c_cost
	else:
		print("Not sufficient gold to buy card")
		
func upgrade_card():
	var u_cost
	u_cost = upgrade_cost
	if(purchase(upgrade_cost) == true):
		player_gold = player_gold - u_cost
	else:
		print("Not sufficient gold to upgrade card")

func toggle_reward():
	gain = !gain
	return gain

func earn_reward():
	print("Do rewards to earn more gold")
	# Will write more logic 

func gain_gold():
	var r_cost
	earn_reward()
	r_cost = reward_cost
	if(toggle_reward() == true):
		player_gold = player_gold + r_cost
		print(reward_cost, " gold reward earned")
		toggle_reward()

func _on_option_button_item_selected(index: int) -> void:
	var root
	var menu
	menu = Menu_Scene.instantiate()
	if(index == 0):
		root = get_tree().root
		root.add_child(menu)
		self.hide()
	elif(index == 1):
		if(buy_card() == null):
			print("Buying still in progress")
		else:
			buy_card()
			print("Player gold is ", player_gold)
	elif(index == 2):
		if(gain_gold() == null):
			print("Gaining still in progress")
		else:
			gain_gold()
			print("Player gold is ", player_gold)
	elif(index == 3):
		if(upgrade_card() == null):
			print("Upgrade still in progress")
		else:
			upgrade_card()
			print("Player gold is ", player_gold)
		
