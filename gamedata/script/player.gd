extends KinematicBody2D

var speed := 300

var up_direction := Vector2(0, 0)


func _physics_process(delta):
	var move_direction = G.GRAVITY
	
	if Input.is_action_pressed("move_right"):
		move_direction.x = 1
	elif Input.is_action_pressed("move_left"):
		move_direction.x = -1

	move_and_slide(move_direction * speed, up_direction)
