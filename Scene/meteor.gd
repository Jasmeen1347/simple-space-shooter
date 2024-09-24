extends Area2D

var speed: int
var rotation_speed: int
var direction_x: float
signal collision 
var can_collide = true

func _ready():
	var rng := RandomNumberGenerator.new()
	var names = ["big1", "big2", "big3", "big4"]
	var path: String = "res://Assets/Graphics/PNG/Meteors/meteorBrown_"+ names[rng.randi_range(0, len(names) - 1)]+".png"
	$Sprite2D.texture = load(path)
#	set start position
	var width = get_viewport().get_visible_rect().size[0] # [width, hight]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	position = Vector2(random_x, random_y) # this will set random position betweem viewports
	
	speed = rng.randi_range(200, 300)
	#direction_x = rng.randf_range(-1, 1)
	rotation_speed = rng.randi_range(40, 100)
	
	
func _process(delta):
	position += Vector2(direction_x, 1) * speed * delta
	rotation_degrees += rotation_speed * delta

func _on_body_entered(body):
	if can_collide:
		collision.emit()


func _on_area_entered(area: Area2D) -> void:
	area.queue_free() # remove laser from scene
	can_collide = false
	$ExplosionSound.play()
	$Sprite2D.hide()
	await get_tree().create_timer(0.2).timeout
	queue_free() # remove this meteor from scene
