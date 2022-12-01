extends KinematicBody2D

const MOVE_SPEED = 300
const JUMP_FORCE = 1000
const POWER_JUMP_FORCE = 2000
const GRAVITY = 50
const MAX_FALL_SPEED = 1500

onready var anim_player = $anim_player
onready var player_sprite = $player_sprite
onready var collision_body = $collision_body

var y_velocity = 0
var facing_right = true


func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)

func animation(grounded, move_direction):
	if grounded:
		if move_direction == 0:
			play_anim("idle")
		else:
			play_anim("walk")
	else:
		play_anim("jump")

func _physics_process(delta):
	var move_direction = 0
	var grounded = is_on_floor()
	
	movement(delta, move_direction, grounded)
	jump()

func movement(delta, move_direction, grounded):
	if Input.is_action_pressed("move_right"):
		move_direction += 1
	if Input.is_action_pressed("move_left"):
		move_direction -= 1
	move_and_slide(Vector2(move_direction * MOVE_SPEED, y_velocity), Vector2(0, -1))
	turning(move_direction)
	animation(grounded, move_direction)

func jump(grounded = is_on_floor()):						# Функция прыжка.
	y_velocity += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		y_velocity = -JUMP_FORCE
	if grounded and y_velocity >= 0:
		y_velocity = 5
	if y_velocity > MAX_FALL_SPEED:
		y_velocity = MAX_FALL_SPEED

func flip():
	facing_right = !facing_right
	player_sprite.flip_h = !facing_right
	if facing_right == false and Input.is_action_pressed("move_left"):
		player_sprite.set_offset(Vector2(-22,0))
		collision_body.set_position(Vector2(-5.893,120.239))
		print(collision_body.position)
	else:
		player_sprite.set_offset(Vector2(22,0))
		collision_body.set_position(Vector2(5.893,120.239))

func turning(move_direction):						# Отражает спрайт по горизонтали 
	if facing_right and move_direction < 0:
		flip()
	if !facing_right and move_direction > 0:
		flip()
