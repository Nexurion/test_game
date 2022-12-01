extends KinematicBody2D

const MOVE_SPEED = 300
const JUMP_FORCE = 1000
const POWER_JUMP_FORCE = 2000
const GRAVITY = 50
const MAX_FALL_SPEED = 1500

onready var anim_player = $anim_player
onready var player_sprite = $player_sprite
onready var collision_body = $collision_body

var y_velo = 0
var facing_right = true


func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)

func _physics_process(delta):
	
	movement(delta)
	
#--- Управление ---#
func movement(delta):
	var move_dir = 0
	var grounded = is_on_floor()

	### Перемещение по горизонтали ###
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
	### Перемещение по горизонтали ###
	
	### Прыжок ###
	y_velo += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		y_velo = -JUMP_FORCE
	if grounded and y_velo >= 0:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
	### Прыжок ###
	
	### Отражает спрайт по горизонтали ###
	if facing_right and move_dir < 0:
		flip()
	if !facing_right and move_dir > 0:
		flip()
	### Отражает спрайт по горизонтали ###
	
	if grounded:
		if move_dir == 0:
			play_anim("idle")
		else:
			play_anim("walk")
			
	else:
		play_anim("jump")
#--- Управление ---#


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
		



