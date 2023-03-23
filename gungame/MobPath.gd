extends Path2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity_x = lerp(get_position()[0], (ShipVariables.ship_position[0]), 0.02)
	var velocity_y = lerp(get_position()[1], (ShipVariables.ship_position[1]), 0.02)
	set_position(Vector2(velocity_x, velocity_y))
