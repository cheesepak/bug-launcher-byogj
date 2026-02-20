extends Node

var spawn_coords = Vector2(350,800)
var Launchable = load("res://launchable.tscn")
var Flower = load("res://flower.tscn")
var current_launch
var done_launches = []
var current_zoom = 1
var best_dist = 0
var goal_dist = 20000

func spawn_launchable():
	current_launch = Launchable.instantiate()
	current_launch.position = spawn_coords
	current_launch.is_current_launch = true
	add_child(current_launch)
	current_launch.im_done.connect(_on_launcher_done)

func update_best_mark():
	print("best distance: ", best_dist)
	$BestMarker.position.x = best_dist
	$BestMarker.visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_launchable()
	$GoalMarker.position.x = goal_dist
	#spawn collidables
	var terrain = $Terrain/BaseShape.curve
	var terrain_length = terrain.get_baked_length()
	for i in range(100):
		var flower = Flower.instantiate()
		$Terrain/BaseShape.add_child(flower)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#update best distance
	best_dist = max(best_dist, current_launch.position.x)
	$Camera.position = current_launch.position
	var zoom_delta = max(min(1,500/current_launch.linear_velocity.length()),.2) - current_zoom
	current_zoom += zoom_delta * .006
	$Camera.zoom = Vector2(current_zoom,current_zoom)
	#keep above despawn zone
	$Camera.position.y = min($Camera.position.y, 1080-540/(current_zoom)) #needs work
	$BestMarker.width = 5/current_zoom
	$GoalMarker.width = 5/current_zoom
	#despawn launchable if out of bounds
	if current_launch.position.y > 2000:
		update_best_mark()
		current_launch.queue_free()
		spawn_launchable()

func _on_launcher_done():
	update_best_mark()
	done_launches.append(current_launch)
	current_launch.im_done.disconnect(_on_launcher_done)
	spawn_launchable()
