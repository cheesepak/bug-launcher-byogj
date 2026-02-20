extends Node2D

@onready var path: PathFollow2D = $".."
@export_range(1,100) var min_speed: float = 10
@export_range(1,100) var max_speed: float = 30
@onready var speed: float = randf_range(min_speed, max_speed) * Utils.norp()
@onready var label: Label = $Label

@onready var terrain_ray: RayCast2D = $TerrainRay
var ground_angle = 0.0
var trapped = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	find_new_spot()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path.progress += speed * delta
	if trapped > 2: find_new_spot()
	label.text = str(ground_angle)
	

func _physics_process(delta: float) -> void:
	terrain_ray.position.x = 10
	if speed < 0: terrain_ray.position.x *= -1
	terrain_ray.force_raycast_update()
	if terrain_ray.is_colliding():
		ground_angle = -180 * terrain_ray.get_collision_normal().angle() / PI - 90
	else: ground_angle = 120
	if abs(ground_angle) > 70:
		speed *= -1
		trapped += 1
	else: trapped = 0


func _on_collidable_component_on_hit() -> void:
	print("i got hit!")
	$AnimationPlayer.play("Respawn")
	
func find_new_spot():
	get_parent().progress_ratio = randf()
