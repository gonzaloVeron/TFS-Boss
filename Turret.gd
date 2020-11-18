extends Node2D

onready var timer_shooting_cooldown :Timer = $TimerShootingCD
var target

onready var bullet_scene = preload("res://obstacles/guns/turret/Bullet.tscn")
onready var bullet_start_position:Position2D = $Position2DStartOfProyectile

func _ready():
	print("en torreta ready")
	print(bullet_start_position.position)
	print(bullet_start_position.global_position)
	
	pass # Replace with function body.



func shoot():
	var bullet = bullet_scene.instance()
	bullet.set_target(target)
	#bullet.global_position = bullet_start_position.global_position
	#bullet.fly(direction.rotated(rotation))
	
	bullet.position = bullet.get_parent().position
	get_tree().get_root().add_child(bullet)
	bullet.global_position = bullet_start_position.global_position
	
	#var new_bullet = bullet_scene.instance()
	#new_bullet.global_position = bullet_start_position.global_position
	#new_bullet.set_target(target)
	#add_child(new_bullet)
	#var roc = rocket.instance()
	#get_tree().get_root().add_child(roc)
	#roc.global_position = global_position
	#var dir = (get_player().global_position - global_position).normalized()
	#roc.global_rotation = dir.angle() + PI / 2.0
	#roc.direction = dir



func _on_Area2DDetection_body_entered(body):
	if body.is_in_group("player"):
		target = body
		shoot()
		timer_shooting_cooldown.start()
	pass # Replace with function body.


func _on_Area2DDetection_body_exited(body):
	if body.is_in_group("player"):
		target = null
		timer_shooting_cooldown.stop()
	pass # Replace with function body.


func _on_TimerShootingCD_timeout():
	shoot()
	pass # Replace with function body.