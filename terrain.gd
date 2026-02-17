extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var curve = $BaseShape.curve
	var poly = curve.get_baked_points()
	
	$FillPolygon.polygon = poly
	$Outline.points = poly
	#TODO: break the collision poly into chunks using geometry class
	# make 1000-width rects to cover extent of terrain
	# intersect with copies of polygon
	$CollisionPolygon.polygon = poly

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
