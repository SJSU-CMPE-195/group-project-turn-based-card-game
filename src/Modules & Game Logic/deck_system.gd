extends Node
class_name Deck

@onready var draw = $Card_drawn
var deck = []
var hand = []
var single_card
var cards = []
var removed_card = []

## func is_empty():
##	if cards.empty():
##		return
		
func draw_card():
	if cards.empty():
		return
	var front = cards.pop_front()
	# removed_card = removed_card + [front]
	hand = hand + [front]
	return(front)

func discard_card(card):
	removed_card = removed_card + [card]
	
func add_card(card):
	cards = cards + [card]

func remove_card(card):
	cards.erase(card)
	
func reset_card_deck():
	cards = cards + removed_card
	removed_card = []
	shuffle_card_deck()
	
func shuffle_card_deck():
	cards.shuffle()
	print("Deck has been shuffled.")

func obtain_top_card():
	if cards.empty():
		return
	else:
		return(cards[0])

func duplicate_card(card):
	return(card.duplicate(true))

func _on_cards_deck_button_pressed() -> void:
	single_card = draw_card()
	if(single_card != null):
		var name = single_card.name
		var text = draw.text
		draw.text = name
	else:
		return
		
