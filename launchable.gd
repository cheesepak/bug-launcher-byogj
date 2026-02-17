extends RigidBody2D

var launched = false
var launch_power = 0.0
var max_launch_power = 1500.0
var mouse_th = 100
var mouse_pos = Vector2.ZERO
var armed = false
var hover = false
var done = false

signal im_done

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#find relative mouse position
	mouse_pos = get_global_mouse_position() - position
	hover = mouse_pos.length() <= mouse_th
	if armed and not launched:
		#if beyond threshold
		if hover:
			$Meter.visible = false
			launch_power = 0
		else:
			look_at(get_global_mouse_position())
			rotation = rotation-PI
			$Meter.visible = true
			launch_power = launch_power + 1 + launch_power * delta * 3
			if launch_power>max_launch_power * 1.8: launch_power = 0.0
			#print(launch_power)
			$Meter.scale.x = min(launch_power,max_launch_power)/20
	elif launched and not done:
		if linear_velocity.length()<.1 or sleeping:
			sleeping = true
			done = true
			#mass = 1
	
	if done: emit_signal("im_done")
	

func _input(event):
	if event is InputEventMouseButton and not launched:#event.is_action_pressed("Left_Click"):
		if event.pressed and hover:
			armed = true
		elif not event.pressed:
			if armed and not hover:
				launched = true
				linear_velocity = (get_global_mouse_position() - position).normalized() * min(launch_power,max_launch_power) * -3
				$Meter.visible = false
				freeze = false
			armed = false
