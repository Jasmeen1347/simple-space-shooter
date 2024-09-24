extends CanvasLayer

var image = load('res://Assets/Graphics/PNG/UI/playerLife1_red.png')
var time_elapsed := 0

func set_health(healthCount) -> void:
	# remove all childern of Hboxcontainer
	for child in $HBoxContainer.get_children():
		#remove_child(child)
		child.queue_free()
	# add number of child = helath count in hbox container
	#
	for i in healthCount:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		$HBoxContainer.add_child(text_rect)
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP


func _on_score_timer_timeout() -> void:
	time_elapsed += 1
	$MarginContainer/Label.text = str(time_elapsed)
	Global.score = time_elapsed
