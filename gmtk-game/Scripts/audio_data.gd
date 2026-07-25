class_name AudioDatabase

enum AudioStyle { 
	MUSIC_BACKGROUND, 
	SFX_HIGHLIGHT_CARD, 
	SFX_SELECT_CARD, 
	SFX_CARD_OPENHAND, 
	SFX_CARD_CLOSEHAND, 
	SFX_ARRIVED_GOAL, 
	SFX_FORWARD_MOVE,
	SFX_DEATH,
	SFX_FORWARD_JUMP,
	}

static var AUDIO_SCENES : Array[String] = []
static var audioNodes : Array[Node2D]
static var audioStreamStrs : Array[String]
static var audio_styles_list_sttc : Array[AudioStyle]
static var audioCount : int = 0

static var audioMasterVolume : float = 0.0
static var audioMgrNode : Node2D

static func _inital_volume_values() -> void:
	#Exactly half the volume
	audioMasterVolume = 0.0

static func _reset_volume_values() -> void:
	audioMasterVolume = SaveLoadHelper.save_data.get("game", 1).get("audio", 1).get("volume", 1).get("master", 1)

static func _set_current_volumes() -> void:
	_set_master_volume()

static func _load_audio_scenes() -> void:
	AUDIO_SCENES.clear()
	var dir := DirAccess.open("res://Audio")
	if dir == null:
		push_error("AudioDatabase: Could not open res://Audio directory.")
		return

	var audio_regex := RegEx.new()
	audio_regex.compile("^audio_(\\d{2})_.*\\.tscn$")

	dir.list_dir_begin()
	var file_name := dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and audio_regex.search(file_name):
			AUDIO_SCENES.append("res://Audio/%s" % file_name)
		file_name = dir.get_next()
	dir.list_dir_end()

	AUDIO_SCENES.sort()

static func _load_audio_streams() -> void:
	audioStreamStrs.clear()
	var dir := DirAccess.open("res://Audio")
	if dir == null:
		push_error("AudioDatabase: Could not open res://Audio directory.")
		return

	var audio_regex := RegEx.new()
	audio_regex.compile("^Audio_(\\d{2})_.*\\[.mp3, .ogg]$")

	dir.list_dir_begin()
	var file_name := dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and audio_regex.search(file_name):
			audioStreamStrs.append("res://Audio/%s" % file_name)
		file_name = dir.get_next()
	dir.list_dir_end()

	audioStreamStrs.sort()


static func _set_values() -> void:
	_load_audio_scenes()
	_load_audio_streams()
	audioCount = AUDIO_SCENES.size()
	print("Audio Files Count: ", audioCount)
	print(AUDIO_SCENES)
	print(audioStreamStrs)
	print("All Audio Loaded!")

static func _set_master_volume() -> void:
	for k in audioCount:
		var audioStreamPlayer = audioNodes[k].get_child(0) as AudioStreamPlayer2D
		audioStreamPlayer.volume_db = linear_to_db(audioMasterVolume)
