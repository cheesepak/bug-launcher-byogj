extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_input(InputEventKey)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Press any button to change scene
func _input(event) -> void: 
	if (event is InputEventKey and event.is_pressed()) or Input.is_action_just_pressed("Left_Click"):
		get_tree().change_scene_to_file("res://world_map.tscn")
