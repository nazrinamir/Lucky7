extends RefCounted
class_name DeckManager

func create_deck() -> Array:
	var deck = []
	var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
	var ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]

	var id = 0
	for suit in suits:
		for rank in ranks:
			deck.append({
				"id": id,
				"rank": rank,
				"suit": suit,
				"is_joker": false
			})
			id += 1

	for i in range(4):
		deck.append({
			"id": id,
			"rank": "JOKER",
			"suit": "",
			"is_joker": true
		})
		id += 1

	return deck

func format_card(card: Dictionary) -> String:
	if card.get("is_joker", false):
		return "JOKER"
	return str(card["rank"]) + " of " + str(card["suit"])
