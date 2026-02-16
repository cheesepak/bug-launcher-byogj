extends RigidBody2D

var dragging = false
var offset = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		position = get_global_mouse_position() - offset
		


func _on_button_button_down():
	dragging = true
	freeze = true
	offset = get_global_mouse_position() - global_position


func _on_button_button_up():
	dragging = false
	freeze = false
