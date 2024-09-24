extends Control

var level_scene: PackedScene = load('res://Scene/level.tscn')


func _ready() -> void:
	$BG/CenterContainer/VBoxContainer/Score.text = str(Global.score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_select'):
		get_tree().change_scene_to_packed(level_scene)
