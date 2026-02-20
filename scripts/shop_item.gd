
extends Control
class_name ShopItem


@export var item_frame: TextureRect
var hovering: bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	item_frame.pivot_offset_ratio = Vector2(0.5, 0.5)


func _process(_delta):
	pass


func _on_mouse_entered():
	hovering = true
	item_frame.scale = Vector2(1.2, 1.2)


func _on_mouse_exited():
	hovering = false
	item_frame.scale = Vector2(1, 1)


func is_mouse_over_card() -> bool:
	var mouse_pos: Vector2 = get_global_mouse_position()
	var sprite_rect = Rect2(item_frame.global_position, item_frame.texture.get_size())
	return sprite_rect.has_point(mouse_pos)


func _input(event) -> void: 
	# Detects if mouse is hovering and clicks
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and hovering:
			# Do stuff here
		   
			#Delete item
			self.queue_free()
