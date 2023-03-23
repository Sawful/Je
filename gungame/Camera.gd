extends Camera2D
@export var camera_zoom = 0.6


# Called when the node enters the scene tree for the first time.
func _ready():
	
	zoom = Vector2(camera_zoom, camera_zoom)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var velocity_x = ShipVariables.ship_position[0]
	var velocity_y = ShipVariables.ship_position[1]
	set_position(Vector2(velocity_x, velocity_y))
