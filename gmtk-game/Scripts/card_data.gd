class_name CardsHelper

static var CARD_SCENE = preload("res://Scenes/card.tscn")
static var cardNodes : Array[Node2D]

static var cardsCount : int = 0

static var xCardCenter : float = 0.0
static var yCardCenter : float = 0.0
static var xCardOffset : float = 0.0

static var xCardDeckCenter : float = 0.0
static var yCardDeckCenter : float = 0.0

static var xInf : float = 0.0
static var yInf : float = 0.0

static var handLimit : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

static func _set_values() -> void:
	cardsCount = 10
	xCardCenter = 250.0
	yCardCenter = 600.0
	xCardOffset = 100.0
	xCardDeckCenter = 1150.0
	yCardDeckCenter = 600.0
	xInf = -9999.0
	yInf = -9999.0
	handLimit = 4
