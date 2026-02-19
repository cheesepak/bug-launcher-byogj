extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level.tscn")


func _on_shop_button_pressed() -> void:
	Global.prev_scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://shop.tscn")
