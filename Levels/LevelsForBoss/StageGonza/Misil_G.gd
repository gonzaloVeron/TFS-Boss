extends Area2D

export var speed = 350
export var steer_force = 50.0

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var isActive = true

var target
var targetDisabled:Vector2

func start(_transform, _target):
	global_transform = _transform
	velocity = transform.x * speed
	target = _target
	
func _physics_process(delta):
	if(isActive):
		acceleration += seek()
		velocity += acceleration * delta
		velocity = velocity.clamped(speed)
		rotation = velocity.angle()
		position += velocity * delta
	else:
		var direccion = targetDisabled.normalized()
		position += direccion * speed * delta

func seek():
	var steer = Vector2.ZERO
	var desired = (target.global_position - global_position).normalized() * speed
	steer = (desired - velocity).normalized() * steer_force
	return steer

func disable(position):
	isActive = false
	disconnect("body_shape_entered", self, "_on_Misil_G_body_shape_entered")
	remove_from_group("mhook")
	if((abs(global_position.x) - abs(position.x)) > 0):
		targetDisabled = Vector2(abs(position.x), position.y)
	else:
		targetDisabled = position

func _on_LifeTime_timeout():
	queue_free()

func _on_Misil_G_body_shape_entered(body_id, body, body_shape, local_shape):
	queue_free()
	if body.is_in_group("player"):
		body.die()
