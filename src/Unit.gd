extends Node
class_name Unit

# list of parameters
var health: int
var highest_health: int = 100
var mana: int
var shield: int
enum status_effect{
	Poison,
	Burn,
	Bleed,
	Heal,
	Stun,
	Dodge
}
var health_regeneration: float
var heal_amp: float

func take_damage(value):
	health = health - value
	if(health <= 0):
		print("The unit has lost all health")
	
func heal(value):
	health = health + value
	if(health > highest_health):
		health = highest_health
		
func add_shield(value):
	shield = shield + value
	
func add_mana(value):
	mana = mana + value

func use_mana(value):
	mana = mana - value

func poison():
	take_damage(3)
	print("3 health points lost from poison")
	# add status effect for poison 
	
func burn():
	take_damage(5)
	print("5 health points lost from burning")
	# add status effect for burn
	
func bleed():
	take_damage(7)
	print("7 health points lost from bleeding")
	# add status effect for bleed
	
func heal_over_time():
	heal(7)
	
