extends Node
class_name Deck

##var deck = []
## var hand = []
var cards = []
var removed_card = []

## func is_empty():
##	if cards.empty():
##		return
		
func draw_card():
	if cards.empty():
		return
	return cards.pop_front()

func discard_card(card):
	removed_card = removed_card + [card]
	
func add_card(card):
	cards = cards + [card]

func remove_card(card):
	cards.erase(card)
	
func reset_card_deck():
	cards = cards + removed_card
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
