extends Area2D

@export var SPEED = 600
@export var attack_damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += SPEED * direction * delta

func destroy():
	queue_free()
	
	
func _on_area_entered(_area):
	destroy()


func _on_body_entered(body):
	body.health -= attack_damage
	
	destroy()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
