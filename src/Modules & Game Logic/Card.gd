## extends Node
extends Resource
class_name Cards
# (abstract class)

# list of parameters:
var art : Texture2D
var cost: int = 10
enum type_of_card {attack, defense, status, power}
var type: type_of_card 
var name: String = "bob"
var identifier: String = "id1"
var level: int = 1
var recharge_time: float = 5.0
var description: String = ""
var target: int = 1
var tier: int = 1

## func activate() ## Not implemented in this class

## func select_targets() ## helper function to assign target
