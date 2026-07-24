extends Camera2D

func _ready():
	CameraHelper._set_initial_camera_values_sp()

func _process(_delta : float):
	global_position = CameraHelper.camera_position
