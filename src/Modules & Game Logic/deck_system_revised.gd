extends Control
@export var scene: PackedScene
@onready var vertical_deck = $VerticalDeckContainer
@onready var horizontal_hand = $VerticalDeckContainer/HorizontalContainerHand
@onready var horizontal_discard = $VerticalDeckContainer/DiscardPileHorizontal
@onready var button_interface = $VerticalDeckContainer/ButtonInterface
var fireball = preload("res://Cards/Fireball/fireball.tres")
var shield = preload("res://Cards/Shield/shield.tres")
var heal = preload("res://Cards/Heal/heal.tres")

# deck has three cards of each minimum
var deck = [fireball, heal, shield, fireball.duplicate(), heal.duplicate(), shield.duplicate(),
fireball.duplicate(), heal.duplicate(), shield.duplicate()] 

# player draws from cards, duplicate of deck
var cards = deck.duplicate()

#hand is what player has
var hand = []

# removed/used cards go in discard pile
var discard_pile = []

func draw_card():
	var size
	var front
	size = cards.size()
	if size <= 0:
		print("Zero cards remaining, cannot draw")
		return null
	else:
		front = cards.pop_front()
		hand.push_back(front)
		show_hand() 
		print("Card drawn successfully!")
		return(front)

func remove_card(card): # add card to discard pile, remove from hand
	hand.erase(card)
	show_hand()
	discard_pile.push_back(card)
	show_discard()
	
func add_card(card): 
	var card_duplicate
	card_duplicate = card.duplicate(true)
	cards.push_back(card_duplicate)
	deck.push_back(card_duplicate)
	
func reset_card_deck(): # removed cards returned to initial deck, shuffle deck
	discard_pile = []
	hand = []
	cards = deck.duplicate()
	show_hand()
	show_discard()
	print("Deck has been reset successfully.")
	
func shuffle_card_deck(): 
	cards.shuffle()
	print("Deck has been shuffled successfully.")

func obtain_top_card():
	if cards.empty():
		return null
	else:
		return(cards[0])

func duplicate_card(card):
	return(card.duplicate(true))

func show_hand():
	var card_in_hand
	for i in horizontal_hand.get_children():
		horizontal_hand.remove_child(i)
		i.free()
	for j in hand:
		card_in_hand = scene.instantiate()
		horizontal_hand.add_child(card_in_hand)
		card_in_hand.card_type = j.card_type
		card_in_hand.card_name = j.card_name
		card_in_hand.description = j.description
	
func show_discard():
	var card_in_discard
	for i in horizontal_discard.get_children():
		horizontal_discard.remove_child(i)
		i.free()
	for j in discard_pile:
		card_in_discard = scene.instantiate()
		horizontal_discard.add_child(card_in_discard)
		card_in_discard.card_type = j.card_type
		card_in_discard.card_name = j.card_name
		card_in_discard.description = j.description

func _on_reset_button_pressed() -> void:
	reset_card_deck()
	
func _on_shuffle_button_pressed() -> void:
	shuffle_card_deck()
	
func _on_draw_button_pressed() -> void:
	var flag = true # remove variable
	if(flag == true): # replace code with when card can be drawn
		draw_card()
	else: # scenario when card cannot be drawn
		return
	
func _on_remove_button_pressed() -> void:
	var size
	size = hand.size()
	if(size <= 0):
		print("Can't remove card")
	else:
		remove_card(hand[0])
		print("Card removed succsssfully")
