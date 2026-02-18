extends Node
class_name Unit

# list of parameters
var health: int
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
