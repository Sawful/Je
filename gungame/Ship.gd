extends Area2D

#Load Laser scene
var LASER = preload("res://shot.tscn")

#Get attack timer
@onready var attackTimer = $AttackTimer

#Signal set
signal hit

#Get screen size
var screen_size

#stats
@export var speed = 400 # How fast the player will move (pixels/sec).



func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	
	#Look at mouse
	var mouse_direction = get_global_mouse_position()		
	look_at(mouse_direction)
	
	#Move
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed	
		
	position += velocity * delta
	#Send position to Singleton
	ShipVariables.ship_position = position

#Shoot function
func shoot_laser(laser_direction: Vector2):
	
	if LASER:
		var laser = LASER.instantiate()
		get_tree().current_scene.add_child(laser)
		laser.global_position = self.global_position
	
		var laser_rotation = laser_direction.angle()
		laser.rotation = laser_rotation
	

func start(pos):
	position = pos
	show()
	$Ship_Collision.disabled = false

func _on_body_entered(_body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$Ship_Collision.set_deferred("disabled", true)

func _on_conductor_beat_signal(_position):
	var laser_direction = self.global_position.direction_to(get_global_mouse_position())
	shoot_laser(laser_direction)
	attackTimer.start()
