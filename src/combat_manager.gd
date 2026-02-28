extends Node

var selected_ally: AllyUnit
var selected_enemy: Enemy

var all_cards: Array

func _ready():
	await cards_are_ready()
	get_tree().node_added.connect(find_new_cards)
	
	find_existing_cards()
	
	
func cardChosen(card: Card) -> void:
	print("CombatManager has detected: ", card.card_name);
	
func cards_are_ready():
	while get_tree().get_nodes_in_group("Cards In Scene").size() == 0:
		await get_tree().process_frame
		
	
func find_new_cards(node: Node) -> void:
	if node is Card:
		node.card_clicked_sig.disconnect(cardChosen)
		node.card_clicked_sig.connect(cardChosen)
		
			
			
	

func find_existing_cards() -> void:
	await get_tree().process_frame
	all_cards = get_tree().get_nodes_in_group("Cards In Scene")
	print("card array size: ", all_cards.size())
	
	for card in all_cards:
		print("finding cards")
		if card.has_signal("card_clicked_sig"):
			card.card_clicked_sig.connect(cardChosen)
			
