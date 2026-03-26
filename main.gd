extends Control

var deck_manager := DeckManager.new()
var deck: Array = []
var player_hand: Array = []

@onready var deck_count_label = $VBoxContainer/DeckCountLabel
@onready var drawn_card_label = $VBoxContainer/DrawnCardLabel
@onready var cards_left_label = $VBoxContainer/CardsLeftLabel
@onready var draw_button = $VBoxContainer/DrawButton
@onready var hand_deck_label = $VBoxContainer2/HandDeckLabel

func add_card_to_player():
	player_hand.clear()
	
	for i in range(4):
		if not deck.is_empty():
			player_hand.append(deck.pop_back())

func _ready() -> void:
	deck = deck_manager.create_deck()
	deck.shuffle()
	deal_initial_hand()
	update_ui()

func deal_initial_hand():
	player_hand.clear()
	for i in range(4):
		if not deck.is_empty():
			player_hand.append(deck.pop_back())
			 
func create_deck() -> Array:
	var new_deck: Array = []

	var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
	var ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]

	for suit in suits:
		for rank in ranks:
			new_deck.append({
				"rank": rank,
				"suit": suit,
				"is_joker": false
			})

	# Add 4 jokers to make 56 cards total
	for i in range(4):
		new_deck.append({
			"rank": "Joker",
			"suit": "",
			"is_joker": true
		})

	return new_deck

func draw_card() -> Dictionary:
	if deck.is_empty():
		return {}
	return deck.pop_back()

func format_card(card: Dictionary) -> String:
	if card.is_empty():
		return "No card"

	if card["is_joker"]:
		return "Joker"

	return str(card["rank"]) + " of " + str(card["suit"])

func update_ui():
	var hand_text = ""
	for card in player_hand:
		hand_text += deck_manager.format_card(card) + "\n"
	$HandDeckLabel.text = hand_text

func _on_draw_button_pressed() -> void:
	var card = draw_card()
	drawn_card_label.text = "Drawn Card: " + format_card(card)
	player_hand.append(format_card(card))
	update_ui()
