extends Node2D

class_name Mover

@export var travelPoss : Array[Vector2]

@export var lerpStart = 0.0
@export var lerpEnd = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _movement() -> void:
	pass
