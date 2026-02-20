extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var curve = $BaseShape.curve
	#var curve_length = curve.point_count
	var first_point = curve.get_point_position(0)
	var last_point = curve.get_point_position(curve.point_count - 1)
	print("first: ",first_point,"\nlast: ",last_point)
	curve.add_point(Vector2(last_point.x + 100000,last_point.y-10))
	curve.add_point(Vector2(last_point.x + 100000,3000))
	curve.add_point(Vector2(first_point.x - 5000,3000))
	curve.add_point(Vector2(first_point.x - 5000,first_point.y-1000))
	var poly = curve.get_baked_points()
	curve.remove_point(curve.point_count-1)
	curve.remove_point(curve.point_count-1)
	curve.remove_point(curve.point_count-1)
	curve.remove_point(curve.point_count-1)
	
	$FillPolygon.polygon = poly
	$Outline.points = poly
	#TODO: break the collision poly into chunks using geometry class
	# make 1000-width rects to cover extent of terrain
	# intersect with copies of polygon
	$CollisionPolygon.polygon = poly

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
