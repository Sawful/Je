extends RigidBody2D
@export var maximum_speed = 200
@export var max_health = 100
var health = max_health

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	rotate(PI/100)
	
	var velocity_x = clamp(-(get_position()[0] - ShipVariables.ship_position[0]), -maximum_speed, maximum_speed)
	var velocity_y = clamp(-(get_position()[1] - ShipVariables.ship_position[1]), -maximum_speed, maximum_speed)
	
	move_and_collide(Vector2(velocity_x, velocity_y)*0.02)
	
	if health <= 0:
		queue_free()

