extends Node
class_name Deck

# correpond to Card_drawn label
@onready var draw = $Card_drawn
# variable declaration for deck system
var deck = []
var hand = []
var single_card
var cards = []
var removed_card = []

func draw_card(): # function to draw card from deck
	if cards.empty():
		return
	var front = cards.pop_front()
	# removed_card = removed_card + [front]
	hand = hand + [front]
	return(front)

func discard_card(card): # add card to discard pile
	removed_card = removed_card + [card]
	
func add_card(card): # add new card
	cards = cards + [card]

func remove_card(card): # remove card from deck
	cards.erase(card)
	
func reset_card_deck(): # removed cards returned to initial deck, shuffle deck
	cards = cards + removed_card
	removed_card = []
	shuffle_card_deck()
	
func shuffle_card_deck(): # Shuffle deck of cards
	cards.shuffle()
	print("Deck has been shuffled.")

func obtain_top_card(): # Get top card
	if cards.empty():
		return
	else:
		return(cards[0])

func duplicate_card(card): # Make copy of card
	return(card.duplicate(true))

func _on_cards_deck_button_pressed() -> void: # Button to draw card when pressed
	single_card = draw_card()
	if(single_card != null): # If card found
		var name = single_card.name
		var text = draw.text
		draw.text = name
	else: # If card not found
		return
		
