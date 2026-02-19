extends Area2D
class_name CollidableComponent

@export var shape: CollisionShape2D
@export var boost = 0.0
@export var pollen = 0
@export var nectar = 0


func _on_body_entered(body):
	if body is Launchable:
		if body.is_current_launch:
			body.linear_velocity.y -= boost * 150
			var delta = body.position - global_position
			body.linear_velocity += delta.normalized() * boost * 50
			$Compass.rotation = delta.angle()
			print("delta: ", delta.angle())
