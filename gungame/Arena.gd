extends Node2D
#Load Ship and Mob scenes to spawn them
var SHIP = preload("res://ship.tscn")
var MOB = preload("res://mob.tscn")

func _ready():
	#Spawn Ship
	var ship = SHIP.instantiate()
	get_tree().current_scene.add_child(ship)


func _process(_delta):
	print($SpawnTimer.get_time_left())


func _on_spawn_timer_timeout():
		print("spawned")
	# Create a new instance of the Mob scene.
		var mob = MOB.instantiate()

	# Choose a random location on Path2D.
		var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
		mob_spawn_location.progress_ratio = randf()
	
	# Set the mob's direction perpendicular to the path direction.
		var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
		mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
		direction += randf_range(-PI / 4, PI / 4)
		mob.rotation = direction

	# Choose the velocity for the mob.
		var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
		mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
		add_child(mob)
		$SpawnTimer.start()
