extends Node2D

# 1. need to load scene
@export var meteor_scene: PackedScene = load("res://Scene/meteor.tscn")
@export var laser_scene: PackedScene = load("res://Scene/laser.tscn")

var health := 3;

func _ready() -> void:
	get_tree().call_group('UI', 'set_health', health)
	var size := get_viewport().get_visible_rect().size
	var rng := RandomNumberGenerator.new()
	for star in $Stars.get_children():
		var random_x = rng.randi_range(0, size.x)
		var random_y = rng.randi_range(0, size.y)
		star.position = Vector2(random_x, random_y)
		
		var random_scale = rng.randf_range(0,1)
		star.scale = Vector2(random_scale, random_scale)
		
		star.speed_scale = rng.randf_range(0.5, 1.4)
		

func _on_meteor_timer_timeout():
#	2. create an instance
	var meteor = meteor_scene.instantiate()
	
#	3. attach node to the scene tree
	$Meteor.add_child(meteor)
	
	# connect signal that creaeted in meteor script
	meteor.connect('collision', _on_meteor_collision)


func _on_meteor_collision() -> void:
	health -= 1
	get_tree().call_group('UI', 'set_health', health)
	if(health <= 0):
		get_tree().change_scene_to_file('res://Scene/game_over.tscn')
		
	$Player.play_collsion_sound()
	
	
func _on_player_laser(pos) -> void:
	var laser = laser_scene.instantiate();
	$Laser.add_child(laser)
	laser.position = pos
