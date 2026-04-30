# Create system to buy cards, integrating shop with combat scene
extends Node
class_name Card_Buying_System
@export var card_cost = 3
@export var reward_cost = 3
@export var upgrade_cost = 5
@export var beginning_gold = 10
@export var gain = false
var player_gold 

func purchase(cost: int):
	if(player_gold > cost):
		return true
	return false

func buy_card(c_cost: int):
	c_cost = card_cost
	if (purchase(card_cost) == true):
		player_gold = player_gold - c_cost
	else:
		print("Not sufficient gold to buy card")
		
func upgrade_card(u_cost: int):
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

func gain_gold(r_cost: int):
	earn_reward()
	r_cost = reward_cost
	if(toggle_reward() == true):
		player_gold = player_gold + r_cost
		print(reward_cost, " gold reward earned")
		toggle_reward()
