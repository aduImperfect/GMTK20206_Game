extends Node2D

@export var initialDelayAccumulation : float = 0.0
@export var initialDelayMax : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialDelayAccumulation = 0.0
	initialDelayMax = 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if CardsHelper.cardLevelCloseInit == false:
		initialDelayAccumulation += _delta
		if initialDelayAccumulation > initialDelayMax:
			initialDelayAccumulation = 0.0
			_return_to_deck()
			CardsHelper.cardLevelCloseInit = true


	if CardsHelper.cardLevelOpenInit == false:
		initialDelayAccumulation += _delta
		if initialDelayAccumulation > initialDelayMax:
			initialDelayAccumulation = 0.0
			_draw_starting_hand()
			CardsHelper.cardLevelOpenInit = true

	_update_card_state()

func _draw_starting_hand() -> void:
	#Get current hand size!
	#var k : int = CardsHelper.handNodes.size()
	var k : int = 0
	#Check against hand limit and keep adding to hand till then
	while k < CardsHelper.handLimit:
		CardsHelper.handNodes.push_back(CardsHelper.deckNodes.pop_back())
		k += 1

	print(CardsHelper.handNodes)
	#print("Current level: ", LevelsDatabase.currLevel)

	#print("CardsHelper.handLimits[" + str(LevelsDatabase.currLevel) +  "]: ", CardsHelper.handLimits[LevelsDatabase.currLevel])

	for j in CardsHelper.handNodes.size():
		CardsHelper.handNodes[j].get_child(0).zIndex = -100
		CardsHelper.handNodes[j].get_child(0).cardHandPosition = Vector2(CardsHelper.xCardCenter + (j * CardsHelper.xCardOffset), CardsHelper.yCardCenter)
		#print("CardsHelper.handLimits[" + str(LevelsDatabase.currLevel) +  "][" + str(j) + "]: ", CardsHelper.handLimits[LevelsDatabase.currLevel][j])
		CardsHelper.handNodes[j].get_child(0).cardTypeVal = CardsHelper.handLimits[LevelsDatabase.currLevel][j]

	(AudioDatabase.audioNodes[AudioDatabase.audio_styles_list_sttc[3]].get_child(0) as AudioStreamPlayer2D).play()

func _return_to_deck() -> void:
	#Add back the leftover hand cards back into the deck (if any)!
	while CardsHelper.handNodes.size() != 0:
		CardsHelper.deckNodes.push_front(CardsHelper.handNodes.pop_back())

	#Reset the z indices and the deck positions!
	for j in CardsHelper.deckNodes.size():
		CardsHelper.deckNodes[j].get_child(0).cardTypeVal = CardType.CARD_TYPE_ENUM.BACKSIDE
		CardsHelper.deckNodes[j].get_child(0).zIndex = -500 + (j * 10)
		CardsHelper.deckNodes[j].get_child(0).lerped = false

	(AudioDatabase.audioNodes[AudioDatabase.audio_styles_list_sttc[4]].get_child(0) as AudioStreamPlayer2D).play()

func _update_card_state() -> void:
	#print("Current Hand Card Index: ", InputsData.curr_input_card_index)

	#Reset all cards to unselected and unhighlighted state except current one!
	for k in CardsHelper.handNodes.size():
		if k == InputsData.curr_input_card_index:
			continue
		CardsHelper.handNodes[k].get_child(0).normal_state = true
		CardsHelper.handNodes[k].get_child(0).highlighted_state = false
		CardsHelper.handNodes[k].get_child(0).selected_state = false

	if InputsData.curr_input_card_index < 0:
		return

	if InputsData.curr_input_card_index >= CardsHelper.handLimits[LevelsDatabase.currLevel].size():
		return

	if CardsHelper.handNodes.size() == 0:
		return

	InputsData.curr_input_card_value = CardsHelper.handNodes[InputsData.curr_input_card_index].get_child(0).cardTypeVal
	#print("Current Hand Card Value: ", InputsData.curr_input_card_value)

	CardsHelper.handNodes[InputsData.curr_input_card_index].get_child(0).normal_state = false
	CardsHelper.handNodes[InputsData.curr_input_card_index].get_child(0).highlighted_state = !InputsData.curr_input_card_selected
	CardsHelper.handNodes[InputsData.curr_input_card_index].get_child(0).selected_state = InputsData.curr_input_card_selected
