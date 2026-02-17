extends AnimatedSprite2D
class_name AllyUnit

var full_health = 100
var player_health = full_health

func _ready():
	play()
	CombatManager.selected_ally = self

func _damage_done(number: int):
	player_health = player_health - number
	if (player_health < 0):
		player_health = 0
	if (player_health == 0):
		_lost()
	print("Health of player is ", player_health)
	
func _heal_player(number: int):
	player_health = player_health + number
	if(player_health > full_health):
		player_health = full_health
	print("Health of player is ", player_health)
	
func _lost():
	print("Player's health has reached minimum value")
