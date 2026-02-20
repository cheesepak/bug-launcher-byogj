extends Area2D
class_name CollidableComponent

@export var shape: CollisionShape2D
@export var boost = 0.0
@export var pollen = 0
@export var nectar = 0

signal on_hit()

func _on_body_entered(body):
	if body is Launchable:
		on_hit.emit()
		if body.is_current_launch:
			body.linear_velocity.y = abs(body.linear_velocity.y) * -1
			body.linear_velocity.y -= boost * 50
			var delta = (body.position - global_position).normalized()
			body.linear_velocity.x += abs(delta.x) * boost * 10
			#$Compass.rotation = delta.angle()
			#print("delta: ", delta.angle())
