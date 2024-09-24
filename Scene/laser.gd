extends Area2D


@export var speed: int = 600 

func _ready() -> void:
	$Sprite2D.scale = Vector2(0, 1)
	var tween = create_tween() # in between
	tween.tween_property($Sprite2D, 'scale', Vector2(1,1), 0.1)
	
	
	
func _process(delta: float) -> void:
	position.y -= speed * delta
