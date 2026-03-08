extends Resource
class_name Data_Card

@export_enum("Spell", "Attack", "Defense") var card_type: String = "Defense"
@export var rank: int = 1
@export var highest_rank: int = 10
@export var money: int = 100
@export var cost: int = 5
@export var damage: int = 10
@export var art: Texture2D
@export var block: int = 0
@export var status_script: Script
@export_multiline var description: String = "Description of card"
@export var card_name: String = "Name of card"

func buy(gold: int):
	if(gold > money):
		return true
	elif(gold == money):
		return true
	elif(money > gold):
		return false

func upgrade():
	if(rank >= highest_rank):
		return null
	else:
		rank = rank + 1
		damage = damage + 10
		block = block + 10
	
func effects(user: Unit, target: Unit):
	if target != null:
		if damage > 0:
			target.take_damage(damage)
		if status_script != null:
			var new_effect
			new_effect = status_script.new()
			target.apply_status_effect(new_effect)
	if block > 0:
		user.add_block(block)
