extends Resource
class_name Data_Card

@export_enum("Spell", "Attack", "Defense") var card_type: String = "Defense"
# @export var card_type: String = "not set"
# @export var rank: int = 1
@export var cost: int = 5
@export var damage: int = 10
@export var art: Texture2D
@export_multiline var description: String = "description"
@export var card_name: String = "Name"
