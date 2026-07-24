extends Node2D

@export var initialDelayAccumulation : float = 0.0
@export var initialDelayMax : float = 0.0
@export var initialized : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialDelayAccumulation = 0.0
	initialDelayMax = 0.0
	initialized = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
