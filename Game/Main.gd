extends Node3D

func _process(delta):
	$Control/Gun2D.visible = not Global.aiming
	$Control/Aim.visible = Global.aiming
