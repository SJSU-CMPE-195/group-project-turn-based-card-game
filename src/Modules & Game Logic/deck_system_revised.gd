extends Control
@export var scene: PackedScene
@onready var vertical_deck = $VerticalDeckContainer
@onready var player_hand = $"../Hand"
# @onready var player_hand = $VerticalDeckContainer/HorizontalContainerHand
@onready var horizontal_discard = $VerticalDeckContainer/DiscardPileHorizontal
@onready var button_interface = $VerticalDeckContainer/ButtonInterface
var fireball = preload("res://Cards/Fireball/fireball.tres")
var shield = preload("res://Cards/Shield/shield.tres")
var heal = preload("res://Cards/Heal/heal.tres")
var poison = preload("res://Cards/Poison/poison.tres")

# deck has three cards of each minimum
var deck = [poison.duplicate(), fireball.duplicate(), heal.duplicate(), shield.duplicate(), fireball.duplicate(), heal.duplicate(), shield.duplicate(),
fireball.duplicate(), heal.duplicate(), shield.duplicate()] 

# player draws from cards, duplicate of deck
var cards = deck.duplicate()

#hand is what player has
var hand: Array[Data_Card] = []

# removed/used cards go in discard pile
var discard_pile = []

func _ready():
	CombatManager.deck_manager = self

func draw_card():
	if(player_hand == null):
		print("Drawing card is done in combat")
		return
	var size
	var front
	size = cards.size()
	if size <= 0:
		print("Zero cards remaining, cannot draw")
	else:
		front = cards.pop_front()
		hand.push_back(front)
		#show_hand() 
		print("Card drawn successfully!")
		var card_in_hand = front.card_scene.instantiate()
		player_hand.add_card(card_in_hand)

func remove_card(card): # add card to discard pile, remove from hand
	player_hand.remove_card(card)
	discard_pile.push_back(card)
	#show_discard()
	
func add_card(card): 
	var card_duplicate
	card_duplicate = card.duplicate(true)
	cards.push_back(card_duplicate)
	deck.push_back(card_duplicate)
	
func reset_card_deck(): # removed cards returned to initial deck, shuffle deck
	if(player_hand == null):
		print("Resetting card deck is done in combat")
		return
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
	for i in player_hand.get_children():
		player_hand.remove_child(i)
		i.free()
	for j in hand:
		card_in_hand = j.card_scene.instantiate()
		player_hand.add_card(card_in_hand)
	
func show_discard():
	var card_in_discard
	for i in horizontal_discard.get_children():
		horizontal_discard.remove_child(i)
		i.free()
	for j in discard_pile:
		card_in_discard = j.card_scene.instantiate()
		horizontal_discard.add_child(card_in_discard)

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
