extends Node
class_name Shop


@export var shop_item: PackedScene
@export var card_container: HBoxContainer


func _ready() -> void:
	# Create 6 shop items
	for i in range(6):
		var wrapper = Control.new()
		var sell_card_instance = shop_item.instantiate()
		card_container.add_child(sell_card_instance)


# Change to previous scene
func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(Global.prev_scene_path) # or get_tree().change_scene_to_file("res://world_map.tscn")
