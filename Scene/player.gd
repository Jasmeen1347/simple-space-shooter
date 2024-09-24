extends CharacterBody2D


@export var speed := 250
var can_shoot: bool = true


signal laser(pos)
# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(100, 500)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	take input from keyboard key that we set in project setting input map
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * delta * speed
	move_and_collide(velocity)
	
	# shoot laser
	if Input.is_action_just_pressed("shoot") and can_shoot:
		laser.emit($LaserStartPosition.global_position)
		can_shoot = false
		$LaserCooldown.start()
		$LaserSound.play()

func play_collsion_sound() -> void:
	$DamageSound.play()
	
	
func _on_laser_cooldown_timeout() -> void:
	can_shoot = true
