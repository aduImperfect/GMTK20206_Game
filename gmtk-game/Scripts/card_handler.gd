extends Sprite2D

@export var cardTypeVal : CardType.CARD_TYPE_ENUM
@export var zIndex : int
@export var cardDeckPosition : Vector2
@export var cardHandPosition : Vector2
@export var cardSpeed : float

@export var startLerp : float
@export var endLerp : float
@export var lerpVal : float
@export var lerped : bool
@export var revLerp : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cardSpeed = 1.0
	startLerp = 0.0
	endLerp = 1.0
	lerpVal = 0.0
	lerped = false
	revLerp = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if CardsHelper.cardTextures.size() != CardType.CARD_TYPE_ENUM.size():
		return

	texture = CardsHelper.cardTextures[int(cardTypeVal)]
	z_index = zIndex

	if cardHandPosition.is_equal_approx(global_position):
		return

	if lerped == false:
		lerpVal += _delta * cardSpeed
		if lerpVal <= endLerp:
			if revLerp == false:
				global_position = lerp(cardDeckPosition, cardHandPosition, lerpVal)
			else:
				global_position = lerp(cardHandPosition, cardDeckPosition, lerpVal)
		else:
			#Get it ready for the reverse lerp!
			revLerp = !revLerp
			lerpVal = 0.0
			lerped = true
			if revLerp == false:
				cardHandPosition = cardDeckPosition
				CardsHelper.cardLevelOpenInit = false
