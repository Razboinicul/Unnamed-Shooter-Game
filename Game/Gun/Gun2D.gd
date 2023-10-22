extends Node2D

func _process(delta):
	if $AnimatedSprite2D.is_playing():
		Global.can_shoot = false
	else:
		Global.can_shoot = true
	if Global.shooting:
		$AnimatedSprite2D.play("shoot")
		Global.can_shoot = false

#func _input(event):
#	if event.is_action_pressed("shoot") and not Global.shooting and Global.can_shoot:
#		Global.shooting = true
#	else:
#		Global.shooting = false
